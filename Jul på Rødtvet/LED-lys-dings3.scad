// Lamp dimentions
lamp_h = 66;
lamp_d = 40;

// Luft
lamp_h_sp = 20;
lamp_d_sp = 5;

// Vegger
wall = 1.5;
bottom = wall * 2;

// Høl
holes1 = 5;

slits_x = 2;
slits_z = 10;

// bolske
print_box = 1;
print_lid = 1;

// finetuning lid size to make it fit correctly
lid_adjustment = 0.2;

module perforering() {
    translate([0,lamp_d,lamp_h/5]) {
        rotate([90,0,0]) {
            cube([slits_x,slits_z,lamp_d*2]);
        }
    }
    rotate([0,0,30]) {
        translate([0,lamp_d,lamp_h/5]) {
            rotate([90,0,0]) {
                cube([slits_x,slits_z,lamp_d*2]);
            }
        }
    }
    rotate([0,0,60]) {
        translate([0,lamp_d,lamp_h/5]) {
            rotate([90,0,0]) {
                cube([slits_x,slits_z,lamp_d*2]);
            }
        }
    }
    rotate([0,0,90]) {
        translate([0,lamp_d,lamp_h/5]) {
            rotate([90,0,0]) {
                cube([slits_x,slits_z,lamp_d*2]);
            }
        }
    }
    rotate([0,0,120]) {
        translate([0,lamp_d,lamp_h/5]) {
            rotate([90,0,0]) {
                cube([slits_x,slits_z,lamp_d*2]);
            }
        }
    }
    rotate([0,0,150]) {
        translate([0,lamp_d,lamp_h/5]) {
            rotate([90,0,0]) {
                cube([slits_x,slits_z,lamp_d*2]);
            }
        }
    }
}

// Kode
if (print_box) {
    difference() {
        cylinder(d=lamp_d+lamp_d_sp+wall, h=lamp_h+lamp_h_sp+wall, $fn=128);
        translate([0,0,bottom]) {
            cylinder(d=lamp_d+lamp_d_sp, h=lamp_h+lamp_h_sp, $fn=128);
        }
        perforering();
        rotate([0,0,22.5])
            translate([0,0,lamp_h/3.8])
                perforering();
        rotate([0,0,45])
            translate([0,0,lamp_h/3.8*2])
                perforering();
        rotate([0,0,67.5])
            translate([0,0,lamp_h/3.8*3])
                perforering();
    }
}

if (print_lid) {
    translate([lamp_d+lamp_d_sp*2,0,0]) {
        difference() {
            cylinder(d=lamp_d+lamp_d_sp+wall*2+lid_adjustment, h=wall*4, $fn=128);
            translate([0,0,bottom]) {
                cylinder(d=lamp_d+lamp_d_sp+wall+lid_adjustment, h=lamp_h+lamp_h_sp, $fn=128);
            }    
        }
    }
}