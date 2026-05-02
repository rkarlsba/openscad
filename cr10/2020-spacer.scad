// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

include <BOSL2/std.scad>
include <BOSL2/screws.scad>;

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

height=9.2;
r_inner = 2.5;
r_outer = r_inner+1;
base = [40, 20, 1.2];
holes = 2;

render(convexity=10) {
    difference() {
        union() {
            cube(base);
            translate([base[0]/4,base[1]/2,base[2]]) {
                cylinder(r=r_outer, h=height-base[2]);
            }
            translate([base[0]/4*3,base[1]/2,base[2]]) {
                cylinder(r=r_outer, h=height-base[2]);
            }
        }
        translate([base[0]/4,base[1]/2,0]) {
            cylinder(r=r_inner, h=height);
        }
        translate([base[0]/4*3,base[1]/2,0]) {
            cylinder(r=r_inner, h=height);
        }
    }
}
