// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
/*
 * Can holder and tray to mount on a crutch
 *
 * This script uses torus.scad, which uses wedge.scad, available at
 * https://github.com/chrisspen/openscad-extra/tree/master/src
 * The script will work without it, but you won't get rounded top on
 * the canholder.
 * 
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2024 and licensed
 * under CC BY-SA. See https://creativecommons.org/licenses/by-sa/4.0/
 * for details.
 */

use <torus.scad>

$fn = $preview ? 32 : 128;

idiot = $preview ? .5 : 0;
std_can_d = 66;
std_can_bottom_d = 50;
bottom_taper_h = 8;
500ml_can_h = 168;
330ml_can_h = 116;
tray_hh = 42;
wall = 2;
bottom = 4;
gap = 2;
corner_test = false; // Draw a little corner to check for inside fit
full_test = false; // Draw a full cup, only very small
// mode can be either "canholder" or "tray"
// mode = "canholder";
// mode = "tray";
mode = "lokk";

can_extrude = 20;
can_h = 500ml_can_h-can_extrude;
_can_h = corner_test ? 40 : full_test ? 30 : can_h;
can_d = std_can_d + gap*2;
can_outer_d = can_d+wall*2;

crutch_d = 20;

handle_height = _can_h;
handle_width=crutch_d*sqrt(2);
handle_depth=crutch_d*1.2;

tray_width=150; // 120;
tray_depth=200; // 180;
tray_thickness=2;
tray_cover=true;
tray_wall=tray_cover ? wall*1.5 : wall;
tray_edge=35;

cable_tie_height=10;
cable_tie_width=5;
cable_ties=5;
_cable_ties=full_test ? 1 : cable_ties;

// Sanity check
assert(!(full_test && corner_test), "Can't do both corner test and full test at the same time, dummy!");
assert((mode == "canholder" || mode == "tray" || mode == "lokk"), 
    str("Mode \"", mode, "\" unknown - giving up"));

// Modules
module roundedsquare(size, radius) {
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([radius, radius]) {
                circle(r=radius);
            }
            translate([size[0]-radius, radius]) {
                circle(r=radius);
            }
            translate([radius, size[1]-radius]) {
                circle(r=radius);
            }
            translate([size[0]-radius, size[1]-radius]) {
                circle(r=radius);
            }
        }
    }
}

/*
 * module can() - draw can
 *
 * This takes the following arguments:
 *   h      Can height
 *   d      Can diameter
 *   w      Wall
 *   bd     Can bottom diameter
 *   bth    Bottom taper height
 *   b      Bottom height
 *   hh     Handle height (Z)
 *   hw     Handle width (Y)
 *   hd     Handle depth (X)
 *   cd     Crutch diameter
 *   cth    Cable tie height
 *   ctw    Cable tie width
 *   ct     Cable ties
 */
 module can(h=_can_h, d=can_d, w=wall, bd=std_can_bottom_d, bth=bottom_taper_h, 
    b=bottom, hh=handle_height, hw=handle_width, hd=handle_depth, cd=crutch_d,
    cth=cable_tie_height, ctw=cable_tie_width, ct=_cable_ties) {

    od=d+w*2;
    
    module handle(h=h, d=od, hh=hh, hw=hw, cd=cd, cth=cth, ctw=ctw, ct=ct) {
        difference() {
            translate([-d/2-hw+3,-hd/2,h/2-hh/2]) {
                cube([hw,hd,hh]);
            }
            translate([-d/2-hw+3,0,h/2-hh/2-idiot]) {
                cylinder(h=hh+idiot*2, d=cd);
                for (i = [1:ct]) {
                    translate([cd/sqrt(2),-hd/2-idiot,(hh/(ct))*(i-.5)-cth/2]) {
                        cube([ctw,hd+idiot*2,cth]);
                    }
                }
            }
        }
    }

    cylinder(d=od,h=b);
    translate([0,0,b]) {
        difference() {
            union() {
                cylinder(d=od, h=h-b);
                translate([0,0,h-b]) {
                    torus(r1=w/2, r2=d/2+w/2);
                }
                translate([0,0,-b]) {
                    handle();
                }
            }
            union() {
                cylinder(d1=bd, d2=d, h=bth+idiot);
                translate([0,0,bth]) {
                    cylinder(d=d, h=h-bth-b+idiot);
                }
            }
        }
    }
}

