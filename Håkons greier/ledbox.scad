$fn = 200;
GLITCH=.1;

// Used for esp32 mount
include <../hawkenlib/hawkenlib.scad>


// Features:
// - PSU mount with ventilation             check
// - hard power button                      check
// - Some GPIO buttons.                     check x 3
// - Mount ESP32                            check (lid)
// - Mount LP buck reg                      check (lid)
// - 12v power relay                        skip
// - No permanent cables:
//   - Maybe space for C13 plug type        check
//   - Quick connect for led strip     (back side)     
//   - Quick connect for 12v power     (back side)
// - fan                                    check
// - Brass inserts and lid                  check
// - Brass insert mounted fan               skip
// - Brass insert mounted PSU               check
// - must have lid?                         check

wall_t = 3;

// Resources:
// C14: https://www.kjell.com/no/produkter/elektro-og-verktoy/el-produkter/sterkstrom/kontakter-for-sterkstrom/apparatkontakter/apparatinntak-c14-med-bryter-og-sikring-p37378
// Lipo plug: XT60. XT60F cabinet side with hot glue
xt60m_w = 16;
xt60m_h = 8.5;
xt60m_d = 16; // but 21mm with back contacts
// Strip connector type: 2.5mm pitch, 3 pin. JST SM. Need the male type in the box. Will also get extension cord for it.
// https://www.jst.co.uk/products.php?cat=117 ??
// We will pick a different more suitable connector and then use a cable to switch type.
// Will also cut the 12v and only use data and gnd.

// LM2596 regulator
lm2596_l = 43;
lm2596_w = 21;
lm2596_h = 13;
lm2596_elevation = 2;

// Buttons: https://www.sparkfun.com/products/11996
// Datasheet: http://cdn.sparkfun.com/datasheets/Components/Switches/com-11992.pdf
// hole punching diameter
button_d = 7;
button_y = wall_t + lm2596_w + 15;
// require 11mm inner diameter
button_id = 11;


// Nice buttons: http://cdn.sparkfun.com/datasheets/Components/Switches/com-11966.pdf
// - Sparkfun metal series, 16mm. With LED.
// They are maybe 35 deep and 16 wide. Afraid I can't fit it because it would conflict with high voltage
//cylinder(d=16, h=35);

    


// Brass insert box:
// - PSU inserts: Hopefully max 3mm, but anything up to ~5.5mm is possible.
//                They need to be more than 3.5mm wide so that they have a grip.
//                Type chosen: 3x6x4.3. Screws must be cut so threads are maximum 7mm long.
// - Fan inserts: Need to go M4 because of the screw length. Would prefer not to increase thickness,
//                but these start at 4mm
//                4x4x5.3. Need to make extra thickness. I hate this already.
//                Let's go for direct threading instead.
//
// OD (Overall diameter): 4.3, matched with m3 size.
// Height: Up to 6. We'll make it work.
// - 3, 4, 5, 6, 8, 10
// Thread size: 3. (2 don't have, 4 won't fit)
// - 2, 3, 4
insert_od = 4.3;
insert_h = 6;
// m3 = 3mm
screw_size = 3;

// total dimensions
psu_depth = 159;
psu_width = 98.5;
psu_height = 42.5;
psu_height_space = 1+insert_h-wall_t;
psu_right_side_space = 1+insert_h-wall_t;
psu_shell_t = 1;
// For the lid: length of empty space over the psu contacts
psu_bottom_space = 15;

psu_wall_screw_h = 29.3;
//psu_wall_screw_h = 10;

// Screws are:
// - Bottom right
// - top left
// - top right wall


// Box dimensions
// Designing with the box lying down
extra_depth = 54;
box_depth = psu_depth + extra_depth + 2*wall_t;
box_width = psu_width + psu_right_side_space + 2*wall_t;
// Without lid, so only 1 wall. But we want to elevate the psu some mm.
box_height = psu_height + psu_height_space + wall_t + insert_h+1;

echo("Check that your printer can do this many mm:");
echo(box_depth);

// 20mm fan
fan_depth = 20;

// ESP32
//espid = ESP32_DEVKITV1;
espid = ESP32_NODEMCU;



// screws: These are the same lengths from the closest wall.
// x=6.5 y=2.5 Ø=~3

