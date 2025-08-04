// Antiskliinnsats

test = false;
tolerance = .5;

spade_blade_width = 20;
spade_tray_gap = 1;
spade_slot_width = spade_blade_width+spade_tray_gap-tolerance;
spade_blade_length = 14;
spade_shaft_width = 10;
spade_slot_depth = 42;
spade_slot_x = 25;

wedge_blade_cut = 5;
wedge_short_length = spade_slot_depth-spade_blade_length-tolerance;
wedge_long_length = spade_slot_depth-spade_blade_length-wedge_blade_cut-tolerance;
wedge_width = (spade_slot_width-spade_shaft_width-tolerance)/2;

wall_thickness = 1.5;
bugfix = $preview ? .1 : 0;

wedge = [
    [0,0],
    [wedge_long_length, 0],
    [wedge_short_length, wedge_width],
    [0,wedge_width]
];

module room(ext_size, wall_thickness=wall_thickness, door_width=0, threshold_height=0) {
    int_size = ext_size - [wall_thickness*2-bugfix,wall_thickness*2-bugfix,-bugfix];
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

module spade_wedge(top_tolerance=tolerance, test=test) {
    wedge_height = 80-top_tolerance;
    _wedge_height = test ? 10 : wedge_height;

    linear_extrude(_wedge_height) {
        polygon(wedge);
    }
}

module spade_slot_with_wedges() {
    room([spade_slot_x, 45, 80], door_width=spade_shaft_width+spade_tray_gap*2);
    // Left wedge
    translate([wedge_width+wall_thickness,0,0]) {
        rotate([0,0,90]) {
            spade_wedge(top_tolerance=0);
        }
    }
    // Right wedge
    translate([-wedge_width+spade_slot_x-wall_thickness,0,0]) {
        rotate([0,0,90]) {
            mirror([0,1,0]) 
            spade_wedge(top_tolerance=0);
        }
    }
}

//spade_wedge();
spade_slot_with_wedges();