// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Make the varla stone holey and add a square hole to the top through which we'll ram a 10x10mm
// square alu tube for LED mounting, cooling and cable housing.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//

// Functions
function b2i(b) = b ? 1 : 0;

// Variables
frame_filename = "varla_frame_bottom-r2.obj";
stone_filename = "varla_stone_bottom.obj";

alutubedim = [10.5,10.5,200];
krymp = [.97,.97,.97];

draw_stone_bottom = true;
draw_frame_bottom = false;
draw_stone_top = false;
draw_frame_top = false;

top_d = 28.5;
top_mid_d = 40.5;
bottom_mid_d = 66.5;
bottom_d = 82.5;

top_h = 130.25;
top_mid_h = 90.0;
bottom_mid_h = 28.75;
screw1_z = top_h - (top_h - top_mid_h) / 4;
screw2_z = top_h - (top_h - top_mid_h) / 4 * 3;

screw_d = 3.2;

plug_h = 30;

thickness = 1;

bugfix = $preview ? .1 : 0;

debug = true;

// Sanity check
draw_count = b2i(draw_stone_bottom) + b2i(draw_frame_bottom) + b2i(draw_stone_top) + b2i(draw_frame_top);
assert(draw_count == 1, str("draw count is ", draw_count, " and it should be 1"));

// Debug
if (debug) {
    echo(str("DEBUG: top_h is ", top_h, ", top_mid_h is ", top_mid_h, ", screw1_z is ", screw1_z, " and screw2_z is ", screw2_z));
}

// Stone first
module stone() {
    if (draw_stone_bottom) {
        difference() {
            import(stone_filename);

            translate([0,0,-bugfix]) {
                scale(krymp) {
                    translate([0,0,-5]) {
                        import(stone_filename);
                    }
                }
            }
        }
    }

    if (draw_frame_bottom) {
        translate([100,0,0]) {
            import(frame_filename);
        }
    }

    translate([0,0,top_mid_h]) {
        color("red") {
            cylinder(d1=top_mid_d, d2=top_d, h=top_h-top_mid_h);
        }
    }
}

module holey_stone(screws = true) {
    difference() {
        stone();

        // Square tube
        translate([-alutubedim[0]/2,-alutubedim[1]/2,0]) {
            cube(alutubedim);
        }

        // Screw holes
        if (screws) {
            translate([0, 0, screw1_z]) {
                rotate([90,0,0]) {
                    cylinder(d = screw_d, h = top_d, $fn = 50);
                }
            }
            translate([0, 0, screw2_z]) {
                rotate([90,0,0]) {
                    cylinder(d = screw_d, h = top_d, $fn = 50);
                }
            }
        }
    }
}

holey_stone();

