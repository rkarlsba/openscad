// ymse.scad
//
// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=120
//
// Ymse: Norwegian word, ['ymsɘ], meaning "diverse" or "various")
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net>

// Bloody OpenSCAD has no idea about what a global variable might be and
// noone seems to care, but functions work.
//function pi() = 3.141592653589793; // too few decimals!
function pi() = 3.14159265358979323846264338327950288419716939937510;
function e() = 2.718281828459045;

// Colours - all in RGB, as to be passed to rgb()
function c_red() = "#ff0000";
function c_orange() = "#ff8000";
function c_yellow() = "#ffff00";
function c_green() = "#00ff00";
function c_blue() = "#0000ff";
function c_indigo() = "#4b0082"; // '75, 0, 130';
function c_purple() = "#ff00ff";

// Various modules
module xor(){
    difference(){
        union(){
            children(0);
            children(1);
        };
        intersection(){
            children(0);
            children(1);
        }
    }
}

/*
 * rgb(), like color(), except it takes an array of values 0-255,
 * resembling the values used in HTML/CSS/etc. For example: 
 *
 * rgb([0x80, 0x40, 0xff]) cube([10,10,10]);
 */
module rgb(colour) {
    color(colour/255) {
        children();
    }
}

module roundedsquare(size, radius) {
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([radius, radius]) {
                circle(r=radius);
            }
            translate([size[0]-radius, radius]) {
                circle(r=radius);
            }
            translate([radius, size[1]-radius]) {
                circle(r=radius);
            }
            translate([size[0]-radius, size[1]-radius]) {
                circle(r=radius);
            }
        }
    }
}

module roundedcube(dim, r) {
    linear_extrude(dim[2]) {
        roundedsquare([dim[0], dim[1]], r);
    }
}

/* gammel module roundedcube(size, radius) {{{
 * Denne er avrunda overalt og er gir i tillegg feil størrelse ut
module roundedcube(size, radius) {
    if (radius == 0) {
        cube(size);
    } else {
        translate([radius,radius,radius]) {
            hull() {
                for (z = [0, size[2]-radius*2]) {
                    translate([0, 0, z]) {
                        sphere(r=radius);
                    }
                    translate([size[0]-radius*2, 0, z]) {
                        sphere(r=radius);
                    }
                    translate([0, size[1]-radius*2, z]) {
                        sphere(r=radius);
                    }
                    translate([size[0]-radius*2, size[1]-radius*2, z]) {
                        sphere(r=radius);
                    }
                }
            }
        }
    }
}
}}} */

// r[adius], h[eight], [rou]n[d]
// roundedcylinder(r=10,h=30,n=.5,$fn=200);
module roundedcylinder(r,h,n) {
    rotate_extrude(convexity=1) {
        offset(r=n) {
            offset(delta=-n) {
                square([r,h]);
            }
        }
        square([n,h]);
    }
}


module flat_heart(size) {
    intsize = size/pi*2;
    rotate([0,0,45]) {
        square(intsize);
        translate([intsize/2, intsize, 0]) {
            circle(intsize/2, $fn=32);
        }

        translate([intsize, intsize/2, 0]) {
            circle(intsize/2, $fn=32);
        }
    }
}

module ramme(size, border=1) {
    difference() {
        square(size);
        translate([border,border]) {
            square([size[0]-border*2,size[1]-border*2]);
        }
    }
}

module skruehull(diameter, lengde, innsenkning = 0) {
    cylinder(d = diameter, h = lengde);
    if (innsenkning != 0) {
        translate([0, 0, lengde-innsenkning]) {
            cylinder(h=innsenkning, d1=diameter, d2=diameter+innsenkning);
        }
    }
}

// Warn users including this with 'include' without knowing better
assert("Don't 'include' this if you just want to use its modules etc. Better 'use' it.");

//roundedcube([40,40,10], 2, $fn=16);
/*
// lalalatest
linear_extrude(height = 13)
    flat_heart(27);
*/

//flat_heart(10);

// a:angle, r:radius, h:height
module pie_slice(a, r, h){
  rotate_extrude(angle=a) {
    square([r,h]);
  }
}

// Create a countersunk screw hole with the bottom (smallest) height of g1 and ditto diameter of d1
module countersunk_screw_hole(h1, d1, h2, d2) {
}

