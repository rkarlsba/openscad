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
holey = true;

bottom_frame_filename = "varla_frame_b1.stl";
bottom_stone_filename = "varla_stone_bottom.obj";
// top_frame_filename = "varla_frame_top_fix_v2.obj";
top_frame_filename = "varla_frame_t1.stl";
top_stone_filename = "varla_stone_top.obj.finnes.ikke";

alutubedim = holey ? [10.5,10.5,200] : [0,0,0];
krymp = [.97,.97,.97];

draw_stone_bottom = false;
draw_frame_bottom = true;
draw_stone_top = false;
draw_frame_top = true;
flip_frame_bottom = true;

stone_top_d = 28.5;
stone_top_mid_d = 40.5;
stone_bottom_mid_d = 66.5;
stone_bottom_d = 82.5;

stone_top_h = 130.25;
stone_top_mid_h = 90.0;
stone_bottom_mid_h = 28.75;
stone_screw1_z = stone_top_h - (stone_top_h - stone_top_mid_h) / 4;
stone_screw2_z = stone_top_h - (stone_top_h - stone_top_mid_h) / 4 * 3;

frame_top_h = holey ? 163.2 : 165.7;
frame_screw1_z = 114.6;
frame_screw2_z = frame_screw1_z - (stone_screw1_z - stone_screw2_z);
frame_hole_rot = 80;

screwplate_d = 12;
screwplate_th = 3.2;
screw_d = 3.2;

plug_h = 30;

thickness = 1;

bugfix = $preview ? .1 : 0;

debug = true;

// Sanity check
draw_count = b2i(draw_stone_bottom) + b2i(draw_frame_bottom) + b2i(draw_stone_top) + b2i(draw_frame_top);
assert(draw_count == 1 || flip_frame_bottom, str("draw count is ", draw_count, " and it should be 1"));

// Debug
if (debug) {
    echo(str("DEBUG: stone_top_h is ", stone_top_h, ", stone_top_mid_h is ", stone_top_mid_h,
             ", stone_screw1_z is ", stone_screw1_z, " and stone_screw2_z is ", stone_screw2_z,
             ", frame_screw1_z is ", frame_screw1_z, " and frame_screw2_z is ", frame_screw2_z));
}

// Square tube
module square_tube(dim = alutubedim) {
    translate([-dim[0]/2,-dim[1]/2,0]) {
        cube(dim);
    }
}

// Stone first
module stone() {
    difference() {
        import(bottom_stone_filename);

        translate([0,0,-bugfix]) {
            scale(krymp) {
                translate([0,0,-5]) {
                    import(bottom_stone_filename);
                }
            }
        }
    }

    translate([0,0,stone_top_mid_h]) {
        color("red") {
            cylinder(d1=stone_top_mid_d, d2=stone_top_d, h=stone_top_h-stone_top_mid_h);
        }
    }
}

module holey_stone(screws = true) {
    difference() {
        stone();

        square_tube();

        // Screw holes
        if (screws) {
            translate([0, 0, stone_screw1_z]) {
                rotate([frame_hole_rot,0,0]) {
                    cylinder(d = screw_d, h = stone_top_d, $fn = 50);
                }
            }
            translate([0, 0, stone_screw2_z]) {
                rotate([frame_hole_rot,0,0]) {
                    cylinder(d = screw_d, h = stone_top_d, $fn = 50);
                }
            }
        }
    }
}

module top_frame() {
    scale([1,1,1]) {
        import(top_frame_filename);
    }
}

module bottom_frame() {
    import(bottom_frame_filename);
}

module holey_bottom_frame(screws = true) {
    difference() {
        union() {
            bottom_frame();
            hull() {
                translate([0, -17.6, frame_screw1_z+3]) {
                    rotate([frame_hole_rot,0,0]) {
                        cylinder(d = screwplate_d, h = screwplate_th, $fn = 50);
                    }
                }
                translate([0, -21.2, frame_screw2_z+3]) {
                    rotate([frame_hole_rot,0,0]) {
                        cylinder(d = screwplate_d, h = screwplate_th, $fn = 50);
                    }
                }
            }
        }
        square_tube();

        // Screw holes
        if (screws) {
            translate([0, 0, frame_screw1_z]) {
                rotate([frame_hole_rot,0,0]) {
                    cylinder(d = screw_d, h = stone_top_d, $fn = 50);
                }
            }
            translate([0, 0, frame_screw2_z]) {
                rotate([frame_hole_rot,0,0]) {
                    cylinder(d = screw_d, h = stone_top_d, $fn = 50);
                }
            }
        }
    }
}

if (draw_stone_bottom) {
    if (holey) {
        holey_stone();
    } else {
        stone();
    }
}

if (draw_frame_bottom && !flip_frame_bottom) {
    if (holey) {
        holey_bottom_frame();
    } else {
        bottom_frame();
    }
}

if (draw_frame_bottom && flip_frame_bottom) {
    assert(holey, "I must be holey!!!");
    rotate([180,0,0]) {
        holey_bottom_frame();
    }
    top_frame();
}

// flip_frame_bottom
