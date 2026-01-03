// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Variables
width=330;
height=230;
thickness=2.5;
corner_r_top=43;
corner_r_btm=32;
airhole_r=12.5;

// Skruer
skrue_r = 1.7;
skrue_pos = [
    [15,25],
    [280,7],
    [105,223],
    [270,223]
];

// Code
linear_extrude(thickness) {
    difference() {
        // Bakplate
        hull() {
            translate([corner_r_btm, corner_r_btm]) {
                circle(r=corner_r_btm);
            }
            translate([width-corner_r_btm, corner_r_btm]) {
                circle(r=corner_r_btm);
            }
            translate([corner_r_top, height-corner_r_top]) {
                circle(r=corner_r_top);
            }
            translate([width-corner_r_top, height-corner_r_top]) {
                circle(r=corner_r_top);
            }
        }

        // Luftehøl (som om den trenger det, da)
        for (x=[airhole_r*3:airhole_r*4:width-airhole_r*2]) {
            for (y=[airhole_r*3:airhole_r*4:height-airhole_r*2]) {
                translate([x,y]) {
                    circle(r=airhole_r);
                }
            }
        }

        // Skruehøl
        for (pos = skrue_pos) {
            echo(str("Drille i posisjon ", pos));
            translate(pos) {
                circle(r=skrue_r);
            }
        }
    }
}
