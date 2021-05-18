// Pakkelapp

use <ymse.scad>


$fn = $preview ? 8 : 64;

xsize = 150;
ysize = 100;
corner_rounding = 6;
line = 1;
hole_radius = 0;
label_thickness = 1;
text_thickness = 1;
fontsize=12.5;
fonttype="Apple Chancery:style=筆寫斜體";
//fonttype="Liberation Sans";
fontspacing=1;
bugaddition = $preview ? 0.1 : 0;

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

translate([8,75,label_thickness]) {
    linear_extrude(text_thickness) {
        text("Velkommen til", size=fontsize-1, font=fonttype);
    }
}
translate([17,50,label_thickness]) {
    linear_extrude(text_thickness) {
        text("Roys", size=fontsize*1.4, font=fonttype);
    }
}
translate([66,33,label_thickness]) {
    rotate([0,0,4]) {
        linear_extrude(text_thickness) {
            text("rare", size=fontsize*1.4, font=fonttype);
        }
    }
}
translate([102,18,label_thickness]) {
    rotate([0,0,-12]) {
        linear_extrude(text_thickness) {
            text("rot", size=fontsize*1.4, font=fonttype);
        }
    }
}
translate([20,40,label_thickness])
    linear_extrude(text_thickness) 
        polygon([
            [0,0],[20,-1],
            [21,-10],[35,-11],
            [36,-22],[51,-22],
            [52.5,-30],[80,-32],
            [80,-33],[51.5,-31],
            [50.5,-23],[35,-23],
            [34.5,-12],[19.7,-11],
            [18,-2],[-1,-1]
        ]);
//[0,1],[15,1],[15,0]]);
//translate([8,35,label_thickness]) cube([15,line,text_thickness]);
//translate([25,25,label_thickness]) cube([15,line,text_thickness]);
//translate([28,15,label_thickness]) cube([15,line,text_thickness]);







