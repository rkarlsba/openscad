// Gunn Jonstrups laderholder

// En sirkel består av $fn streker
$fn = 128;

// Det er en bug i preview i openscad, denne fikser det
bugfix = $preview ? .1 : 0;

// Her er dimensjonene
height = 34;
width = 80;
length = 174;
wall = 2;
cable = 10;
mount_length = 18;
mount_width = 15;
mount_hole_top = 6;
mount_hole_bottom = 4;
lid_height = 10;
lid_tolerance = .2;

// Og koden

// Hakk til kablene
module cable_slot() {
    rotate([270,270,0]) {
        cylinder(d=cable,h=wall+bugfix*2);
    }
    translate([-cable/2-bugfix,0,0]) {
        cube([cable, wall+bugfix*2,height/2+wall+bugfix]);
    }
}

// Triangel til skrufeste
module triangle() {
    translate([0,wall,0]) {
        rotate([90,0,0]) {
            linear_extrude(wall) {
                polygon([[0,0],[mount_length,0],[0,mount_length]]);
            }
        }
    }
}

// Skrufeste
module screw_mount() {
    translate([0,0,wall]) {
        triangle();
        translate([0,mount_width-wall,0]) {
            triangle();
        }
    }
    difference() {
        cube([mount_length,mount_width,wall]);
        translate([mount_length/2,mount_width/2,-bugfix]) {
            cylinder(d1=mount_hole_bottom, d2=mount_hole_top, h=wall+bugfix*2);
        }
    }
}

// Boksen
module charger_box() {
    difference() {
        cube([width+wall*2, length+wall*2, height+wall]);
        translate([wall,wall,wall]) {
            cube([width, length, height+bugfix]);
        }
        translate([width/2+wall,-bugfix,height/2]) {
            cable_slot();
        }
        translate([width/2+wall,length+wall-bugfix,height/2]) {
            cable_slot();
        }
    }
}

// Lokk
module lid() {
    difference() {
        cube([width+wall*4+lid_tolerance*2, 
            length+wall*4+lid_tolerance*2, 
            lid_height+wall]);
        translate([wall,wall,wall]) {
            cube([width+wall*2+lid_tolerance, 
                length+wall*2+lid_tolerance,
                lid_height+bugfix]);
        }
    }
}

// Hovedkoden
charger_box();
translate([width+wall*2,length/2-mount_width/2,0]) {
    screw_mount();
}
translate([0,length/2-mount_width/2,0]) {
    mirror([1,0,0])
    screw_mount();
}
translate ([120,0,0]) {
    lid();
}
