$fn = $preview ? 16 : 128;

include <lampefilter.scad>

outer_diameter=99;
border_diameter=outer_diameter+10;
thickness=1;
honeycomb_dia = 3;
honeycomb_wall = 0.5;

lampefilter("gitter");
/*
module rist() {
    intersection() {
        translate([-outer_diameter/2,-outer_diameter/2,0]) {
            linear_extrude(1) {
                honeycomb(outer_diameter, outer_diameter, honeycomb_dia, honeycomb_wall);
            }
        }
        cylinder(d=outer_diameter,h=thickness);
    }
}

rist();

difference() {
    cylinder(d=border_diameter,h=thickness);
    cylinder(d=outer_diameter,h=thickness);
}


// Austre
translate([outer_diameter/2,-3,thickness]) {
    difference() {
        cube([5,6,12]);
        translate([-3,6,6])
            rotate([90,0,0])
                cylinder(r=6,h=6);
    }
}
// Vestre
translate([-outer_diameter/2-5,-3,thickness]) {
    difference() {
        cube([5,6,12]);
        translate([8,+6,6])
            rotate([90,0,0])
                cylinder(r=6,h=6);
    }
}
// Nordre
translate([-3,outer_diameter/2-1,thickness]) {
    difference() {
        cube([5,6,12]);
        translate([6,-2,6])
            rotate([90,0,-90])
                cylinder(r=6,h=6);
    }
}
*/