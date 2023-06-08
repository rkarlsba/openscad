use <ymse.scad>

$fn = $preview ? 16 : 32;
x = 88;
y = 57;
z = 55;
//z = 17;
topp_z = 5;
slack = 1;

thickness = 2;
z_to_usb = 13.5;
usb_z = 5;
usb_y = 12;
holesize = 2.5;
slitwidth = 2.5;
avrunda_spalter = 1;

module usbhull() {
    translate([thickness,0,0])
    rotate([0,270,0])
    linear_extrude(thickness) {
        roundedsquare([usb_z,usb_y],1);
    }
}

module bunn() {
    difference() {
        cube([x+thickness*2,y+thickness*2,z+thickness]);
        translate([thickness,thickness,thickness]) {
            cube([x,y,z+thickness]);
        }
        if (avrunda_spalter) {
            /* Avrunda spalter */
            for (fy=[8:7:y-3]) {
                hull() {
                    translate([10+thickness,fy,0]) {
                        cylinder(d=slitwidth, h=thickness);
                    }
                    translate([x-10+thickness,fy,0]) {
                        cylinder(d=slitwidth, h=thickness);
                    }
                }
            }
        } else {
            /* Firkanta spalter */
            for (fy=[8:7:y-3]) {
                translate([10,fy,0]) {
                    cube([x-20+thickness*2,slitwidth,thickness]);
                }
            }
        }

        translate([0,y/2-usb_y/2+thickness,z_to_usb]) {
            usbhull();
        }
        for (fz=[8:7:z]) {
            for (fx=[10:10:x-5]) {
                translate([fx,0,fz]) {
                    rotate([270,0,0])
                    cylinder(r=holesize, h=y+thickness*2);
                }
            }
        }
        for (fz=[8:7:z]) {
            for (fy=[10.5:10:y-5]) {
                translate([x+thickness*2,fy,fz]) {
                    rotate([0,270,0])
                    cylinder(r=holesize, h=thickness);
                }
            }
        }
        for (fz=[8:7:z]) {
            for (fy=[10.5:10:y-5]) {
                if (!(fy == 30.5 && fz == 15)) {
                    translate([thickness,fy,fz]) {
                        rotate([0,270,0])
                            cylinder(r=holesize, h=thickness);
                    }
                }
            }
        }
    }
}

module topp() {
    difference() {
        cube([x+thickness*4+slack,y+thickness*4+slack,topp_z+thickness]);
        translate([thickness,thickness,thickness]) {
            cube([x+thickness*2+slack,y+thickness*2+slack,topp_z]);
        }
        if (avrunda_spalter) {
            /* Avrunda spalter */
            for (fy=[8:7:y]) {
                hull() {
                    translate([8+thickness,fy,0]) {
                        cylinder(d=slitwidth, h=thickness);
                    }
                    translate([x-8+thickness*3,fy,0]) {
                        cylinder(d=slitwidth, h=thickness);
                    }
                }
            }
        } else {
            /* Firkanta spalter */
            for (fy=[8:7:y-3]) {
                translate([10,fy,0]) {
                    cube([x-20+thickness*2,slitwidth,thickness]);
                }
            }
        }
    }
}

//topp();
bunn();
