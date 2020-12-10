include <honeycomb/honeycomb.scad>

/*
 * Set these in file including this one
 * 
 * outer_diameter=99;
 * border_diameter=outer_diameter+10;
 * inner_diameter=65;
 * thickness=1;
 * honeycomb_dia = 10;
 */

module rist() {
    intersection() {
        translate([-outer_diameter/2,-outer_diameter/2,0]) {
            linear_extrude(1) {
                honeycomb(outer_diameter, outer_diameter, honeycomb_dia, 1);
            }
        }
        cylinder(d=outer_diameter,h=thickness);
    }
}

// Austre
module austre() {
    translate([outer_diameter/2,-3,thickness]) {
        difference() {
            cube([5,6,12]);
            translate([-3,6,6])
                rotate([90,0,0])
                    cylinder(r=6,h=6);
        }
    }
}

// Vestre
module vestre() {
    translate([-outer_diameter/2-5,-3,thickness]) {
        difference() {
            cube([5,6,12]);
            translate([8,+6,6])
                rotate([90,0,0])
                    cylinder(r=6,h=6);
        }
    }
}

// Nordre
module nordre() {
    translate([-3,outer_diameter/2-1,thickness]) {
        difference() {
            cube([5,6,12]);
            translate([6,-2,6])
                rotate([90,0,-90])
                    cylinder(r=6,h=6);
        }
    }
}

module lampefilter(type) {
    difference() {
        cylinder(d=border_diameter,h=thickness);
        cylinder(d=outer_diameter,h=thickness);
    }

    if (type == "midtfilter") {
        difference() {
            rist();
            cylinder(d=inner_diameter,h=thickness);
        }

        cylinder(d=inner_diameter,h=thickness/2);
    } else if (type == "gitter") {
        rist();
    } else {
        echo("Ukjent type ", type);
    }
}
