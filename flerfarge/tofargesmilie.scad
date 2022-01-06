// Pakkelapp

use <ymse.scad>
use <NoiseLib.scad>
use <smily.scad>

$fn = $preview ? 12 : 128;

xsize = 20;
ysize = 20;
corner_rounding = 2;
line = 1;
negativ=1;

if (negativ) {
    linear_extrude(1) translate([xsize/2,ysize/2]) smily_2d(type = ":)", radius = 9, line_thickness = 2, inverse = false);

} else {
    difference() {
        linear_extrude(1) roundedsquare([xsize,ysize], corner_rounding);
        linear_extrude(1) translate([xsize/2,ysize/2]) smily_2d(type = ":)", radius = 9, line_thickness = 2, inverse = false);
    }
}