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
        text("Velkommen til", size=fontsize, font=fonttype);
    }
}
translate([12,50,label_thickness]) {
    linear_extrude(text_thickness) {
        text("Roys", size=fontsize*1.4, font=fonttype);
    }
}
translate([60,30,label_thickness]) {
    rotate([0,0,4]) {
        linear_extrude(text_thickness) {
            text("rare", size=fontsize*1.4, font=fonttype);
        }
    }
}
translate([102,20,label_thickness]) {
    rotate([0,0,-12]) {
        linear_extrude(text_thickness) {
            text("rot", size=fontsize*1.4, font=fonttype);
        }
    }
}
translate([17,40,label_thickness])
    linear_extrude(text_thickness) 
        polygon([
            [0,0],[15,-1],[17,-10],[24,-11],[25,-22],[36,-22],[36.5,-30],[43,-30],
            [43,-31],[35.5,-31],[35.5,-23],[24,-23],[23.5,-12],[15.7,-11],[14,-2],[-1,-1]
        ]);
//[0,1],[15,1],[15,0]]);
//translate([8,35,label_thickness]) cube([15,line,text_thickness]);
//translate([25,25,label_thickness]) cube([15,line,text_thickness]);
//translate([28,15,label_thickness]) cube([15,line,text_thickness]);







