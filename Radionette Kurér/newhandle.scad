// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Readymade
include <ymse.scad>

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Variables
x = 30;
y = 15;
z = 100;
corner_rounding = 5;
hole_r = 1.5;           // Original had 1
hole_depth = 20;        // Original had 15

render(convexity=4) {
    difference() {
        roundedcube([x,y,z], corner_rounding);
        for (this_x = [10,20]) {
            echo(str("this_x is ", this_x));
            translate([this_x,y/2]) {
                cylinder(r=hole_r, h=hole_depth);
                translate([0,0,z-hole_depth]) {
                    cylinder(r=hole_r, h=hole_depth);
                }
            }
        }
    }
}
