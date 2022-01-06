/* [Screw holes for attaching the Raspberry Pi 4] */

$fn=$preview?16:64;

// Make the screw holes this much bigger than the
// actual screw for a more comfortable fit
// (a bigger number here will make the screws fit looser)
screw_hole_fudge = 0.15; // [0:0.05:0.5]

/* [Tray width] */

// Make the tray this much narrower on each side
// for a more comfortable fit in the frame
// (a bigger number here will make the fit looser)
tray_insert_fudge = 0.25; // [0:0.05:0.75]

/* [Hidden] */

tray_width = 58;
tray_length = 85;
tray_depth = 5;
tray_lip_overhang = 10;
inner_wall_thickness = 5;
spacer_depth = 3;
spacer_outer_radius = 3;

screw_radius = 1.25 + screw_hole_fudge;
screw_head_radius = 3;
screw_head_depth = 2;
pcb_depth = 2;
spacer_center_width = 49;
spacer_center_length = 58;
spacer_from_edge = (tray_width - spacer_center_width) / 2;

sd_window_width = 40;
floor_window_width = sd_window_width;
floor_window_border = (tray_width - floor_window_width) / 2;
floor_window_length = tray_length - floor_window_border*2 - inner_wall_thickness;

db9_mod_width_min = 20;
db9_mod_width_max = 33.5;
db9_mod_height = 16.3;
db9_slack = 1;
db9_clips = 2;

block=3;
elevation=0;

clip_width = 2;
clip_height = 20+elevation;
clip_length = 10;
//feet = clip_width*4;
feet=4;

epsilon = 0.001;

difference() {
    union() {
        // the main tray
        intersection() {
            union() {
                translate([tray_insert_fudge, 0, 0]) {
                    cube([  tray_width - 2*tray_insert_fudge,
                            tray_length + tray_lip_overhang,
                            tray_depth]);
                }
                
                difference() {
                    // the outer part of the curved handle
                    translate([ tray_width/2,
                                -tray_length*0.5 + 7.5,
                                0]) {
                        cylinder(
                            h=tray_depth + spacer_depth + pcb_depth,
                            r=tray_length*1.5,
                            center=false,
                            $fn=360);
                    }
                    
                    // cut away the inside to make it a shell
                    translate([ tray_width/2,
                                -tray_length*0.5 + 5.4,
                                -epsilon]) {
                        cylinder(
                            h=tray_depth + spacer_depth + pcb_depth + 2*epsilon,
                            r=tray_length*1.5,
                            center=false,
                            $fn=360);
                    }
                    translate([ tray_width,
                                -tray_length,
                                -epsilon]) {
                        cube([  2*tray_width,
                                3*tray_length,
                                tray_depth + spacer_depth + pcb_depth + 2*epsilon]);
                    }
                    translate([ -2*tray_width,
                                -tray_length,
                                -epsilon]) {
                        cube([  2*tray_width,
                                3*tray_length,
                                tray_depth + spacer_depth + pcb_depth + 2*epsilon]);
                    }
                }
                
                // reinforce the curved handle
                translate([epsilon, tray_length, tray_depth]) {
                    rotate([-75, 0, 0]) {
                        cube([tray_width - 2*epsilon, 2*sqrt(2), 6]);
                    }
                }
                
            }
            
            // cut away the ears of the tray
            // where they jut through the curved handle
            translate([ tray_width/2,
                        -tray_length*0.5 + 7.5,
                        0]) {
                cylinder(
                    h=tray_depth + spacer_depth + pcb_depth,
                    r=tray_length*1.5,
                    center=false,
                    $fn=360);
            }
        }
        // the tray insert edge tabs
        
        for (a=[    tray_insert_fudge,
                    tray_width - tray_insert_fudge]) {
            translate([ a,
                        0,
                        tray_depth/2]) {
                intersection() {
                    rotate([0, 45, 0]) {
                        translate([-tray_depth/sqrt(2)/2, 0, -tray_depth/sqrt(2)/2]) {
                            cube([  tray_depth/sqrt(2),
                                    tray_length,
                                    tray_depth/sqrt(2)]);
                        }
                    }
                    translate([-tray_depth/2+0.5, 0, -tray_depth/2]) {
                        cube([  tray_depth-1,
                                tray_length,
                                tray_depth]);
                    }
                }
            }
        }
    }
    

    // punch a hole in the bottom
    translate([ floor_window_border,
                floor_window_border*1.5,
                -epsilon]) {
        cube([  floor_window_width,
                floor_window_length/3,
                tray_depth + 2*epsilon]);
    }
    translate([ floor_window_border,
                floor_window_border+floor_window_length/3*2.4,
                -epsilon]) {
        cube([  floor_window_width,
                floor_window_length/3,
                tray_depth + 2*epsilon]);
    }
}

db9sperre=[5,clip_width,3.5];
// DB9 module fasteinging
translate([tray_width/2-db9_mod_width_max/2-db9_slack-clip_width/2,tray_depth/3,tray_depth]) {
    cube([clip_width,clip_length,clip_height]);
    cube([db9_mod_width_max+clip_width,tray_width/2-db9_mod_width_max/2-db9_slack-clip_width/2,elevation]);
    // feet
    rotate([270,0,0]) {
        cylinder(h=clip_length, d=feet);
    }
    translate([block/2, 0, clip_height-block/2]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=block);
        }
    }
    translate([0,clip_length,0]) {
        cube(db9sperre);
    }
}
translate([tray_width/2+db9_mod_width_max/2+db9_slack-clip_width/2,tray_depth/3,tray_depth]) {
    cube([clip_width,clip_length,clip_height]);
    translate([clip_width,0,0]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=feet);
        }
    }
    translate([0, 0, clip_height-block/2]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=block);
        }
    }
    translate([-db9sperre[0]+clip_width,clip_length,0]) {
        cube(db9sperre);
    }
}

// Og den andre
translate([tray_width/2-db9_mod_width_min/2-db9_slack-clip_width/2,tray_depth*8.3,tray_depth]) {
    cube([clip_width,clip_length,clip_height]);
    cube([db9_mod_width_min+clip_width,tray_width/2-db9_mod_width_max/2-db9_slack-clip_width/2,elevation]);
    rotate([270,0,0]) {
        cylinder(h=clip_length, d=feet);
    }
    translate([block/sqrt(2), 0, clip_height-block/2]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=block);
        }
    }
}
translate([tray_width/2+db9_mod_width_min/2+db9_slack-clip_width/2,tray_depth*8.3,tray_depth]) {
    cube([clip_width,clip_length,clip_height]);
    translate([clip_width,0,0]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=feet);
        }
    }
    translate([0, 0, clip_height-block/2]) {
        rotate([270,0,0]) {
            cylinder(h=clip_length, d=block);
        }
    }
}
