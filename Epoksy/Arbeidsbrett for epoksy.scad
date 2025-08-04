// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
//
// Small epoxy station with room for your trays, spatulas and epoxy. It comes in two variants, one
// with a single slot for epoxy (for double tubed) and one with separate slots for the resin and
// hardener. If you miss something, feel free to change it, the code is all here.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY-NC-SA v4.0 or later. Please see
// https://creativecommons.org/licenses/by-nc-sa/4.0/ for details.
//
// This is specifically made for using the following:
//   Spatula:   https://www.printables.com/model/1373150-55mm-model
//   Tray:      https://www.printables.com/model/1373150-55mm-model
//
// TODO:
//   - Add hinges to work area
//   - Det som gjør at det skimrer i bunnen, er at det er høl der og at det må utvides med bugfix!


// Comment these out if you're not using hinges - openscad can't conditionally include something
include <BOLS2/std.scad>
include <BOLS2/hinges.scad>

// Parameters
test = false;
hinges = false; // Not implemented
rim_size = 2;
tray_thickness = 2;
wall_thickness = 1.5;
righthanded = true;
split_epoxy_slot = true;

mixing_tray_width = 40;
mixing_tray_height = 8;
mixing_tray_gap = 1;
mixing_tray_slot_width = mixing_tray_width+mixing_tray_gap*2;
mixing_tray_slot_height = 80;
mixing_tray_slot_gap = 20;
mixing_tray_slot_x = mixing_tray_slot_width+wall_thickness*2;

global_slot_depth = mixing_tray_slot_width;

spatula_blade_width = 20;
spatula_shaft_width = 10;
spatula_length = 55;
spatula_outside_lenght = 10;
spatula_blade_length = 14;
spatula_slot_depth = mixing_tray_slot_width;
spatula_tray_gap = 1;
spatula_tolerance = spatula_tray_gap/2;
spatula_slot_width = spatula_blade_width+spatula_tray_gap*2;
spatula_slot_height = mixing_tray_slot_height;
spatula_slot_x = spatula_blade_width+wall_thickness*2+spatula_tray_gap*2;

epoxy_slot_width = 50;
epoxy_slot_length = mixing_tray_slot_width;
epoxy_slot_height = mixing_tray_slot_height;

wedge_blade_cut = 5;
wedge_short_length = spatula_slot_depth-spatula_blade_length-spatula_tolerance;
wedge_long_length = spatula_slot_depth-spatula_blade_length-wedge_blade_cut-spatula_tolerance;
wedge_width = (spatula_slot_width-spatula_shaft_width-spatula_tolerance)/2;

wedge = [
    [0,0],
    [wedge_long_length, 0],
    [wedge_short_length, wedge_width],
    [0,wedge_width]
];

work_area = 80;

// Internals
assert(!hinges, "Hinges aren't supported (yet)");

_work_area = hinges ? epoxy_slot_height : work_area;
if (work_area != _work_area) {
    echo(str("Work area overridden from ", work_area, " to ", _work_area, " because of hinges"));
}

bugfix = $preview ? .1 : 0;

tray_size = [
    wall_thickness * 4 + mixing_tray_slot_width + epoxy_slot_width + spatula_slot_width,
    _work_area + global_slot_depth + rim_size + wall_thickness * 2,
    tray_thickness
];

module skalk(inner_r, outer_r, thickness, angle=360) {
    rotate_extrude(convexity = 10, angle=angle) {
        translate([inner_r, 0, 0]) {
            square([outer_r,thickness]);
        }
    }
}

module room(ext_size, wall_thickness=wall_thickness, door_width=0, threshold_height=0) {
    int_size = ext_size - [wall_thickness*2-bugfix,wall_thickness*2-bugfix,-bugfix*2];
    difference() {
        cube(ext_size);
        translate([wall_thickness,wall_thickness,-bugfix]) {
            cube(int_size);
        }
        if (door_width > 0) {
            translate([ext_size[0]/2-door_width/2, -bugfix, threshold_height]) {
                cube([door_width,wall_thickness+bugfix*2,ext_size[2]-threshold_height+bugfix]);
            }
        }
    }
 }

 
// Rimline
module rimline(d,l) {
    ds2 = d*sqrt(2);
    fudge = .001; // For å fikse non-manifold-fuckups
    translate([0, d/2, 0]) {
        difference() {
            // Tegne pølse
            rotate([0,90,0]) {
                cylinder(d=d, h=l, $fn=64);
            }
            // Fjerne bunnen
            translate([0,-d/2,0]) {
                rotate([0,90,0]) {
                    cube([d,d,l]);
                }
            }
            // Klippe venstre
            translate([0,-d/2+fudge,-d/2+fudge]) {
                rotate([0,0,45]) {
                    cube([ds2,ds2,ds2]);
                }
            }
            // Klippe høyre
            translate([l,-d/2+fudge,-d/2+fudge]) {
                rotate([0,0,45]) {
                    cube([ds2,ds2,ds2]);
                }
            }
        }
    }
}

