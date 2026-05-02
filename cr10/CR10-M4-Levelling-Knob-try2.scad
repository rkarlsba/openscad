// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

include <BOSL2/std.scad>
include <BOSL2/screws.scad>;

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

height=8.1;
// modscale=[1.4, 1.4, 1.2];
modscale=[1.0, 1.0, 1.0];

filename="CR10_Knob_holes.stl";

module justeringshjul() {
    import(filename);
    cylinder(r1=9, r=7, h=7);
}

render(convexity=10) {
    difference() {
        scale(modscale)
        justeringshjul();
        translate([0,0,-.3]) {
            scale([1.03, 1.03, 1.3]) {
                hull() {
                    nut("M4");
                }
            }
        }
        cylinder(r=2.3, h=modscale[2]*height);
    }
}
