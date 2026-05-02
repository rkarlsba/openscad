// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

include <BOSL2/std.scad>
include <BOSL2/screws.scad>;

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

height=8.1;
modscale=[1.6, 1.6, 1.2];

filename="M3_knurled_levelingKnob-center.stl";
module justeringshjul() {
    import(filename);
    cylinder(r1=6, r2=4, h=8);
}

render(convexity=10) {
    difference() {
        scale(modscale) {
            justeringshjul();
        }
        translate([0,0,-.3]) {
            scale([1, 1, 1.2]) {
                hull() {
                    nut("M4");
                }
            }
        }
        cylinder(r=2, h=modscale[2]*height);
    }
}
