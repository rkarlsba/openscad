// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=100
use <ymse.scad>

$fn = $preview ? 64 : 256;

lid_filename = "USB Micro Breakout lid.stl";
mount_filename = "USB Micro Breakout mount.stl";
ext_top_size = [23.0, 18.8, 2.0];
ext_bottom_size = [ext_top_size[0], ext_top_size[1], 7.0];
countersinkheight = 1.6;
countersinkwidth = 5.7;
top_hole_r = 1.8;
bottom_hole_r = 1.5;
scew_pin_r = bottom_hole_r-.1;
hole_pos = [[8.0+top_hole_r, 5, 0],[8.0+top_hole_r, ext_top_size[1]-5, 0]];
rounding_r = 2.0;
vegg = 1.8;
pluggvegg = 0.6;
pluggbredde = 8.0;
int_size = [ext_top_size[0] - (vegg + pluggvegg),
    ext_top_size[1] - vegg * 2, ext_bottom_size[2] - vegg];
int_size_insert_usb = [11.5, int_size[1]-.3, 1];
int_size_insert_cable = [int_size[0]-15.8, int_size[1]-.3, 1];
int_left_size = [6.7, int_size[1], int_size[2]];
tverrligger = [5.5, int_size[1], 2.5];
int_right_size = [ext_bottom_size[0]-vegg-tverrligger[0]-int_left_size[0], int_size[1], int_size[2]];
kabelhull = 4;

top_colour = $preview ? "red" : "#cccccc";
bottom_colour = $preview ? "green" : "#cccccc";

referanse = false;
debug = true;
vis_bunn = true;
vis_topp = true;
skruer = false;

toppskift = (vis_topp && vis_bunn);

if (debug) {
    echo(str("hole_pos is ", hole_pos));
    echo(str("ext_top_size is ", ext_top_size));
    echo(str("int_size is ", int_size));
    echo(str("int_left_size is ", int_left_size));
    echo(str("int_right_size is ", int_right_size));
    echo(str("tverrligger is ", tverrligger));
    echo(str("tverrligger[0]+int_left_size[0]+int_right_size[0] is ", tverrligger[0]+int_left_size[0]+int_right_size[0]));
    echo(str("int_size_insert_usb is ", int_size_insert_usb));
    echo(str("int_size_insert_cable is ", int_size_insert_cable));
}

// Top
module topp() {
    render(convexity=4) {
        difference() {
            union() {
                // Boks
                roundedcube(ext_top_size, rounding_r);

                // Innsats
                translate([pluggvegg, vegg, ext_top_size[2]]) {
                    color(top_colour) {
                        translate([int_size_insert_usb[0]+5,0,0]) {
                            cube(int_size_insert_cable);
                        }
                        cube(int_size_insert_usb);
                    }
                }
            }
            if (skruer) {
                for (i = [0 : len(hole_pos) - 1]) {
                    translate(hole_pos[i]) {
                        countersunk_screw_hole(h = ext_top_size[2]+int_size_insert_usb[2], d = top_hole_r*2,
                        ch=countersinkheight, cd=countersinkwidth, countersunk_bottom=true); 
                    }
                }
            }
        }
    }
}

// Bottom
module bunn() {
    render(convexity=4) {
        difference() {
            roundedcube(ext_bottom_size, rounding_r);

            // Høl til USB-pluggen
            translate([0, ext_bottom_size[1]/2-pluggbredde/2, vegg]) {
                cube([pluggvegg,pluggbredde,int_size[2]]);
            }

            // Første kammer
            translate([pluggvegg, vegg, vegg]) {
                cube(int_left_size);
            }

            // Tverrligger
            translate([pluggvegg+int_left_size[0], vegg, vegg+tverrligger[2]]) {
                // FIXME: Den under er et stygt hack!
                cube(tverrligger + [0,0,0.5]);
            }

            // Andre kammer
            translate([pluggvegg+int_left_size[0]+tverrligger[0], vegg, vegg]) {
                cube(int_right_size);
            }

            // Høl til strømkabel
            translate([ext_bottom_size[0]-vegg, ext_bottom_size[1]/2, kabelhull/2+vegg]) {
                rotate([0,90,0]) {
                    cylinder(d=kabelhull, h=vegg);
                }
                translate([0,-kabelhull/2,0]) {
                    cube([vegg,kabelhull,int_size[2]]);
                }
            }
            translate([ext_bottom_size[0]-vegg, ext_bottom_size[1]/2-kabelhull/2, vegg]) {
                // cube([vegg,kabelhull,int_size[2]]);
            }

            // Skruehøl
            if (skruer) {
                for (i = [0 : len(hole_pos) - 1]) {
                    translate(hole_pos[i]) {
                        cylinder(r = bottom_hole_r, h = ext_bottom_size[2]); 
                    }
                }
            }
        }
        if (!skruer) {
            for (i = [0 : len(hole_pos) - 1]) {
                translate([hole_pos[i][0], hole_pos[i][1], tverrligger[2]]) {
                    cylinder(r = scew_pin_r, h = 3); 
                }
            }
        }
    }
}

// Modell fra printables, top
module referanse_topp() {
    translate([0,-ext_top_size[1]*1.1,0]) {
        color(bottom_colour) {
            import(lid_filename);
        }
    }
}

// Modell fra printables, bunn
module referanse_bunn() {
    translate([0,-ext_top_size[1]*1.1,0]) {
        color(bottom_colour) {
            import(mount_filename);
        }
    }
}

// Referanse
if (vis_bunn) {
    bunn();
    if (referanse) {
        referanse_bunn();
    }
}

if (vis_topp) {
    topp_pos = toppskift ? [ext_top_size[0]*1.1, 0, 0] : [0, 0, 0];
    translate(topp_pos) {
        topp();
        if (referanse) {
            referanse_topp();
        }
    }
}

