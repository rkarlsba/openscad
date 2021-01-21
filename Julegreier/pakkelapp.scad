// Pakkelapp

use <ymse.scad>


$fn = $preview ? 8 : 64;

xsize = 60;
ysize = 30;
corner_rounding = 4;
line = 1;
hole_radius = 2.5;
label_thickness = 1;
text_thickness = 1;
fontsize=12.5;
fonttype="Apple Chancery:style=筆寫斜體";
//fonttype="Liberation Sans";
fontspacing=1;
bugaddition = $preview ? 0.1 : 0;

name = "Doggie";

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
    translate([corner_rounding*1.5,ysize-corner_rounding*1.5,-bugaddition]) {
        cylinder(r=hole_radius,h=label_thickness+bugaddition*2);
    }
}

translate([6,ysize/3,label_thickness]) {
    linear_extrude(text_thickness)
        text(name, size=fontsize, font=fonttype);
}
