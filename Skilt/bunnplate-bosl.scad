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

bottom_size = [100, 110];
top_size = [bottom_size[0] - 2*shrink,
            bottom_size[1] - 2*shrink];

border = true;
border_width = 1;
border_height = 1;

holes = true;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;

// }}}

assert(0, "Denne funker heller dårlig! Der den skulle være skifta litt for å sentrere, der blir alt bare krøll. Bruk den gamle!");

// Avrundet rektangel med dimensjoner [x,y] og radius r.
module rounded_profile(size, r) {
    rect([size[0], size[1]], rounding=r);
}

module plate_body() {
    hull() {
        linear_extrude(height=0.1)
            rounded_profile(bottom_size, corners);

        translate([shrink, shrink, height])
            linear_extrude(height=0.1)
                rounded_profile(top_size, corners);
    }

    if (border) {
        translate([shrink/2, shrink/2, height]) {
            linear_extrude(height=border_height)
                difference() {
                    rounded_profile(top_size, corners);
                    offset(delta=-border_width)
                        rounded_profile(top_size, corners);
                }
        }
    }
}

difference() {
    // difference()
    {
        plate_body();
        if (holes) {
            for (x = [hole_dist - bottom_size[0]/2, bottom_size[0]/2 - hole_dist]) {
                y = bottom_size[1]/2 - hole_dist;
                echo(str("x = ", x, " og y = ", y));
                translate([x, y, -0.1]) {
                    color("red") {
                        cylinder(d=hole_d, h=hole_h + 0.2);
                    }
                }
            }
        }
    }
}

/*
render() {
    difference() {
        bunnplate();
        if (holes) {
            translate([hole_dist,bottom_size[1]-hole_dist,-bugfix]) {
                cylinder(d=hole_d,h=hole_h+bugfix*2);
            }
            translate([bottom_size[0]-hole_dist,
                bottom_size[1]-hole_dist,-bugfix]) {
                cylinder(d=hole_d,h=hole_h+bugfix*2);
            }
        }
    }
}
*/
