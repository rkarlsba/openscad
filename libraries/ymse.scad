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

// Halvrundet firkant med valgbar flatside.
// flatside: "left" (default), "right", "top", "bottom"
module roundedsquare_half(size, radius, flatside="left", r0=0.01) {

    // Basis: flat venstreside (beholder din opprinnelige kode mest mulig)
    module _base_left(sz, rad, rsmall) {
        if (rad == 0) {
            square(sz);
        } else {
            hull() {
                // Venstre nederst - liten radius -> "flat" (nesten hjørne)
                translate([rsmall, rsmall]) circle(r=rsmall);
                // Høyre nederst - rundet
                translate([sz[0]-rad, rad]) circle(r=rad);
                // Venstre øverst - liten radius -> "flat"
                translate([rsmall, sz[1]-rsmall]) circle(r=rsmall);
                // Høyre øverst - rundet
                translate([sz[0]-rad, sz[1]-rad]) circle(r=rad);
            }
        }
    }

    // Velg flatside via transformasjoner av basisformen
    if (flatside == "left") {
        // Som originalen
        _base_left(size, radius, r0);

    } else if (flatside == "right") {
        // Speil rundt y-aksen ved x=0 og flytt tilbake til [0, size[0]]
        translate([size[0], 0]) mirror([1, 0, 0]) _base_left(size, radius, r0);

    } else if (flatside == "bottom") {
        // Venstre -> bunn: roter +90° rundt origo, da havner formen i x ∈ [-size[1], 0].
        // Flytt den til positiv x med translate([size[1], 0]).
        translate([size[1], 0]) rotate(90) _base_left([size[1], size[0]], radius, r0);

        // Merk: _base_left bruker kun size-komponentene som koordinater,
        // og selve hullet er invariant under rotasjonen, så vi kan la size stå.
        // For klarhet kan man rotere uten å bytte size, men denne varianten er trygg.

    } else if (flatside == "top") {
        // Venstre -> topp: roter -90° rundt origo, da havner y ∈ [-size[0], 0].
        // Flytt den opp med translate([0, size[0]]).
        translate([0, size[0]]) rotate(-90) _base_left([size[1], size[0]], radius, r0);

    } else {
        assert(false, str("Ugyldig flatside: ", flatside, ". Bruk \"left\", \"right\", \"top\" eller \"bottom\"."));
    }
}

/*
module roundedsquare_half(size, radius, flatside=0) {
    r0 = 0.01;
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([r0, r0]) {
                circle(r=r0);
            }
            translate([size[0]-radius, radius]) {
                circle(r=radius);
            }
            translate([r0, size[1]-r0]) {
                circle(r=r0);
            }
            translate([size[0]-radius, size[1]-radius]) {
                circle(r=radius);
            }
        }
    }
}
*/

module roundedcube(dim, r) {
    linear_extrude(dim[2]) {
        roundedsquare([dim[0], dim[1]], r);
    }
}
/*
 * See roundedsquare_half for an explaination of flatside
 */
module roundedcube_half(dim, r, flatside="left") {
    linear_extrude(dim[2]) {
        roundedsquare_half([dim[0], dim[1]], r, flatside);
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

// Create a countersunk screw hole with a height of h and diameter of d and a counterscrew height of
// ch and a diameter of cd.
module countersunk_screw_hole(h, d, ch, cd, countersunk_bottom=false) {
    if (countersunk_bottom) {
        cylinder(h=h, d=d);
        cylinder(h=ch, d1=cd, d2=d);
    } else {
        cylinder(h=h, d=d);
        translate([0, 0, h-ch]) {
            cylinder(h=ch, d1=d, d2=cd);
        }
    }
}

