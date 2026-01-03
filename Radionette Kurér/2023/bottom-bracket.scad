// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Bottom bracket on which an XH-A153 can sit happily

use <ymse.scad>

$fn = $preview ? 32 : 128;
bug = $preview ? .1 : 0;

x = 93;
y = 42;
r = 3;
h = 2;
pillar_r_i = 1.3;
pillar_r_o = 3;
pillar_h = 12;

module main() {
    difference() {
        union() {
            linear_extrude(h) {
                roundedsquare([x,y], r);
            }
            translate([r,r,h]) {
                cylinder(r=pillar_r_o, h=pillar_h);
            }
            translate([x-r,r,h]) {
                cylinder(r=pillar_r_o, h=pillar_h);
            }
            translate([r,y-r,h]) {
                cylinder(r=pillar_r_o, h=pillar_h);
            }
            translate([x-r,y-r,h]) {
                cylinder(r=pillar_r_o, h=pillar_h);
            }
        }
        union() {
            translate([r,r,h]) {
                cylinder(r=pillar_r_i, h=pillar_h+bug);
            }
            translate([x-r,r,h]) {
                cylinder(r=pillar_r_i, h=pillar_h+bug);
            }
            translate([r,y-r,h]) {
                cylinder(r=pillar_r_i, h=pillar_h+bug);
            }
            translate([x-r,y-r,h]) {
                cylinder(r=pillar_r_i, h=pillar_h+bug);
            }
        }
    }
}

main();
