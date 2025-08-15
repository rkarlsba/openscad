// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Missing separator walls for drawers in the Clas Ohlson parts cabinet /
// organizer cabinet, parts no 31-2376, 31-2375 and others. The cabinet drawers
// are fine, but they're missing slots for separator walls. The drawers are
// 136mm deep and if divided completely, their compartments end up 44.5mm,
// 21.5mm, 21.5mm and 44.5mm, respectivelty, meaning there should be room for
// two more, but alas, slots are missing. This is an attempt to remedy just this.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY v4.0 or later. Please see
// https://creativecommons.org/licenses/by/4.0/ for details.
//

$fn = 32;

default_debug = false;

default_x = 50.5;
default_y = 34;
default_z = 1.5;
default_r1 = 2;
default_r2 = 2;

// If use_chamfer, then chamfer the separators instead of rounding them off.
// Basically, I doubt you'll see much difference unless you round off those
// corners a _lot_.
use_chamfer = 0;
chamfer_size = 1;

module separator_wall(x = default_x, y = default_y, z = default_z,
                      r1 = default_r1, r2 = default_r2,
                      use_chamfer = use_chamfer,
                      chamfer_size = chamfer_size,
                      debug = default_debug) {
    if (use_chamfer) {
        if (debug) {
            echo(str("Using chamfer, r1 = ", r1, ", r2 = ", r2));
        }
        hull() {
            linear_extrude(.5)  {
                translate([r1, r1, r1]) {
                    circle (r1);
            }
                translate([x-r1, r1, r1]) {
                    circle (r1);
                }
                translate([r2, y-r2, r2]) {
                    circle (r2);
                }
                translate([x-r2, y-r2, r2]) {
                    circle (r2);
                }
            }
            translate([0, 0, 1]) {
                linear_extrude(.5)  {
                    translate([r1+chamfer_size, r1+chamfer_size, r1]) {
                        circle (r1);
                    }
                    translate([x-r1-chamfer_size, r1+chamfer_size, r1]) {
                        circle (r1);
                    }
                    translate([r2+chamfer_size, y-r2-chamfer_size, r2]) {
                        circle (r2);
                    }
                    translate([x-r2-chamfer_size, y-r2-chamfer_size, r2]) {
                        circle (r2);
                    }
                }
            }
        }
    } else {
        scale([1, 1, .5]) {
            hull() {
                my_z = default_z/2;
                if (debug) {
                    echo(str("Rounding off, r1 = ", r1, ", r2 = ", r2, " and my_z is ", my_z));
                }
                translate([r1, r1, 0])
                {
                    scale([1, 1, my_z]) {
                        sphere (r1);
                    }
                }
                translate([x-r1, r1, 0])
                {
                    scale([1, 1, my_z]) {
                        sphere (r1);
                    }
                }
                translate([r2, y-r2, 0])
                {
                    scale([1, 1, my_z]) {
                        sphere (r2);
                    }
                }
                translate([x-r2, y-r2, 0])
                {
                    scale([1, 1, my_z]) {
                        sphere (r2);
                    }
                }
            }
        }
    }
}

// translate([default_z,0,0])
{
// rotate([0,270,0])
{
    separator_wall();
}
}
