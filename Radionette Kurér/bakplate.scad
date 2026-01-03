// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

include <ymse.scad>

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Variables
width=330;
height=230;
thickness=2;
corner_r=40;
airhole_r=12.5;

// Code
linear_extrude(thickness) {
    difference() {
        roundedsquare([width, height], corner_r);
        for (x=[airhole_r*3:airhole_r*4:width-airhole_r*2]) {
            for (y=[airhole_r*3:airhole_r*4:height-airhole_r*2]) {
                translate([x,y]) {
                    circle(r=airhole_r);
                }
            }
        }
    }
}
