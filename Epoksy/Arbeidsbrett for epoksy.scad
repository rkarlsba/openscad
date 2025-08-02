mixing_tray_width = 40;
mixing_tray_gap = 1;
mixing_tray_slot = mixing_tray_width+mixing_tray_gap*2;
epoxy_slot_width = 50;
epoxy_slot_height = 40;
wall_thickness = 2;
work_area = 60;
rim_width = 2;
rim_height = 2;
tray_thickness = 2;

tray_size = [
    mixing_tray_width + mixing_tray_gap * 2 + wall_thickness * 3 + epoxy_slot_width + rim_width * 2,
    (mixing_tray_slot > epoxy_slot_height ? mixing_tray_width : epoxy_slot_height) + work_area + wall_thickness * 2 + rim_width * 2,
    tray_thickness
];

//echo(str("Tray width = ", tray_width, " and tray height = ", tray_height));
echo(str("Tray size = ", tray_size));

// Rimline
module rimline(d,l) {
    ds2 = d*sqrt(2);
    difference() {
        rotate([0,90,0]) {
            cylinder(d=d, h=l, $fn=64);
        }
        translate([0,-d/2,0]) {
            rotate([0,90,0]) {
                cube([d,d,l]);
            }
        }
        translate([0,-d/2,-d/2])
        rotate([0,0,45])
            cube([ds2,ds2,ds2]);
    }
}

// Rim
module rim() {
    translate([0,rim_height/2,rim_height]) {
        rotate([0,90,0]) {
            cylinder(d=rim_height, h=tray_size[0], $fn=64);
        }
    }
    translate([rim_height/2,0,rim_height]) 
    {
        rotate([90,0,180]) {
            cylinder(d=rim_height, h=tray_size[1], $fn=64);
        }
    }
    translate([0,tray_size[1]-rim_height/2,rim_height]) {
        rotate([0,90,0]) {
            cylinder(d=rim_height, h=tray_size[0], $fn=64);
        }
    }
    translate([tray_size[0]-rim_height/2,0,rim_height]) 
    {
        rotate([90,0,180]) {
            cylinder(d=rim_height, h=tray_size[1], $fn=64);
        }
    }
}

// Tray
module tray() {
    cube(tray_size);
    translate([0,-20,0]) rimline(d=rim_height, l=tray_size[0]);
}

tray();

