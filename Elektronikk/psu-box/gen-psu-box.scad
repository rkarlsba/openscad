/* vim:ts=4:sw=4:sts=4:et:ai:fdm=marker:tw=80
 *
 * Quite generic box with air holes and slits for use with regular PSUs bought
 * from Meanwell or something generic from China. I've added an electronics
 * board on top of the PSU on which you can mount external electronics, like a
 * controller for your LEDs or whatever.
 *
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in june 2023
 *
 * Licensed under AGPL v3. See https://www.gnu.org/licenses/agpl-3.0.en.html
 * for details */

use <ymse.scad>

$fn = $preview ? 16 : 32;
renderfix = $preview ? .1 : 0;

// Size of PSU
x = 160;
y = 98;
z = 43;

// Give it some breathing room
gap_x = 20;
gap_y = 2;
gap_z = 2;

// Electronics bay height
el_bay_z = 35;
el_bay_gap_x = 1;
el_bay_gap_y = 1;
el_bay_gap_z = 5;

// Top or lid height
lid_z = 5;
lid_slack = 1;

// Wall thickness
thickness = 2;

// Size of air holes and slits
holesize = 2.5;
slitwidth = 2.5;
runded_slits = 1;

// If you need a USB port, say here
make_usb_port = 0;
z_to_usb = 13.5;
usb_z = 5;
usb_y = 12;

// If you want the electronics board, say here
make_el_bay_board = 1;

// Internal vars
_x = x + gap_x;
_y = y + gap_y;
_z = z + gap_z + el_bay_z + el_bay_gap_z;

// Modules
module usb_port() {
    translate([thickness,0,-renderfix])
    rotate([0,270,0]) {
        linear_extrude(thickness+renderfix*2) {
            roundedsquare([usb_z,usb_y],1);
        }
    }
}

module el_bay_board() {
    x = _x - el_bay_gap_x;
    y = _y - el_bay_gap_y;
    z = _z - el_bay_gap_z;

    // Test
    echo("el_bay_gap_x is ", el_bay_gap_x);
    echo("el_bay_gap_y is ", el_bay_gap_y);
    echo("el_bay_gap_z is ", el_bay_gap_z);

    echo("local x in el_bay_board is ", x);
    echo("local y in el_bay_board is ", y);
    echo("local z in el_bay_board is ", z);

    assert(false, "test");

}

module sfhull() {
}

module bunn() {
    difference() {
        cube([_x+thickness*2,_y+thickness*2,_z+thickness]);
        translate([thickness,thickness,thickness]) {
            cube([_x,_y,_z+thickness]);
        }
        if (runded_slits) {
            /* Rounded slits */
            for (fx=[8:14:_x-3]) {
                hull() {
                    translate([fx+thickness,thickness*3,-renderfix]) {
                        cylinder(d=slitwidth, h=thickness+renderfix*2, $fn=16);
                    }
                    translate([fx+thickness,_y-thickness,-renderfix]) {
                        cylinder(d=slitwidth, h=thickness+renderfix*2, $fn=16);
                    }
                }
            }
        } else {
            /* Square slits */
            for (fy=[8:7:_y-3]) {
                translate([10,fy,-renderfix]) {
                    cube([_x-20+thickness*2,slitwidth,thickness+renderfix*2]);
                }
            }
        }
        if (make_usb_port) {
            translate([0,_y/2-usb_y/2+thickness,z_to_usb]) {
                usb_port();
            }
        }
        /* Make air holes for the psu part */
        /* FIXME! Make a module out of this next time!!! */
        for (fz=[8:7:z]) {
            for (fx=[10:10:_x-5]) {
                translate([fx,-renderfix,fz]) {
                    rotate([270,0,0]) {
                        cylinder(r=holesize, h=_y+thickness*2+renderfix*2, $fn=16);
                    }
                }
            }
        }
        for (fz=[8:7:z]) {
            for (fy=[10.5:10:_y-5]) {
                translate([_x+thickness*2+renderfix,fy,fz]) {
                    rotate([0,270,0]) {
                        cylinder(r=holesize, h=thickness+renderfix*2, $fn=16);
                    }
                }
            }
        }
        for (fz=[8:7:z]) {
            for (fy=[10.5:10:_y-5]) {
                translate([thickness+renderfix,fy,fz]) {
                    rotate([0,270,0]) {
                        cylinder(r=holesize, h=thickness+renderfix*2, $fn=16);
                    }
                }
            }
        }
        /* og elektronikkboksen */
        if (el_bay_z > 0) {
            lz = z + gap_z + el_bay_gap_z;
            for (fz=[8:7:el_bay_z]) {
                for (fx=[10:10:_x-5]) {
                    translate([fx,-renderfix,fz+lz]) {
                        rotate([270,0,0]) {
                            cylinder(r=holesize, h=_y+thickness*2+renderfix*2, $fn=16);
                        }
                    }
                }
            }
            for (fz=[8:7:el_bay_z]) {
                for (fy=[10.5:10:_y-5]) {
                    translate([_x+thickness*2+renderfix,fy,fz+lz]) {
                        rotate([0,270,0]) {
                            cylinder(r=holesize, h=thickness+renderfix*2, $fn=16);
                        }
                    }
                }
            }
            for (fz=[8:7:el_bay_z]) {
                for (fy=[10.5:10:_y-5]) {
                    translate([thickness+renderfix,fy,fz+lz]) {
                        rotate([0,270,0]) {
                            cylinder(r=holesize, h=thickness+renderfix*2, $fn=16);
                        }
                    }
                }
            }
        }
    }
}

module topp() {
    difference() {
        cube([_x+thickness*4+lid_slack,_y+thickness*4+lid_slack,lid_z+thickness]);
        translate([thickness,thickness,thickness]) {
            cube([_x+thickness*2+lid_slack,_y+thickness*2+lid_slack,lid_z]);
        }
        if (runded_slits) {
            /* Avrunda spalter */
            for (fy=[8:7:_y]) {
                hull() {
                    translate([8+thickness,fy,0]) {
                        cylinder(d=slitwidth, h=thickness, $fn=16);
                    }
                    translate([_x-8+thickness*3,fy,0]) {
                        cylinder(d=slitwidth, h=thickness, $fn=16);
                    }
                }
            }
        } else {
            /* Firkanta spalter */
            for (fy=[8:7:_y-3]) {
                translate([10,fy,0]) {
                    cube([_x-20+thickness*2,slitwidth,thickness]);
                }
            }
        }
    }
}

//topp();
bunn();
