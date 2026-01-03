#!/usr/bin/env bash
set -euo pipefail

SCAD_FILE="RadiusGauge.scad"

for mm in $(seq 1 50); do
  out="RadiusGauge-$(printf '%02d' "$mm").stl"

  # Pass variables via -D and export to STL via -o:
  openscad \
    -D "minsize=${mm}" \
    -D "maxsize=${mm}" \
    -D "step=1" \
    -o "$out" \
    "$SCAD_FILE"

  echo "✓ built $out"
done