module tray(trw=tray_width, trd=tray_depth, trt=tray_thickness, tre=tray_edge,
    hh=handle_height, hw=handle_width, hd=handle_depth, cd=crutch_d, w=tray_wall,
    cth=cable_tie_height, ctw=cable_tie_width, ct=_cable_ties, tc=tray_cover) {

    // Tray
    difference() {
        union() {
            translate([0,-trd/2,0]) {
                difference() {
                    linear_extrude(tre) {
                        roundedsquare([trw,trd], 15);
                    }
                    translate([w,w,w]) {
                        linear_extrude(tre-w+idiot) {
                            roundedsquare([trw-w*2,trd-w*2], 13);
                        }
                    }
                }
            }
            // Handle
            translate([-hw+w,-hd/2,0]) {
                difference() {
                    cube([hw,hd,hh]);
                    translate([0,hd/2,-idiot]) {
                        cylinder(h=hh+idiot*2, d=cd);
                        for (i = [1:ct]) {
                            translate([cd/sqrt(2),-hd/2-idiot,(hh/(ct))*(i-.5)-cth/2]) {
                                cube([ctw,hd+idiot*2,cth]);
                            }
                        }
                    }
                }
            }
        }
        // Hakk til lokk
        if (tc) {
            translate([w/2,w/2-trd/2,tre-trt*1.5]) {
                linear_extrude(w/3*2) {
                    roundedsquare([trw-w,trd-w], 14);
                }
                translate([trw-14,-wall,0]) {
                    cube([trw,trd,10]);
                }
            }
        }
    }
}
/*
(trw=tray_width, trd=tray_depth, trt=tray_thickness, w=tray_wall)
tre=tray_edge,
    hh=handle_height, hw=handle_width, hd=handle_depth, cd=crutch_d, w=tray_wall,
    cth=cable_tie_height, ctw=cable_tie_width, ct=_cable_ties, tc=tray_cover) {
*/
module lokk(trw=tray_width, trd=tray_depth, trt=tray_thickness, w=tray_wall) {
    handtak_r = 10;
    festedings_x = 14;
    festedings_y = 20;
    festedings_z = 6;
    /*
    festedings = [
        points = [
            [0, 0, 0],                                  // 0    
            [festedings_x, 0, 0],                       // 1
            [festedings_x, festedings_y, 0],            // 2
            [0, festedings_x, 0],                       // 3
            [festedings_x, 0, festedings_z],            // 4
            [festedings_x, festedings_y, festedings_z]  // 5
        ],
        faces = [
            [0, 1, 2, 3],
            [0, 1, 4],
            [0, 1, 4, 5],
            [0, 1, 2, 3],
            [0, 1, 2, 3],
            [0, 1, 2, 3],
        ]
    ];*/
    
    // polyhedron( points = [ [X0, Y0, Z0], [X1, Y1, Z1], ... ], faces = [ [P0, P1, P2, P3, ...], ... ], convexity = N);   // 2014.03 & later

    hull() {
        linear_extrude(trt*0.4) {
            roundedsquare([trw-w,trd-w], 14);
        }
        translate([w/2, w/2, trt*0.4]) {
            linear_extrude(trt*.45) {
                roundedsquare([trw-w*2,trd-w*2], 14);
            }
        }
    }
    translate([trw-w, trd/2-w, 0]) {
        linear_extrude(trt*.85) {
            circle(r=handtak_r);
        }
    }
    /*
    translate([0,0,festedings_z]) {
        rotate([0, 90, 90]) {
            linear_extrude(festedings_y) {
                polygon([
                    [0, 0],
                    [festedings_x, 0],
                    [festedings_x, festedings_y]
                ]);
            }
        }
    }
    */
}

if (mode == "canholder") {
    if (corner_test) {
        difference() {
            can(h=40);
            union() {
                translate([-(can_d/2+wall),0,0]) {
                    cube([can_d+wall*2,can_d/2+wall,can_h+wall/2]);
                }
                rotate([0,0,90]) {
                    translate([-(can_d/2+wall),0,0]) {
                        //cube([400,200,40]);
                        cube([can_d+wall*2,can_d/2+wall,can_h+wall/2], 5);
                    }
                }
            }
        }
    } else {
        can();
    }
} else if (mode == "tray") {
    tray(hh=tray_hh, ct=2);
} else if (mode == "lokk") {
//    translate([tray_width+10,-tray_depth/2+wall,0]) {
    translate([tray_width+10,-tray_depth/2+wall,0]) {
        lokk();
    }
}
