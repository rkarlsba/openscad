/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */
include <ymse.scad>

// Prefix stuff
$fn = $preview ? 64 : 256;
bugfix = $preview ? .1 : 0;

// Variables
outer_dia = 220;
inner_dia = 100;
top_dia = 40;
tube_side = 10;
wall = 3;
height = 60;
inner_height = 40;
block1 = 1;
block2 = 1;
block3 = 1;
block4 = 1;
block5 = 1;

// Code
if (block1) {
    difference() {
        cylinder(d=outer_dia, h=height);
        translate([0,0,wall]) {
            cylinder(d=outer_dia-wall, h=height);
        }
    }
}

if (block2) {
    difference() {
        cylinder(d=inner_dia, h=height+inner_height);
        translate([0,0,inner_height]) {
            cylinder(d=inner_dia-wall, h=height+bugfix);
        }
    }
}

if (block3) {
    translate([0,0,height]) {
        difference() {
            cylinder(d1=outer_dia, d2=top_dia, h=height);
            cylinder(d1=outer_dia-wall, d2=top_dia-wall, h=height-wall);
        }
    }
}

if (block4) {
    translate([-tube_side/2,-tube_side/2,height*2]) {
        cube([10,10,10]);
        /*
        difference() {
            cylinder(d1=outer_dia, d2=top_dia, h=height);
            cylinder(d1=outer_dia-wall, d2=top_dia-wall, h=height-wall);
        }
        */
    }
}

