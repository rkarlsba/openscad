
#!/usr/bin/env bash
set -euo pipefail

# Defaults
SCAD_FILE="RadiusGauge.scad"
OUT_DIR="stl"
FORCE=0
START=1
END=50
STEP=1

usage() {
  cat <<EOF
Usage: $(basename "$0") [options]

Options:
  -f, --force           Rebuild even if output files already exist
  -s, --scad FILE       Path to the .scad file (default: ${SCAD_FILE})
  -o, --out DIR         Output directory for STL files (default: ${OUT_DIR})
  --start N             Start value (default: ${START})
  --end N               End value (default: ${END})
  --step N              Step value for the loop (default: ${STEP})
  -h, --help            Show this help

Behavior:
  For each mm in [start..end] stepping by --step, the script sets:
    minsize=mm, maxsize=mm, step=1
  and exports:
    OUT_DIR/RadiusGauge-XX.stl

Examples:
  $(basename "$0")
  $(basename "$0") --force
  $(basename "$0") --start 5 --end 20 --step 1 -s MyGauge.scad -o build
EOF
}

# --- Simple option parser (portable, no external getopt requirement) ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--force)
      FORCE=1; shift ;;
    -s|--scad)
      [[ $# -ge 2 ]] || { echo "ERROR: --scad needs a file path" >&2; exit 2; }
      SCAD_FILE="$2"; shift 2 ;;
    -o|--out)
      [[ $# -ge 2 ]] || { echo "ERROR: --out needs a directory path" >&2; exit 2; }
      OUT_DIR="$2"; shift 2 ;;
    --start)
      [[ $# -ge 2 ]] || { echo "ERROR: --start needs a number" >&2; exit 2; }
      START="$2"; shift 2 ;;
    --end)
      [[ $# -ge 2 ]] || { echo "ERROR: --end needs a number" >&2; exit 2; }
      END="$2"; shift 2 ;;
    --step)
      [[ $# -ge 2 ]] || { echo "ERROR: --step needs a number" >&2; exit 2; }
      STEP="$2"; shift 2 ;;
    -h|--help)
      usage; exit 0 ;;
    --) # end of options
      shift; break ;;
    -*)
      echo "ERROR: Unknown option: $1" >&2
      usage; exit 2 ;;
    *)
      # Positional args not expected; break or collect if needed
      echo "ERROR: Unexpected positional argument: $1" >&2
      usage; exit 2 ;;
  esac
done

# --- Validations ---
if ! command -v openscad >/dev/null 2>&1; then
  echo "ERROR: 'openscad' not found in PATH." >&2
  exit 127
fi

if [[ ! -f "$SCAD_FILE" ]]; then
  echo "ERROR: SCAD file not found: $SCAD_FILE" >&2
  exit 2
fi

if ! mkdir -p "$OUT_DIR"; then
  echo "ERROR: Could not create output directory: $OUT_DIR" >&2
  exit 2
fi

# Ensure numeric loop params
re_number='^-?[0-9]+$'
for v in "$START" "$END" "$STEP"; do
  if ! [[ $v =~ $re_number ]]; then
    echo "ERROR: start/end/step must be integers (got: $v)" >&2
    exit 2
  fi
done
if [[ $STEP -eq 0 ]]; then
  echo "ERROR: --step must not be zero" >&2
  exit 2
fi

# --- Build loop ---
# Supports ascending or descending ranges depending on START/END sign of STEP
if (( (END - START) * STEP < 0 )); then
  echo "ERROR: The sign of --step does not move from start toward end" >&2
  exit 2
fi

echo "SCAD: $SCAD_FILE"
echo "OUT : $OUT_DIR"
echo "RANGE: ${START}..${END} step ${STEP}"
echo "FORCE: $FORCE"
echo

mm=$START
while :; do
  out="$OUT_DIR/RadiusGauge-$(printf '%03d' "$mm").stl"

  if [[ -f "$out" && $FORCE -eq 0 ]]; then
    echo "↷ skip (exists): $out"
  else
    echo "→ building: $out"
    openscad \
      -D "minsize=${mm}" \
      -D "maxsize=${mm}" \
      -D "step=1" \
      -o "$out" \
      "$SCAD_FILE"
    echo "✓ built $out"
  fi

  # increment and termination
  mm=$((mm + STEP))
  if (( (STEP > 0 && mm > END) || (STEP < 0 && mm < END) )); then
    break
  fi
done

