// Pakkelapp

use <ymse.scad>
// use <fontmetrics.scad>

$fn = $preview ? 8 : 64;

xsize = 47;
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

name = "Bebe";

// textlength = measureText(name, font=fonttype, size=fontsize, spacing=fontspacing);
// echo(textlength);

// xsz = textlength ? textlength+12 : xsize;
xsz = xsize;

difference() {
    hull() {
        linear_extrude(label_thickness/3)
            roundedsquare([xsz,ysize], corner_rounding);
        translate([label_thickness,label_thickness,label_thickness/3])
            linear_extrude(label_thickness/3*5)
                roundedsquare([xsz-label_thickness*2,ysize-label_thickness*2], corner_rounding);
    }
    translate([label_thickness+line,label_thickness+line,label_thickness])
        linear_extrude(label_thickness+bugaddition)
            roundedsquare([xsz-label_thickness*2-line*2,ysize-label_thickness*2-line*2], corner_rounding);
    translate([corner_rounding*1.5,ysize-corner_rounding*1.5,-bugaddition]) {
        cylinder(r=hole_radius,h=label_thickness+bugaddition*2);
    }
}

translate([6,ysize/3,label_thickness]) {
    linear_extrude(text_thickness)
        text(name, size=fontsize, font=fonttype);
}