lm2596_s1_x = 6.5;
lm2596_s1_y = lm2596_w-2.5;
lm2596_s2_x = lm2596_l-6.5;
lm2596_s2_y = 2.5;

lm2596_offset_x = wall_t + 4;
// Now, the real lm2596 elevation might be 6-2=4mm


// in+ Ø1       out+

// in-       Ø2 out-



//ledbox();
//psu_placeholder();
//fan_placeholder();
//c14_placeholder();
//button_placeholder();
//translate([0,0,box_height]) {
    rotate([180,0,0])
    ledbox_lid(0);
//}
//lm2596_placeholder();
//esp32_placeholder();

// With this profile punched through a panel,
// one can stick a JST_SM female in it for a panel mount.
// Then, one needs a male-male adapter cable on the outside for the contraption
// to work.
module jst_sm_female_2mm() {
    // printer xy tolerance
    printer_xy = .15;
    
    // pin count dependent
    jst_sm_a = 8.2 +  + printer_xy;
    jst_sm_b = 12.5 + printer_xy;

    // valid 2-12 pins
    jst_sm_bh = 4.15 + printer_xy;
    jst_sm_ah = 5.15 + printer_xy;
    jst_sm_top_w = 4 + printer_xy;
    jst_sm_top_h = 1.6 + printer_xy;
    
    polygon([
        // bottom left
        [-jst_sm_b/2,-jst_sm_bh/2],
        [-jst_sm_a/2,-jst_sm_bh/2],
        [-jst_sm_a/2,-jst_sm_ah/2],
        // bottom right
        [jst_sm_a/2,-jst_sm_ah/2],
        [jst_sm_a/2,-jst_sm_bh/2],
        [jst_sm_b/2,-jst_sm_bh/2],
        // top right
        [jst_sm_b/2,jst_sm_bh/2],
        [jst_sm_a/2,jst_sm_bh/2],
        [jst_sm_a/2,jst_sm_ah/2],
        [jst_sm_top_w/2,jst_sm_ah/2],
        [jst_sm_top_w/2,jst_sm_ah/2 + jst_sm_top_h],
        // top left
        [-jst_sm_top_w/2,jst_sm_ah/2 + jst_sm_top_h],
        [-jst_sm_top_w/2,jst_sm_ah/2],
        [-jst_sm_a/2,jst_sm_ah/2],
        [-jst_sm_a/2,jst_sm_bh/2],
        [-jst_sm_b/2,jst_sm_bh/2],
    ]);
}

module button_placeholder() {
    color("gray")
    translate([wall_t,button_y,box_height])
    mirror([0,0,1]) {
        translate([button_id/2,0,0])
            cylinder(d=10, h=15.4);
        translate([3*button_id/2,0,0])
            cylinder(d=10, h=15.4);
        translate([5*button_id/2,0,0])
            cylinder(d=10, h=15.4);
    }

}

module esp32_placeholder() {
    // This too
    color("gray")
        translate([box_width-esp32_devboard_mount_len(espid)-wall_t,
                   wall_t+fan_depth+2,box_height-14])
        cube([52, 28, 14]);
}
module lm2596_placeholder() {
    // Don't fully know where to place this yet, so "thinking" outside of the box
    color("gray")
        translate([lm2596_offset_x,wall_t+1,box_height-lm2596_h-insert_h+wall_t-1])
        cube([lm2596_l, lm2596_w, lm2596_h]);
}

module c14_placeholder() {
    // 28 at the most, 17 at the least
    color("gray")
        translate([wall_t,2,wall_t+1])
        cube([47,30,28]);
}
module fan_placeholder() {
    color("gray")
        translate([box_width-wall_t-40-1,wall_t,wall_t+1])
        cube([40,fan_depth,40]);
}
module psu_placeholder() {
    color("gray")
    translate([wall_t,wall_t+extra_depth,wall_t+psu_height_space]) {
        difference() {
            cube([psu_width, psu_depth, psu_height]);
            translate([-GLITCH,-GLITCH,25])
                cube([psu_width-2+GLITCH, psu_bottom_space+GLITCH, psu_height-25+GLITCH]);
        }
    }
}

