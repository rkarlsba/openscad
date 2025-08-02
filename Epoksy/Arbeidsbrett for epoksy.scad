mixing_tray_width = 40;
mixing_tray_gap = 1;
mixing_tray_slot = mixing_tray_width+mixing_tray_gap*2;
epoxy_slot_width = 50;
epoxy_slot_height = 40;
wall_thickness = 2;
work_area = 60;
rim_size = 2;
tray_thickness = 2;

tray_size = [
    mixing_tray_width + mixing_tray_gap * 2 + wall_thickness * 3 + epoxy_slot_width + rim_size * 2,
    (mixing_tray_slot > epoxy_slot_height ? mixing_tray_width : epoxy_slot_height) + work_area + wall_thickness * 2 + rim_size * 2,
    tray_thickness
];

//echo(str("Tray width = ", tray_width, " and tray height = ", tray_height));
echo(str("Tray size = ", tray_size));

module skalk(inner_r, outer_r, thickness, angle=360) {
    rotate_extrude(convexity = 10, angle=angle) {
        translate([inner_r, 0, 0]) {
            square([outer_r,thickness]);
        }
    }
}

// Rimline
module rimline(d,l) {
    ds2 = d*sqrt(2);
    fudge = .001;
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

// Tray
module tray() {
    union() {
        cube(tray_size);
        translate([0,0,tray_thickness]) {
            rim(size=tray_size, d=rim_size);
        }
    }
}

/// tray();

rim(tray_size, rim_size);