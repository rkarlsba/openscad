/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */
use <ymse.scad>

$fn = $preview ? 64 : 256;
bugfix = $preview ? .1 : 0;

// lid_filename = "USB Micro Breakout lid-ascii.stl";
lid_filename = "USB Micro Breakout lid-centered.stl";
mount_filename = "USB Micro Breakout mount-ascii.stl";
ext_size = [23.0, 18.8, 2.0];
top_hole_r = 1.8;
hole_pos = [[8.5+top_hole_r/2, 5, -bugfix],[8.5+top_hole_r/2, ext_size[1]-5, -bugfix]];
bottom_hole_r = 1.5;
rounding_r = 2.0;

echo(str("hole_pos is ", hole_pos));

difference() {
    roundedcube(ext_size, rounding_r);
    for (i = [0 : len(hole_pos) - 1]) {
        translate(hole_pos[i]) {
            cylinder(r = top_hole_r, h = ext_size[2]+bugfix*2);  // Adjust as needed
        }
    }
}

// Referanse
// translate([0,-ext_size[1]*1.1,0]) {
translate([0,0,-.5]) {
    color("#ffa050") {
        import(lid_filename);
    }
}