module ledbox_lid(n_buttons=3) {
    lm2596_offset_y = wall_t;
    difference() {
        union() {
            cube([box_width, box_depth, wall_t]);
            // lm2596 positive material
            translate([lm2596_offset_x, wall_t+1, wall_t-insert_h-1]) {
                translate([lm2596_s1_x, lm2596_w-lm2596_s1_y,0])
                    cylinder(d=insert_od+2, h=insert_h-wall_t+1);
                translate([lm2596_s2_x, lm2596_w-lm2596_s2_y,0])
                    cylinder(d=insert_od+2, h=insert_h-wall_t+1);
            }
        }
        // y: shift past the box, then bring it back through these factors:
        // - one wall thickness
        // - Length of self (125)
        // - 1cm from the front of the psu
        // x: We are modelling this that positive z is outside the box.
        // Instead we will do this in the slicer
        translate([wall_t+5,box_depth-wall_t-125-10,-GLITCH])
            cube([85, 125, 1+GLITCH]);
        //translate([wall_t+5,box_depth-wall_t-125-10,wall_t+GLITCH])
            //rotate([-90,0,0])
            //perforate_wall(wall_t+2*GLITCH, 85, 125);
        
        // Then we need screw holes, but sinking in the screws will be hard because they are on the wrong side of the print.
        // The holes are distanced insert_od/2+1 from each side.
        // The diameter is screw_size + 0.5, in order to make a loose fit
        translate([insert_od/2+1,
                   insert_od/2+1,-GLITCH])
            cylinder(d=screw_size+0.5, h=wall_t+2*GLITCH);
        translate([box_width-insert_od/2-1,
                   insert_od/2+1,-GLITCH])
            cylinder(d=screw_size+0.5, h=wall_t+2*GLITCH);
        translate([insert_od/2+1,
                   box_depth-insert_od/2-1,-GLITCH])
            cylinder(d=screw_size+0.5, h=wall_t+2*GLITCH);
        translate([box_width-insert_od/2-1,
                   box_depth-insert_od/2-1,-GLITCH])
            cylinder(d=screw_size+0.5, h=wall_t+2*GLITCH);
            

        // Clear out space for esp32 bells and whistles
        translate([box_width-wall_t-esp32_devboard_mount_len(espid),
                   wall_t+fan_depth+1,-GLITCH])
            cube([esp32_devboard_mount_len(espid), esp32_devboard_mount_width(espid), wall_t+2*GLITCH]);
            
        // Clear out holes for the lm2596
        translate([lm2596_offset_x, wall_t+1, wall_t-insert_h-1-GLITCH]) {
            translate([lm2596_s1_x, lm2596_w-lm2596_s1_y,0])
                cylinder(d=insert_od, h=insert_h+GLITCH);
            translate([lm2596_s2_x, lm2596_w-lm2596_s2_y,0])
                cylinder(d=insert_od, h=insert_h+GLITCH);
        }
        
        // Punch a couple of holes for buttons
        if(n_buttons > 0)
            for(i = [1 : n_buttons])
            translate([wall_t+(2*i - 1)*button_id/2,button_y,-GLITCH])
            cylinder(d=button_d, h=wall_t+2*GLITCH);
    }
    translate([box_width-wall_t,esp32_devboard_mount_width(espid)+wall_t+fan_depth+1,wall_t])
        rotate([0,180,90])
        esp32_devboard_mount(espid, 1.5);
}
module ledbox() {
    difference() {
        union() {
            box_no_top(box_width, box_depth, box_height, wall_t);
            //box_1wall(box_width, box_depth, box_height, wall_t);
            translate([wall_t,box_depth-wall_t,wall_t])
                rotate([180,0,0])
                mirror([0,0,1]) {
                psu_supports();
            }
        }
        box_cuts();
        translate([wall_t,box_depth-wall_t,wall_t+psu_height_space])
            rotate([180,0,0])
            mirror([0,0,1]) {
            // screw 1: top left
            // - y: 3mm to center
            // - x: 7-7.5mm to center
                    
            // Screw 2: top right wall
            // - z: 26
            // - y: 3.5
            // Unchecked x/y
                    
            // Screw 3: Bottom right
            // x: 4mm and 8mm, about 6mm
            // y: 6mm - about 3.5/2, but assume 3/2 for simplicity
            translate([7,3,-insert_h])
                cylinder(d=insert_od, h=insert_h+GLITCH);
            translate([psu_width+insert_h,3.5,psu_wall_screw_h])
                rotate([0,-90,0])
                cylinder(d=insert_od, h=insert_h+GLITCH);
            translate([psu_width-6,psu_depth-4.5,-insert_h])
                cylinder(d=insert_od, h=insert_h+GLITCH);
        }
    }
}


