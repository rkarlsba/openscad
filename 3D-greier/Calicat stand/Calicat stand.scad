// vim modeline {{{
//
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker:tw=120
//
// }}}
// Libraries {{{

include <BOSL2/std.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Calicat stand {{{
//
// Documentation
//
// This makes a stand for four calicats, printed with flow of 100, 80, 60 and 40%. If your slicer calls 'flow' something
// else, like "squirt percentage", "extrusion multiplier" or something else, fee free to use that, but in here, I'll
// call it flow. The number of calicats is set in a variable and the block should resize accordingly.
//
// This is based on the calicat from https://www.printables.com/model/399038-calicat-v2. Others may be used as well.
// I've used the stltool.py from https://github.com/rkarlsba/ymse/blob/master/python/STL/stltool.py to find the
// dimensions of the file, like this:
//
// stltool -i calicat\ v2.stl
//
// STL Info: calicat v2.stl
//   Dimensions: 27.500 x 29.000 x 35.000 mm
//   Min corner: [1.500, -0.000, -0.000]
//   Max corner: [29.000, 29.000, 35.000]
//   Volume: 12483.622 mm³
//   Triangles: 272
//   Vertices: 816
//
// Licensed under CC BY-NC 4.0
// See https://creativecommons.org/licenses/by-nc/4.0/legalcode.en for details
// 
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in a far too cold corner of Oslo in the spring of 2026
//
// }}}
// Variables {{{

filename = "calicat v2.stl";
edge_rounding = 3;
text_height = .4;
font_face = "Geneva";
font_size = 7.5;
space_front = 12;
space_back = 0;
space_between = 7;
calicat_dim = [27.5, 29, 35];
calicat_shape = [ [0, 0], [21, 0], [21, 22], [13.5, 22], [13.5, 32], [0, 32] ];
calicat_count = 4;
calicat_stand = [calicat_dim[0] * calicat_count + space_front + space_back + space_between*calicat_count-1, calicat_dim[1] * 2, calicat_dim[2] / 2];

// }}}
// Mascot {{{

translate([-calicat_dim[0]*sqrt(2), 0, 0]) {
    import(filename);
}

// }}}
// Code {{{

render(convexity=10) { // Make preview behave correctly
    difference() {
        union() {
            cuboid(calicat_stand, anchor=FRONT+LEFT+BOT, rounding=edge_rounding,
                edges=[TOP+FRONT,TOP+RIGHT,TOP+LEFT,FRONT+RIGHT,FRONT+LEFT]);
        }
        for (i = [0:calicat_count-1]) {
            translate([calicat_dim[0]*i+space_between*i+space_front, calicat_dim[1]/sqrt(2), calicat_dim[2] / 4]) {
                linear_extrude(calicat_dim[2] / 4) {
                    polygon(calicat_shape);
                }
            }
        }
    }
    // Text
    /* drit {{{
    for (i = [0:calicat_count-1]) {
        pst = str(100-i*20, "%");
        translate([calicat_dim[0]*i+space_between*i*len(pst)/2.4+space_front/2, edge_rounding*2, calicat_stand[2]]) {
            linear_extrude(text_height) {
                //text(text="100%", font=font_face, size=10);
                text(text=pst, font=font_face, size=font_size);
            }
        }
    }
    }}} */
    translate([8, edge_rounding*2, calicat_stand[2]]) {
        linear_extrude(text_height) {
            text(text="100%  80%   60%    40%", font=font_face, size=font_size);
        }
    }
}

// }}}
// test {{{

// translate([0, -40, 0]) {
//     minkowski() {
//         cube([10,20,30]);
//         sphere(r=2);
//     }
// }
// }}}
