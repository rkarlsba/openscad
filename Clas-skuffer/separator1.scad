// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Separator walls for drawers in the Clas Ohlson parts cabinet / organizer
// cabinet, part no 31-2376, 31-2375 and others. Parametric, your own choice of
// colour and far cheaper than getting them from Clas Ohlson (currently about
// €5.50 for 15 pcs), like all the other stuff we make :D
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

separator_wall();

