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

bugfuck = $preview ? .1 : 0;

// Sanity check
draw_count = b2i(draw_stone_bottom) + b2i(draw_frame_bottom) + b2i(draw_stone_top) + b2i(draw_frame_top);
assert(draw_count == 1, str("draw count is ", draw_count, " and it should be 1"));

// Stone first
if (draw_stone_bottom) {
    difference() {
        import(stone_filename);
        translate([0,0,-bugfuck]) {
            scale(krymp) {
                translate([0,0,-5]) {
                    import(stone_filename);
                }
            }
            translate([-alutubedim[0]/2,-alutubedim[1]/2,0]) {
                cube(alutubedim);
            }
        }
    }
}

if (draw_frame_bottom) {
    translate([100,0,0]) {
        import(frame_filename);
    }
}