// Rim
module rim(size, d) {
    rimline(d=d, l=size[0]);
    translate([size[0],0,0]) {
        rotate([0,0,90]) {
            rimline(d=d, l=size[1]);
        }
    }
    translate([size[0],size[1],0]) {
        rotate([0,0,180]) {
            rimline(d=d, l=size[0]);
        }
    }
    translate([0,size[1],0]) {
        rotate([0,0,270]) {
            rimline(d=d, l=size[1]);
        }
    }
}

// Mixing tray slot
module mixing_tray_slot() {
   room([mixing_tray_slot_x, 
   mixing_tray_slot_x,
   mixing_tray_slot_height], 
   wall_thickness=wall_thickness, 
   door_width=mixing_tray_slot_gap, 
   threshold_height=mixing_tray_height/2);
}

// Spatula slot
module spatula_slot() {
    echo(str("Make spatula slot, ", spatula_slot_x, " x ", mixing_tray_slot_x, " x ", mixing_tray_slot_height));
    room([spatula_slot_x,
        mixing_tray_slot_x,
        mixing_tray_slot_height],
        door_width=spatula_shaft_width+spatula_tray_gap*2);
}

// Spatula wedge
module spatula_wedge(top_tolerance=tolerance, test=test) {
    wedge_height = 80-top_tolerance;
    _wedge_height = test ? 10 : wedge_height;

    linear_extrude(_wedge_height) {
        polygon(wedge);
    }
}

// Spatula slot with wedges
module spatula_slot_with_wedges() {
    room([spatula_slot_x,
        mixing_tray_slot_x,
        mixing_tray_slot_height],
        door_width=spatula_shaft_width+spatula_tray_gap*2);
    // Left wedge
    translate([wedge_width+wall_thickness,0,0]) {
        rotate([0,0,90]) {
            spatula_wedge(top_tolerance=0);
        }
    }
    // Right wedge
    translate([-wedge_width+spatula_slot_x-wall_thickness,0,0]) {
        rotate([0,0,90]) {
            mirror([0,1,0]) 
            spatula_wedge(top_tolerance=0);
        }
    }
}


// Spatula slot
module epoxy_slot(split = false) {
    if (split) {
        room([(epoxy_slot_width+wall_thickness*3)/2, 
            epoxy_slot_length+wall_thickness*2, 
            epoxy_slot_height]);
        translate([(epoxy_slot_width)/2+wall_thickness/2, 0, 0]) {
            room([(epoxy_slot_width+wall_thickness*3)/2, 
                epoxy_slot_length+wall_thickness*2, 
                epoxy_slot_height]);
        }
    } else {
        room([epoxy_slot_width+wall_thickness*2, 
            epoxy_slot_length+wall_thickness*2, 
            epoxy_slot_height]);
    }
}

// Test, debug, blabla
module testroom() {
    test = [70,50,10];
    translate([0,tray_size[1]-test[1],tray_thickness]) {
        //cube(test);
        room(test, door_width=20);
    }
}

// Main function
module main() {
    // Main tray
    cube(tray_size);
    
    translate([0, 0, tray_thickness]) {
        if (test) {
            // Test, debug, blabla
            testroom();
        } else {
            // Rim
            rim(size=tray_size, d=rim_size);        

            if (righthanded) {
                // Spatula gap
                translate([0,tray_size[1]-mixing_tray_slot_width-wall_thickness*2, 0]) {
                    //spatula_slot();
                    spatula_slot_with_wedges();
                }

                // Epoxy slot
                translate([
                    spatula_blade_width+spatula_tray_gap*2+wall_thickness,
                    tray_size[1]-mixing_tray_slot_width-wall_thickness*2,0]) {
                    epoxy_slot(split=split_epoxy_slot);
                }

                // Mixing tray slot
                translate([
                    spatula_slot_width + epoxy_slot_width + wall_thickness * 2,
                    tray_size[1]-mixing_tray_slot_width-wall_thickness*2,
                    0]) {
                    mixing_tray_slot();
                }
            } else {
                // Mixing tray slot
                translate([0,
                    tray_size[1]-mixing_tray_slot_width-wall_thickness*2,
                    0]) {
                    mixing_tray_slot();
                }

                // Epoxy slot
                translate([
                    mixing_tray_slot_width+wall_thickness,
                    tray_size[1]-mixing_tray_slot_width-wall_thickness*2,0]) {
                    epoxy_slot(split=split_epoxy_slot);
                }

                // Spatula slot
                translate([
                    mixing_tray_slot_width+wall_thickness+epoxy_slot_width+wall_thickness,
                    tray_size[1]-mixing_tray_slot_width-wall_thickness*2,
                    0]) {
                    //spatula_slot();
                    spatula_slot_with_wedges();
                }
            }
            hinge_start = righthanded ? spatula_blade_width+spatula_tray_gap : 0;
        }
    }
}

main();

// rim(tray_size, rim_size);
