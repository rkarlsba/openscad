/*
// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=100
 */
use <ymse.scad>

$fn = $preview ? 64 : 256;
bugfix = $preview ? .1 : 0;

lid_filename = "USB Micro Breakout lid.stl";
mount_filename = "USB Micro Breakout mount.stl";
ext_size = [23.0, 18.8, 2.5];
int_size = [20.0, 14.5, 4];
countersinkheight = 1.5;
countersinkwidth = 5.5;
top_hole_r = 1.8;
bottom_hole_r = 1.5;
hole_pos = [[8.5+top_hole_r, 5, -bugfix],[8.5+top_hole_r, ext_size[1]-5, -bugfix]];
rounding_r = 2.0;

referanse = false;
debug = true;
vis_bunn = true;
vis_topp = true;

vis_referanse = referanse || debug;
toppskift = (vis_topp && vis_bunn);

if (debug) {
    echo(str("hole_pos is ", hole_pos));
}

// Create a countersunk screw hole with a height of h and diameter of d and a counterscrew height of
// ch and a diameter of cd.
module countersunk_screw_hole(h, d, ch, cd) {
    echo(str("h = ", h, ", d = ", d, ", ch = ", ch, ", cd = ", cd));
    cylinder(h=h, d=d);
    translate([0, 0, h-ch]) {
        cylinder(h=ch, d1=d, d2=cd);
    }
}

// Top
module topp() {
    difference() {
        roundedcube(ext_size, rounding_r);
        for (i = [0 : len(hole_pos) - 1]) {
            translate(hole_pos[i]) {
                cylinder(r = top_hole_r, h = ext_size[2]+bugfix*2); 
                countersunk_screw_hole(h = ext_size[2]+bugfix*2, d = top_hole_r*2, ch=countersinkheight, cd=countersinkwidth); 
            }
        }
    }
}

// Bottom
module bunn() {
    difference() {
        roundedcube(ext_size, rounding_r);
        for (i = [0 : len(hole_pos) - 1]) {
            translate(hole_pos[i]) {
                cylinder(r = top_hole_r, h = ext_size[2]+bugfix*2); 
                countersunk_screw_hole(h = ext_size[2]+bugfix*2, d = top_hole_r*2, ch=countersinkheight, cd=countersinkwidth); 
            }
        }
    }
}

module referanse_topp() {
    translate([0,-ext_size[1]*1.1,0]) {
        color("#ffa050") {
            import(lid_filename);
        }
    }
}

module referanse_bunn() {
    translate([0,-ext_size[1]*1.1,0]) {
        color("#ffa050") {
            import(mount_filename);
        }
    }
}

// Referanse
if (vis_bunn) {
    bunn();
    if (vis_referanse) {
        referanse_bunn();
    }
}

if (vis_topp) {
    topp_pos = toppskift ? [ext_size[0]*1.1, 0, 0] : [0, 0, 0];
    translate(topp_pos) {
        topp();
        if (vis_referanse) {
            referanse_topp();
        }
    }
}

