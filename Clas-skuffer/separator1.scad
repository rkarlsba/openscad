// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Test
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY-NC-SA v4.0 or later. Please see
// https://creativecommons.org/licenses/by-nc-sa/4.0/ for details.
//

//include <ymse.scad>

$fn = 32;

x = 50.5;
y = 34;
z = 1.5;
r1 = 2;
r2 = 2;
chamfer = 1;
use_chamfer = 0;

if (use_chamfer) {
    hull() {
        linear_extrude(.5)  {
            translate([r1,r1,r1]) circle (r1);
            translate([x-r1,r1,r1]) circle (r1);
            translate([r2,y-r2,r2]) circle (r2);
            translate([x-r2,y-r2,r2]) circle (r2);
        }
        translate([0,0,1]) {
            linear_extrude(.5)  {
                translate([r1+chamfer,r1+chamfer,r1]) circle (r1);
                translate([x-r1-chamfer,r1+chamfer,r1]) circle (r1);
                translate([r2+chamfer,y-r2-chamfer,r2]) circle (r2);
                translate([x-r2-chamfer,y-r2-chamfer,r2]) circle (r2);
            }
        }
    }
} else {
    scale([1,1,.75]) {
        hull() {
            my_z = 1/r1;
            translate([r1,r1,my_z]) scale([1,1,my_z]) sphere (r1);
            translate([x-r1,r1,my_z]) scale([1,1,my_z]) sphere (r1);
            translate([r1,y-r1,my_z]) scale([1,1,my_z]) sphere (r1);
            translate([x-r1,y-r1,my_z]) scale([1,1,my_z]) sphere (r1);
        }
    }
}
