// Skilt til skriveren til Sara
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker

use <ymse.scad>

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

xsize = 30;
ysize = 30;
corner_rounding = 1.5;
line = 0;
hole_radius = 0;
label_thickness = 1;
graphics_thickness = 1;
fontsize=10;
//fonttype="Helvetica";
//fonttype="Liberation Sans";
//fonttype="Avenir Next Condensed";
fonttype="Big Shoulders Stencil 18pt";
scale_to=[28/30,28/30,1];
fontspacing=1;
//tekst = "mintprint.karlsbakk.net";
//tekst = "mintprint.local";
qr_code = "Mattias Jardstål - QR.svg";

render(convexity=10) {
    difference() {
        hull() {
            linear_extrude(label_thickness/3)
                roundedsquare([xsize,ysize], corner_rounding);
            translate([label_thickness,label_thickness,label_thickness/3])
                linear_extrude(label_thickness/3*5)
                    roundedsquare([xsize-label_thickness*2,ysize-label_thickness*2], corner_rounding);
        }

        translate([label_thickness+line,label_thickness+line,label_thickness])
            linear_extrude(label_thickness)
                roundedsquare([xsize-label_thickness*2-line*2,ysize-label_thickness*2-line*2], corner_rounding);

        if (hole_radius > 0) {
            translate([corner_rounding*1.5,ysize-corner_rounding*1.5,0]) {
                cylinder(r=hole_radius,h=label_thickness);
            }
        }
    }

    translate([1,1,label_thickness]) {
        linear_extrude(graphics_thickness) {
            scale(scale_to) {
                import(qr_code);
            }
        }
    }
}

