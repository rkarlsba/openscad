// Pakkelapp

use <ymse.scad>
use <NoiseLib.scad>
use <smily.scad>

$fn = $preview ? 12 : 64;

xsize = 140;
ysize = 90;
corner_rounding = 6;
line = 1;
hole_radius = 0;
label_thickness = 1;
text_thickness = 1.5;
fontsize=14;
fonttype="Helvetica";
//fonttype="Liberation Sans";
fontspacing=1;
bugaddition = $preview ? 0.1 : 0;

module dot(xy, radius) {
    translate([xy[0], xy[1], label_thickness]) {
        linear_extrude(text_thickness) {
            circle(r=radius);
        }
    }
}

difference() {
    hull() {
        linear_extrude(label_thickness/3)
            roundedsquare([xsize,ysize], corner_rounding);
        translate([label_thickness,label_thickness,label_thickness/3])
            linear_extrude(label_thickness/3*5)
                roundedsquare([xsize-label_thickness*2,ysize-label_thickness*2], corner_rounding);
    }
    translate([label_thickness+line,label_thickness+line,label_thickness])
        linear_extrude(label_thickness+bugaddition)
            roundedsquare([xsize-label_thickness*2-line*2,ysize-label_thickness*2-line*2], corner_rounding);
    if (hole_radius > 0) {
        translate([corner_rounding*1.5,ysize-corner_rounding*1.5,-bugaddition]) {
            cylinder(r=hole_radius,h=label_thickness+bugaddition*2);
        }
    }
}

translate([8,65,label_thickness]) {
    linear_extrude(text_thickness) {
        text("Kaffe på varm", size=fontsize, font=fonttype);
    }
}

translate([8,41,label_thickness]) {
    linear_extrude(text_thickness) {
        text("plate, blir", size=fontsize, font=fonttype);
    }
}

translate([8,12,label_thickness]) {
    linear_extrude(text_thickness) {
        text("SUR!", size=fontsize+4, font=fonttype);
    }
}

translate([106,32,1]) {
    linear_extrude(text_thickness) {
       smily_2d(type = ":(", radius = 20, line_thickness = 2, inverse = true);
    }
}