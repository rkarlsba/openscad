/*
 * Ender 3 X axis cover with LifeCam Cinema attachment
 * By Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 * Licensed under CC BY-NC-SA. See 
 * https://creativecommons.org/licenses/by-nc-sa/4.0/ for details
 */

//$fn = $preview ? 32 : 256;
$fn = $preview ? 32 : 32;
 
round_rad=5.5;
/* The [xyz] values are as the adapter is printed. As viewed
 * already installed, [xyz] y and z are flipped. */
box_x = 42;
box_y = 42;
box_z = 34;

screw_head_width = 6;
screw_head_height = 2;
screw_width = 3;
screw_length = 40;

padding = 1;

mount_below = 0;
mount_front = 1;

module screw(padding=0) {
    cylinder(h = screw_head_height, d1 = screw_head_width+padding, d2 = screw_width+padding);
    translate([0,0,screw_head_height]) {
        cylinder(h=screw_length-screw_head_height, d=screw_width+padding);
    }
}

module template(sc=1.0) {
    scale([sc,sc,1]) {
        linear_extrude(box_z) {
            hull() {
                translate([round_rad,round_rad]) {
                    circle(r=round_rad);
                }
                translate([round_rad,box_y-round_rad]) {
                    circle(r=round_rad);
                }
                translate([box_x-round_rad,box_y-round_rad]) {
                    circle(r=round_rad);
                }
                translate([box_x-round_rad,round_rad]) {
                    circle(r=round_rad);
                }
            }
        }
    }
}

module templatemedhull(sc=1.0) {
    scale([sc,sc,1]) {
        difference() {
            template();
            translate([round_rad,round_rad]) {
                screw(padding);
            }
            translate([round_rad,box_y-round_rad]) {
                screw(padding);
            }
            translate([box_x-round_rad,box_y-round_rad]) {
                screw(padding);
            }
            translate([box_x-round_rad,round_rad]) {
                screw(padding);
            }
        }
    }
}

module festegreie() {
    difference() {
        union() {
            templatemedhull(sc=1);
            if (mount_below) {
                translate([box_x/2, 0, box_z*.35]) {
                    rotate([90,0,0]) {
                        cylinder(r1=11.8, r2=10, h=1);
                    }
                }
            }
        }
        translate([2.8,2.8,5]) {
            template(sc=0.88);
        }
        translate([0,10,5]) {
            cube([box_x, box_y-20, box_z]);
        }
        if (mount_below) {
            translate([box_x/2, 1.5, box_z*.35]) {
                rotate([90,0,0]) {
                    cylinder(r1=4.6, r2=5, h=2.5);
                }
            }
            translate([box_x/2, 2.8, box_z*.35]) {
                rotate([90,0,0]) {
                    cylinder(r1=0.9, r2=1.1, h=2.8);
                }
            }
        }
    }
}

if (mount_below) {
    festegreie();
}
if (mount_front) {
    translate([0,0,-2.8]) {
        difference() {
            festegreie();
            cube([box_x,box_y,2.8]);
        }
    }
    difference() 
    {
        translate([box_x*2.1,0,0]) {
            rotate([180,0,180]) {
                difference() {
                    translate([0,0,-2.8]) {
                        festegreie();
                    }
                    cube([box_x,box_y,box_z]);
                }            
            }
            translate([-box_x/2, box_y/2, 1.8]) {  
                cylinder(r1=11.8, r2=10, h=1.5);
            }
        }
        translate([box_x*1.6, box_y/2, 1.8]) {
            translate([0, 0, 1]) {
                cylinder(r1=4.6, r2=5, h=2);
            }
            translate([0, 0, -2]) {
                cylinder(r1=0.9, r2=1.1, h=4.8);
            }
        }
    }
}

