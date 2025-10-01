// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Missing separator walls for drawers in the Clas Ohlson / Raaco parts cabinet
// / organizer cabinet, parts no 31-2376, 31-2375 and others. The cabinet
// drawers are fine, but they're missing slots for separator walls. The drawers
// are 136mm deep and if divided completely, their compartments end up 44.5mm,
// 21.5mm, 21.5mm and 44.5mm, respectivelty, meaning there should be room for
// two more, but alas, slots are missing. This is an attempt to remedy just
// this.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY v4.0 or later. Please see
// https://creativecommons.org/licenses/by/4.0/ for details.
//

include <libseparator.scad>

union() {
    translate([default_z/2,0,0]) {
        rotate([90,0,0]) {
            separator_wall(connector_slots = true);
        }
    }
    translate([side_gap,0,0]) {
        cube([default_x-side_gap*2,between_gap/2,default_z]);
    }
    translate([0,between_gap/2,0]) {
        rotate([90,0,0]) {
            separator_wall();
        }
    }
}

