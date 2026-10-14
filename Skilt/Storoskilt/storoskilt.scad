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
// Variables {{{

corners = 8;
height = 1.5;
shrink = height;
bottom_size = [100,110];
top_size = [bottom_size[0]-shrink*2,bottom_size[1]-shrink*2];
use_border = true;
border_width = 1;
border_height = 1;
use_holes = true;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;

// }}}
// module rounded_square() {{{

module rounded_square(size, radius) {
    translate([radius,radius]) {
        minkowski() {
            square([size[0] - 2*radius, size[1] - 2 * radius]);
            circle(r=radius, $fn=50);
        }
    }
}

// }}}
// module rounded_cube() {{{

module rounded_cube(size, radius, height) {
    linear_extrude(height) {
        rounded_square(size, radius);
    }
}

// }}}
// module border() {{{

module border() {
    translate([shrink,shrink,height]) {
        difference() {
            rounded_cube(size=top_size, radius=corners, border_height);
            translate([border_width,border_width,0]) {
                rounded_cube(size=[top_size[0]-border_width*2,
                    top_size[1]-border_width*2],
                    radius=corners, border_height);
            }
        }
    }
}

// }}}
// module bunnplate() {{{

module bunnplate() {
    hull() {
        rounded_cube(size=bottom_size,radius=corners, .1);
        translate([shrink,shrink,height]) {
            rounded_cube(size=top_size,radius=corners, .1);
        }
    }
    if (use_border) {
        border();
    }
}

// }}}
// module holes() {{{

module holes(hole_dist, hole_d, hole_h) {
    translate([hole_dist,bottom_size[1]-hole_dist,0]) {
        cylinder(d=hole_d,h=hole_h);
    }
    translate([bottom_size[0]-hole_dist,
        bottom_size[1]-hole_dist,]) {
        cylinder(d=hole_d,h=hole_h);
    }
}

// }}}
// main() {{{

render() {
    difference() {
        bunnplate();
        if (use_holes) { 
            holes(hole_dist, hole_d, hole_h);
        }
    }
}

// }}}

