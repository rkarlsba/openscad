// Oppløsning
$fn = 64;

// Lampedimensjoner
lamp_h = 66;
lamp_d = 40;

// Luft
lamp_h_sp = 20;
lamp_d_sp = 5;

// Vegger
wall = 1;
bottom = wall * 2;

// Høl
holes1 = 10;

module perforering() {
    // nederst
    translate([0,lamp_d,lamp_h/3]) {
        rotate([90,0,0]) {
            cylinder(d=holes1,h=lamp_d*2,center=1);
        }
    }
    rotate([0,0,60]) {
        translate([0,lamp_d,lamp_h/3]) {
            rotate([90,0,0]) {
                cylinder(d=holes1,h=lamp_d*2,center=1);
            }
        }
    }
    rotate([0,0,120]) {
        translate([0,lamp_d,lamp_h/3]) {
            rotate([90,0,0]) {
                cylinder(d=holes1,h=lamp_d*2,center=1);
            }
        }
    }
}

// Kode
difference() {
    cylinder(d=lamp_d+lamp_d_sp+wall, h=lamp_h+lamp_h_sp+wall);
    translate([0,0,bottom]) {
        cylinder(d=lamp_d+lamp_d_sp, h=lamp_h+lamp_h_sp);
    }
    perforering();
    rotate([0,0,20])
        translate([0,0,lamp_h/3])
            perforering();
    rotate([0,0,40])
        translate([0,0,lamp_h/3*2])
            perforering();
}
