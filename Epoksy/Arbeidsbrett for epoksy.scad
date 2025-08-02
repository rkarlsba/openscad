// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
//
// Small epoxy station with room for your trays, spades and epoxy. It comes in two variants, one
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
// Tanker om endringer:
//
// Jeg bør legge inn muligheter for å flytte rundt på rommene. Det kan jo være at spadene funker
// best på venstre side, så blir det mer rom for arbeid. På den annen side, er jo ikke alle
// høyrehendte, så da bør det jo være mulig å flytte dem rundt litt.


// Parameters
rim_size = 2;
tray_thickness = 2;
wall_thickness = 1.5;

mixing_tray_width = 40;
mixing_tray_height = 8;
mixing_tray_gap = 1;
mixing_tray_slot_width = mixing_tray_width+mixing_tray_gap*2;
mixing_tray_slot_height = 80;
mixing_tray_slot_gap = 20;

global_slot_depth = mixing_tray_slot_width;

spade_blade_width = 20;
spade_shaft_width = 10;
spade_length = 55;
spade_outside_lenght = 10;
spade_tray_gap = 1;
spade_slot_width = spade_blade_width+spade_tray_gap*2;

epoxy_slot_width = 50;
epoxy_slot_length = mixing_tray_slot_width;
epoxy_slot_height = mixing_tray_slot_height;

work_area = 50;

bugfix = $preview ? .1 : 0;

tray_size = [
    wall_thickness * 4 + mixing_tray_slot_width + epoxy_slot_width + spade_slot_width,
    work_area + global_slot_depth + rim_size + wall_thickness * 2,
    tray_thickness
];

echo(str("Tray size = ", tray_size, " and composed of wall_thickness * 4 = ", wall_thickness * 3, ", mixing_tray_slot_width =  ", mixing_tray_slot_width, " epoxy_slot_width = ", epoxy_slot_width, " and spade_slot_width = ", spade_slot_width));

module skalk(inner_r, outer_r, thickness, angle=360) {
    rotate_extrude(convexity = 10, angle=angle) {
        translate([inner_r, 0, 0]) {
            square([outer_r,thickness]);
        }
    }
}

module room(ext_size, wall_thickness=wall_thickness, door_width=0, threshold_height=0) {
    int_size = ext_size - [wall_thickness*2-bugfix,wall_thickness*2-bugfix,-bugfix];
    echo(str("ext_size is ", ext_size, " and int_size is ", int_size));
    difference() {
        cube(ext_size);
        translate([wall_thickness,wall_thickness]) {
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
    echo(str("[1] size is ", size, " and d is ", d));
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
    echo(str("mixing trays, where X is ", mixing_tray_slot_width+wall_thickness));
    translate([0,tray_size[1]-mixing_tray_slot_width-wall_thickness*2,0]) {
       room([mixing_tray_slot_width+wall_thickness*2, 
       mixing_tray_slot_width+wall_thickness*2,
       mixing_tray_slot_height], 
       wall_thickness=wall_thickness, 
       door_width=mixing_tray_slot_gap, 
       threshold_height=mixing_tray_height/2);
    }
}

// Spade slot
module spade_slot() {
    translate([mixing_tray_slot_width+wall_thickness, 
        tray_size[1]-mixing_tray_slot_width-wall_thickness*2, 
    0]) {
        room([spade_blade_width+wall_thickness*2+spade_tray_gap*2,
            mixing_tray_slot_width+wall_thickness*2,
            mixing_tray_slot_height],
            door_width=spade_shaft_width+spade_tray_gap*2);
    }
}

// Spade slot
module epoxy_slot(split = false) {
    translate([mixing_tray_slot_width+spade_blade_width+spade_tray_gap*2+wall_thickness*2,
        tray_size[1]-mixing_tray_slot_width-wall_thickness*2,
    0]) {
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
        // Rim
        rim(size=tray_size, d=rim_size);        
        // Mixing trays
        mixing_tray_slot();
        
        // Spade gap
        spade_slot();

        // Epoxy slot
        epoxy_slot(split=true);

        // Test, debug, blabla
        //testroom();
    }
}

main();

// rim(tray_size, rim_size);
