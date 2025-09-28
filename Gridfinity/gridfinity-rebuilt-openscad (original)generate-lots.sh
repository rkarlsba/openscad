#!/bin/bash
# vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

OPTIONS=justprint
LONGOPTS=justprint

# -o "" means no short options; --long only with getopt
PARSED=$(getopt --options= --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
    # getopt returns non-zero on error; display usage and exit
    echo "Usage: $0 [--justprint]"
    exit 2
fi

eval set -- "$PARSED"

justprint=false

while true; do
    case "$1" in
        --justprint)
            justprint=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 3
            ;;
    esac
done

script_name="gridfinity-rebuilt-bins.scad"

# Output folder for STL files
output_dir="stl"
output_format="asciistl" # or "asciistl" # or "binstl"

style_tab='5' # [0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
enable_zsnap='true'

mkdir -p "$output_dir"

# Loop through all grid sizes 1x1 up to 5x5
for x in {1..10}; do
  for y in {1..10}; do
    # Skip cases where x > y to avoid duplicates like 1x5 and 5x1
    if [ "$x" -gt "$y" ]; then
      continue
    fi
    
    # Use defined heights for lids
    for z in 3 6 9; do
      # Construct output filename
      out_file="${output_dir}/bin_without_tab_${x}x${y}x${z}.stl"
      
      if $justprint
      then
          print="echo"
      else
          print=""
      fi
      # Run OpenSCAD to generate STL with parameters
      $print openscad --export-format "$output_format" -o "$out_file" \
          -D "enable_zsnap=$enable_zsnap" -D "style_tab=$style_tab" \
          -D "gridx=$x" -D "gridy=$y" -D "gridz=$z" \
          $script_name
      
      echo "Generated $out_file"
    done
  done
done

