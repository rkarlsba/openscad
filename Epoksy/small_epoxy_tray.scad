// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
//
// Small tray made for mixing epoxy for smaller jobs. Print in any colour or filament, although
// some say it's wise to avoid PLA since epoxy gets hot, but then, you hardly use these again
// anyway.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025 with some good help
// from perplexity.ai to do the trapezoid stuff, which I didn't understand. It couldn't fix the
// rest, like making the bottom thicker and fixing the code.
//
// Licensed under Creative Commons BY-NC-SA v4.0 or later. Please see
// https://creativecommons.org/licenses/by-nc-sa/4.0/ for details.

// Parameters
wall_thickness = 1;
height = 8;
top_size = 40;
bottom_size = 35;
extra_bottom_thickness = .5;
bugfix = $preview ? .1 : 0;

// Outer shell with absolute coordinates (origin at bottom corner)
module trapezoid_shell(top_len, bottom_len, height) {
    hull() {
        // Bottom square at z = bottom_thickness (starting just above bottom plate)
        linear_extrude(0.1) {
            square([bottom_len, bottom_len]);
        }
        // Top square at z = height, properly aligned over bottom
        translate([(bottom_len - top_len)/2, (bottom_len - top_len)/2, height]) {
            linear_extrude(0.1) {
                square([top_len, top_len]);
            }
        }
    }
}

// Inner void to subtract (create hollow)
module inner_void(inner_top, inner_bottom) {
    hull() {
        translate([wall_thickness, wall_thickness, wall_thickness+extra_bottom_thickness]) {
            linear_extrude(0.1) {
                square([inner_bottom, inner_bottom]);
            }
        }
        translate([(inner_bottom - inner_top)/2 + wall_thickness, (inner_bottom - inner_top)/2 + wall_thickness, height]) {
            linear_extrude(0.1) {
                square([inner_top, inner_top]);
            }
        }
    }
}

// Final shape
difference() {
    trapezoid_shell(top_size, bottom_size, height-bugfix);
    
    inner_top = top_size - 2 * wall_thickness;
    inner_bottom = bottom_size - 2 * wall_thickness;
    inner_void(inner_top, inner_bottom);
}