module box_cuts() {
    // Take cuts into the wall
    // bottom breather
    translate([wall_t+12,box_depth-wall_t-GLITCH,wall_t])
        cube([psu_width/2-2.5-12,wall_t+2*GLITCH,psu_height_space]);
    translate([wall_t+psu_width/2+2.5,box_depth-wall_t-GLITCH,wall_t])
        cube([psu_width/2-2.5-10,wall_t+2*GLITCH,psu_height_space]);
    // side breather
    cutout_height = psu_wall_screw_h - 11 + insert_od/4;
    translate([box_width-wall_t,
               box_depth+GLITCH,
               wall_t+7.5])
        rotate([90,-90,0])
        linear_extrude(wall_t+2*GLITCH)
        polygon([[0,0], [cutout_height,0],[cutout_height+2.5,psu_right_side_space], [0,psu_right_side_space]]);

    // height of this thing is given by:
    // box_height - wall_t
    cutout_height2 = psu_height + psu_height_space - psu_wall_screw_h - insert_od/4 - 14;
    translate([box_width-wall_t,
               box_depth+GLITCH,
               wall_t+psu_wall_screw_h+psu_height_space+insert_od/4+2.5])
        rotate([90,-90,0])
        linear_extrude(wall_t+2*GLITCH)
        polygon([[0,0], [cutout_height2,0],[cutout_height2+2.5,psu_right_side_space], [0,psu_right_side_space]]);
    
    // Side wall
    // holes start around 10mm from the top and are 125mm long and 32mm high
    // Height wise we can remove psu_height_space and psu_shell_t
    translate([wall_t+GLITCH,box_depth-125-wall_t-10,wall_t+psu_height_space+psu_shell_t])
        rotate([0,0,90])
        //perforate_wall(wall_t+2*GLITCH, 125, 32);
        perforate_wall(wall_t+2*GLITCH, 125, 32);
    
    // Hole for c14 socket with fuse and switch:
    translate([wall_t,-GLITCH,wall_t+1]) {
        cube([47, wall_t+2*GLITCH, 28]);
    }

    // Also max 2mm thickness according to spec. 
    if(wall_t > 2) {
        translate([wall_t,2,wall_t])
        cube([47, wall_t-2+GLITCH, 30]);
    }
    
    
    // Fan holes, spaced 32mm for 40mm fans. 3.4mm wide
    //fan_hole_size = 3.4; // Following the spec
    fan_hole_size = 3.8; // give me a little more
    translate([box_width-20-wall_t-1,-GLITCH,20+wall_t+1])
    rotate([-90,0,0]) {
        difference() {
            // d=fan diameter
            cylinder(d=40,h=wall_t+2*GLITCH);
            // d=middle circle size
            cylinder(d=5,h=wall_t+2*GLITCH);
            // vertical bar
            translate([-1,-20,0])
                cube([2,40,wall_t+2*GLITCH]);
            // horizontal bar
            translate([-20,-1,0])
                cube([40,2,wall_t+2*GLITCH]);
        }
        translate([16,16,0])
            cylinder(d=fan_hole_size, h=wall_t+2*GLITCH);
        translate([16,-16,0])
            cylinder(d=fan_hole_size, h=wall_t+2*GLITCH);
        translate([-16,16,0])
            cylinder(d=fan_hole_size, h=wall_t+2*GLITCH);
        translate([-16,-16,0])
            cylinder(d=fan_hole_size, h=wall_t+2*GLITCH);
    }
    
    // Lid insert holes
    translate([insert_od/2+1,insert_od/2+1,box_height-insert_h])
        cylinder(d=insert_od, h=insert_h+GLITCH);
    translate([box_width-insert_od/2-1,insert_od/2+1,box_height-insert_h])
        cylinder(d=insert_od, h=insert_h+GLITCH);
    
