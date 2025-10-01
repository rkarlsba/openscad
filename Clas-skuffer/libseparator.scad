// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Separator walls for drawers in the Clas Ohlson / Raaco parts cabinet /
// organizer cabinet, part no 31-2376, 31-2375 and others. Parametric, your own
// choice of colour and far cheaper than getting them from Clas Ohlson
// (currently about €5.50 for 15 pcs), like all the other stuff we make :D
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY v4.0 or later. Please see
// https://creativecommons.org/licenses/by/4.0/ for details.
//

$fn = 64;

debug = false;

default_x = 49.8;
default_y = 34;
default_z = 1.5;
default_r1 = 2;
default_r2 = 2;

between_gap = 46;
side_gap = 3;

largest_r = max(default_r1, default_r2);

default_connector_slots = false;
default_slot_pos = [default_r1*2,default_r1*2];
default_slot_size = [2,10];

// If use_chamfer, then chamfer the separators instead of rounding them off.
// Basically, I doubt you'll see much difference unless you round off those
// corners a _lot_.
use_chamfer = 0;
chamfer_size = 1;

module separator_wall(x = default_x, y = default_y, z = default_z,
                      r1 = default_r1, r2 = default_r2,
                      use_chamfer = use_chamfer,
                      chamfer_size = chamfer_size,
                      connector_slots = default_connector_slots,
                      slot_pos = default_slot_pos,
                      slot_size = default_slot_size) {

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
            translate([0, 0, z]) {
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
                my_z = z/2;
                scale_z = z/(2*x);
                if (debug) {
                    echo(str("Rounding off, r1 = ", r1, ", r2 = ", r2, ", my_z is ", my_z, " and scale_z is ", scale_z));
                }
                translate([r1, r1, 0]) {
                    scale([1, 1, my_z]) {
                        sphere(r=r1);
                    }
                }
                translate([x-r1, r1, 0]) {
                    scale([1, 1, my_z]) {
                        sphere(r=r1);
                    }
                }
                translate([r2, y-r2, 0]) {
                    scale([1, 1, my_z]) {
                        sphere(r=r2);
                    }
                }
                translate([x-r2, y-r2, 0]) {
                    scale([1, 1, my_z]) {
                        sphere(r=r2);
                    }
                }
            }
        }
    }
}

