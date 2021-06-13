/*
 * Based on https://www.thingiverse.com/thing:1732237
 *
 * Code cleanup for readability and changed to parametric by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 */
use <ymse.scad>

$fn=60; //definition

module box_ext(x = 141.5,y = 72.75*2, z=40, r=5) { //external shape of the box
    roundedcube([x,y,z], r);
/*    hull() {
//        for (i=[-52,89.5],j=[-1,1]) {

        for (i=[0,x],j=[0,1]) {
            translate([i,j*y,0]) {
                cylinder(r=4.75,h=40);
            }
        }
    }
*/
}
module comp1() { //compartiment 1
    minkowski() {
        translate([0,0,26-1.5]) {
            cube([105-6,75-6,40], center=true);
        }
        sphere(d=6);
    }
}
module comp2() { //compartiment 2
    minkowski() {
        translate([0,0,26-1.5]) {
            cube([41-6,151.5-6,40], center=true);
        }
        sphere(d=6);
    }
}
module lid() {
    difference() {
        hull() {
            for (i=[-52,89.5],j=[-1,1]) {
                translate([i,j*72.75,0]) {
                    cylinder(r=6.75,h=10);
                }
            }
        }
        translate([0,0,0.8]) {
            box_ext();
        }
    }
}

module box() {
    difference() {
        box_ext();
        for (i=[-1,1]) {
            translate([-2.5,i*38.25,0]) {
                comp1();
            }
        }
        translate([72,0,0]) comp2(); 
    }
}

box_ext();
*comp1();
*box();
*lid();


