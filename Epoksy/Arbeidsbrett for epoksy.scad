mixing_tray_width = 40;
mixing_tray_height = 8;
mixing_tray_gap = 1;
mixing_tray_slot_width = mixing_tray_width+mixing_tray_gap*2;
mixing_tray_slot_height = 80;
mixing_tray_slot_gap = 20;
epoxy_slot_width = 50;
epoxy_slot_height = 40;
wall_thickness = 2;
work_area = 60;
rim_size = 2;
tray_thickness = 2;
bugfix = $preview ? .1 : 0;

tray_size = [
    mixing_tray_width + mixing_tray_gap * 2 + wall_thickness * 3 + epoxy_slot_width + rim_size * 2,
    (mixing_tray_slot_width > epoxy_slot_height ? mixing_tray_width : epoxy_slot_height) + work_area + wall_thickness * 2 + rim_size * 2,
    tray_thickness
];

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

// Tray
module tray() {
    cube(tray_size);
    translate([0,0,tray_thickness]) {
        rim(size=tray_size, d=rim_size);
        
    }
    translate([0,tray_size[1]-rim_size-mixing_tray_slot_width,0]) {
        difference() {
            cube([mixing_tray_slot_width+wall_thickness,mixing_tray_slot_width+wall_thickness,mixing_tray_slot_height]);
            translate([wall_thickness,wall_thickness]) {
                cube([mixing_tray_slot_width-wall_thickness,mixing_tray_slot_width-wall_thickness,mixing_tray_slot_height+bugfix]);
            }
            translate([mixing_tray_slot_width/2-mixing_tray_slot_gap/2+wall_thickness/2,-bugfix,mixing_tray_height/2]) {
                cube([mixing_tray_slot_gap,wall_thickness+bugfix*2,mixing_tray_slot_height-mixing_tray_height/2+bugfix]);
            }
        }
    }
    // Mixing trays
}

tray();

// rim(tray_size, rim_size);