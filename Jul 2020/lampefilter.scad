$fn = $preview ? 16 : 128;

include <honeycomb/honeycomb.scad>

outer_diameter=100;
border_diameter=outer_diameter+10;
inner_diameter=65;
thickness=1;

module rist() {
    intersection() {
        translate([-outer_diameter/2,-outer_diameter/2,0]) {
            linear_extrude(1) {
                honeycomb(outer_diameter, outer_diameter, 10, 1);
            }
        }
        cylinder(d=outer_diameter,h=thickness);
    }
}

module tagg() {
    difference() {
        cube([5,6,15]);
        translate([0,0,7.9]) {
            rotate([0,-45,0]) {
                cube([5,6,5]);
            }
        }
    }
}

difference() {
    cylinder(d=border_diameter,h=thickness);
    cylinder(d=outer_diameter,h=thickness);
}

difference() {
    rist();
    cylinder(d=inner_diameter,h=thickness);
}

cylinder(d=inner_diameter,h=thickness/2);

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
