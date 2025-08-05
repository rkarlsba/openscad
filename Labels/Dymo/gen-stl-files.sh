#!/bin/bash
# vim:ts=4:sw=4:sts=4:et:ai:fdm=marker

OUTPUT_DIR='stl'
BASE_FILENAME='dymo-letratag-holder-v4'

for anzahl in {1..6} 10 12
do
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-tray-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=false" -D "which_part=\"bottom\"" $BASE_FILENAME-customizer.scad
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-cover-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=false" -D "which_part=\"top\"" $BASE_FILENAME-customizer.scad
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-tray+cover-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=false" -D "which_part=\"both\"" $BASE_FILENAME-customizer.scad
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-case-top-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=true" -D "which_part=\"top\"" $BASE_FILENAME-customizer.scad
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-case-bottom-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=true" -D "which_part=\"bottom\"" $BASE_FILENAME-customizer.scad
    openscad -o $OUTPUT_DIR/$BASE_FILENAME-case-both-${anzahl}x.stl -D "anzahl=$anzahl" -D "hinges=true" -D "which_part=\"both\"" $BASE_FILENAME-customizer.scad
done