    translate([insert_od/2+1,box_depth-insert_od/2-1,box_height-insert_h])
        cylinder(d=insert_od, h=insert_h+GLITCH);
    translate([box_width-insert_od/2-1,box_depth-insert_od/2-1,box_height-insert_h])
        cylinder(d=insert_od, h=insert_h+GLITCH);
    
    
    // dc jack on the side:
    // 40mm from the bottom edge
    // 10mm up
    translate([box_width-wall_t-GLITCH/2,40,10])
        rotate([0,90,0])
        // 8mm hole size plus some printer slack
        cylinder(d=8 + .2, h=wall_t+GLITCH);

    // led strip connector.
    // Impossible to panel mount the male type. So we will use a pigtail.
    // We will then hotglue the pigtail in the case as strain relief
    translate([box_width-wall_t/2,40,20])
        cube([wall_t+GLITCH, 6, 2], center=true);
}

module perforate_wall(thickness, w, h) {
    // Max height of holes
    max_h = 4;
    // Max width of holes
    max_w = 4;
    
    bar_t = 0.5;
    
    // How many cells do we need to have?
    nhigh = ceil((h-max_h)/(max_h+bar_t)+1);
    nwide = ceil((w-max_w)/(max_w+bar_t)+1);
    //echo(nhigh, nwide);
    
    // How big is each cell?
    cell_h = (h-(nhigh-1)*bar_t)/nhigh;
    cell_w = (w-(nwide-1)*bar_t)/nwide;
    //echo(cell_h, cell_w);

    for(cw = [0 : nwide-1]) {
        for(ch = [0 : nhigh-1]) {
            translate([cw*(cell_w+bar_t),0,
                       ch*(cell_h+bar_t)])
                cube([cell_w,thickness,cell_h]);
        }
    }
}

// Origo is flipped here, to the far bottom left inside the box.
module psu_supports() {
    // Screw holes are:
    screwhole_dia=3.5; // Could be 3.5, throwing our math off a little. Fit test in order.
    // Using this just for measuring the hole positions.

    // Bottom
    translate([0,0,0])
        cube([12,psu_depth,psu_height_space]);
    translate([psu_width/2-2.5,0,0])
        cube([5,psu_depth,psu_height_space]);
    translate([psu_width-10,0,0])
        cube([10,psu_depth,psu_height_space]);
    
    // Side
    translate([psu_width,0,0])
        cube([psu_right_side_space,psu_depth,7.5]);
    // For the vertical one, we need to get creative
    translate([psu_width+psu_right_side_space,0,psu_height-7.5+psu_height_space])
        rotate([90,0,180])
        linear_extrude(psu_depth)
        polygon([[0,0], [0,7.5], [psu_right_side_space,7.5], [psu_right_side_space, 2.5]]);
    // And screw support
    // this one goes from 2.5 to 10
    // 1. up 26+psu_height_space
    // 2. down 2.5 for the flat part
    // 3. down insert_od/2 for the bottom of the hole
    // 4. down (10-insert_od/2)
    translate([psu_width+psu_right_side_space,0,psu_wall_screw_h+psu_height_space-7.5+insert_od/4])
        rotate([90,0,180])
        linear_extrude(10)
        polygon([[0,0], [0,10], [psu_right_side_space,10], [psu_right_side_space, 2.5]]);
}
// Box, given outer dimensions and wall thickness

module box_1wall(w, d, h, t) {
    difference() {
        cube([w, d, h]);
        translate([-GLITCH,-GLITCH,t])
            cube([w-t+GLITCH, d+2*GLITCH, h-t+GLITCH]);
    }
}

module box_no_top(w, d, h, t) {
    difference() {
        cube([w, d, h]);
        translate([t,t,t])
            cube([w-2*t, d-2*t, h-t+GLITCH]);
    }
    // Add some cubes to hold the lid inserts
    translate([0,0,box_height-insert_h-1]) {
        cube([insert_od+2, insert_od+2, insert_h+1]);
        translate([box_width-insert_od-2,0,0])
            cube([insert_od+2, insert_od+2, insert_h+1]);
        translate([0,box_depth-insert_od-2,0])
            cube([insert_od+2, insert_od+2, insert_h+1]);
        translate([box_width-insert_od-2,box_depth-insert_od-2,0])
            cube([insert_od+2, insert_od+2, insert_h+1]);
    }
    
}