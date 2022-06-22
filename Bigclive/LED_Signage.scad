// Here's the first of the scripts.  It generates the body of the sign:-
// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker

// Variables {{{
// Sign body maker V3 - bigclivedotcom
letter = "A";       // Sign character to make
style = "Arial";    // See "Help" and "Font List"
size = 50;          // Size of character (height)
depth = 10;         // Depth of sign character
$fn = 100;          // Curve facets - higher is smoother
walls = 2;          // Side wall thickness
base = .4;          // Base thickness (-1 for open back)
face = 1;           // Face thickness
fit = 0.5;          // Slight shrink of face for easier fitting

make_body = true; // Set to true to make body
make_face = true; // Set to true to make face
// }}}
// Draw body {{{
// Don't change variables below here
module body() {
    sized=size-(2*walls);
    difference() {
        linear_extrude(height=depth) {
            minkowski() {
                text(letter,sized,style);
                circle(walls);
            }
        }

        // Lip for front face (half wall thickness)
        translate([0,0,depth-face]) {
            linear_extrude(height=2*face) {
                minkowski() {
                    text(letter,sized,style);
                    circle(walls/2);
                }
            }
        }

        // Hollow core of letter
        translate([0,0,base]) {
            linear_extrude(height=depth+2) {
                text(letter,sized,style);
            }
        }
    }
}
// }}}
// Draw face {{{
// Here's the second script.  It generates the face for the sign:-
// Sign front-face generator V3 - bigclivedotcom
// Don't change variables below here
module face() {
    sized = size-(2*walls);
    linear_extrude(height=face) {
        minkowski() {
            text(letter,sized,style);
            circle((walls/2)-fit/2);
        }
    }
}
// }}}
// Main {{{
if (make_body) {
    body();
}
if (make_face) {
    if (make_body) {
        translate([size,0,0]) {
            face();
        }
    } else {
        face();
    }
}
// }}}
