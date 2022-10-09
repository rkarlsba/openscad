
// random measureds
//pcb_t=1.7;

// pcb offset - Where pcb starts, size of pcb, extra space after pcb:
pcb_x = 0; // before pcb
pcb_sx = 57.3;
extra_x = 2; // after pcb
pcb_y = 3;
pcb_sy = 56;
extra_y = 0;

wall_t = 2;
roof_t = 2.5;

screws = [[3,  3],
          [3, 53],
          [54.3, 3],
          [54.3, 35]];
vholes = [9, 19, 29, 39, 49];

// Status lights positions from pcb start x and y
// x size on them is ~ 1.5mm
// height on them is 2.5mm - 1.7mm + 0.2mm = 1mm over underside, but we can afford 2mm
status = [
    [27.5, 1.5, "S"],
    [32.5, 1.5, "L"],
    [37,   1.5, "W"],
];

case_x = 2*wall_t + pcb_x + pcb_sx + extra_x;
case_y = 2*wall_t + pcb_y + pcb_sy + extra_y;

$fn=64;

module rcube(dim, r=1) {
    linear_extrude(dim[2])
    offset(r)
    translate([r, r])
    square([dim[0]-2*r, dim[1]-2*r]);
}


module base_screw_neg() {
    cylinder(d=7, h=0.8);
    cylinder(d=3.4, h=10);
}

module base_neg() {
    for(screw=screws) {
        translate([pcb_x+screw[0],pcb_y+screw[1],-2])
            base_screw_neg();
    }
    // Cut out front panel
    translate([pcb_x+5.5, pcb_y+pcb_sy, 4])
        cube([48.5,wall_t,1]);
    // Ventilation holes
    for(vhole = vholes) {
        translate([11,vhole,-2])
            rcube([35,4,3], r=1);
    }
}

module base_pos() {
    // Outer casing
    difference() {
        translate([-wall_t, -wall_t, -wall_t])
            rcube([case_x, case_y, 5+wall_t]);
        cube([case_x-2*wall_t, case_y-2*wall_t, 5.01]);
    }
    for(screw=screws) {
        translate([pcb_x+screw[0]-3,pcb_y+screw[1]-3,0])
            cube([6,6,3.6]);
    }
}

module base() {
    difference() {
        base_pos();
        base_neg();
    }
}
module cover() {
    wall_h = 15.5; // temp: -10
    btn_d = 2.5; // 2.5mm button

    difference() {
        union() {
            // Case top and walls
            difference() {
                translate([-wall_t, -wall_t, -wall_h])
                    rcube([case_x,case_y,roof_t+wall_h]);
                // Minus contents
                translate([0,0,-wall_h])
                    cube([case_x-2*wall_t, case_y-2*wall_t, wall_h]);
            }
            for(s=status) {
                translate([pcb_x+s[0],pcb_y+s[1],2-wall_h])
                    cylinder(d=4, h=wall_h-2);
            }
        }
    
        for(s=status) {
            translate([pcb_x+s[0],pcb_y+s[1],2-wall_h])
                cylinder(d=2, h=roof_t+wall_h-2);
            translate([pcb_x+s[0],0,roof_t-1])
                linear_extrude(1)
                rotate(180)
                text(s[2], size=3, halign="center", valign="top");
        }
        
        // Minus vertical holes
        for(vhole = vholes) {
            translate([11,vhole,0])
                rcube([35,4,roof_t], r=1);
        }
        
        // eth0 - wan
        translate([pcb_x+6,pcb_y+pcb_sy,-wall_h])
            cube([16,wall_t, 13.5]);
        // lan0, about 2mm after eth0 ends. So x+6+16+2 = x+24
        translate([pcb_x+24,pcb_y+pcb_sy,-wall_h])
            cube([16,wall_t, 13.7]);
        // usbc power in. 52.5 ends. 9 earlier starts: x+43.5
        translate([pcb_x+43.5,pcb_y+pcb_sy,-wall_h])
            cube([9,wall_t, 3.5]);

        // side: reset btn. d=2.5
        /*translate([pcb_x+pcb_sx, pcb_y+pcb_sy-4.25-btn_d/2, -wall_h])
            cube([wall_t, btn_d, 2.25]);
        translate([pcb_x+pcb_sx, pcb_y+pcb_sy-4.25,         -wall_h+2.25])
            rotate([0,90,0])
            cylinder(d=btn_d, h=wall_t);*/

        // usbA
        translate([pcb_x+pcb_sx+extra_x, pcb_y+pcb_sy-10-6, -wall_h])
            cube([wall_t, 6, 13.3]);
        
        // Port labelling
        translate([pcb_x+6+8,60,roof_t-1])
            linear_extrude(1)
            rotate(180)
            text("WAN", size=3, halign="center");
        translate([pcb_x+24+8,60,roof_t-1])
            linear_extrude(1)
            rotate(180)
            text("LAN", size=3, halign="center");

    }
    // Status bars
    for(screw=screws) {
        translate([pcb_x+screw[0],pcb_y+screw[1],-15.3]) {
            difference() {
                translate([-3,-3,0])
                    cube([6,6,15.3]);
                cylinder(d1=3.8, d2=2.8, h=1);
                translate([0,0,1])
                    cylinder(d=2.8, h=15.3-1);
            }
        }
    }
}
cover();

//translate([0,0,-30])
//base();