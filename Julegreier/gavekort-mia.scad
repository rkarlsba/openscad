// Gavekort

use <ymse.scad>

$fn = $preview ? 8 : 32;

xsize = 148;
ysize = 105;
corner_rounding = 4;
line = 1;
makehole = false;
hole_radius = 2.5;
label_thickness = 1;
text_thickness = 1;
fontsize=12.5;
fonttype="Apple Chancery:style=筆寫斜體";

name = "Mia";

difference() {
    hull() {
        linear_extrude(label_thickness/3)
            roundedsquare([xsize,ysize], corner_rounding);
        translate([label_thickness,label_thickness,label_thickness/3])
            linear_extrude(label_thickness)
                roundedsquare([xsize-label_thickness*2,ysize-label_thickness*2], corner_rounding);
    }
    translate([label_thickness+line,label_thickness+line,label_thickness])
        linear_extrude(label_thickness)
            roundedsquare([xsize-label_thickness*2-line*2,ysize-label_thickness*2-line*2], corner_rounding);
    if (makehole) {
        translate([corner_rounding*1.5,ysize-corner_rounding*1.5,0]) {
            cylinder(r=hole_radius,h=label_thickness);
        }
    }
}

translate([6,0,label_thickness]) {
    linear_extrude(text_thickness) {
        translate([0, 82]) text("Til Mia! God jul!", size=fontsize, font=fonttype);
        translate([2, 67]) text("I mangel på bedre fantasi,", size=fontsize-4, font=fonttype);
        translate([2, 55]) text("har du her et", size=fontsize-4, font=fonttype);
        translate([2, 37]) text("GAVEKORT", size=fontsize+4, font="Copperplate");
        translate([6, 27]) text("på", size=fontsize-4, font=fonttype);
        translate([15, 15]) text("750 PENGER", size=fontsize, font="Copperplate");
        translate([100, 7]) text("…fra Roy", size=fontsize-7, font=fonttype);        
    }
}

