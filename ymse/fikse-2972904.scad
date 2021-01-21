module body() {
    stl = "/Users/roy/Downloads/Creality_CR-10S_Ultimate_Filament_Run_Out_censor_With_Z_Axis_Cable_Guide_/files/Base.stl";
    translate([33,45.2,6])
        rotate([-90,0,90])
            import(stl);
}

module front() {
    h=5.5;
    origo_x=10.5;
    origo_y=0;
    origo_z=0;
    x=100;
    y=50;
    z=50;

    difference() {
        body();
        translate([origo_x,origo_y,origo_z])
            cube([x,y,z]);
    }
}

module innerkant() {
    ix = 8.1;
    iy = 30;
    iz = 20;
    
    scale([1.5,1,1]) {
        translate([-8.1,0,0]) {
            difference() {
                front();
                cube([ix,iy,iz]);
            }                
        }
    }
}

module ende() {
    h=5.5;
    origo_x=10.5;
    origo_y=0;
    origo_z=0;
    x=100;
    y=50;
    z=50;

    difference() {
        body();
        cube([origo_x,y,z]);
    }
}

module lengre() {
    front();
    translate([10.4,0,0])
        innerkant();
    translate([3.5,0,0])
        ende();
}

module lengremedstorrehol() {
    difference() {
        lengre();
        translate([10,15,13]) {
            rotate([90,0,90]) {
                hull() {
                    cylinder(r=6.5,h=5,$fn=64);
                    translate([0,10,0])
                        cylinder(r=7,h=5,$fn=64);
                }
            }
        }
    }
}

mode = "lengremedstorrehol";
//mode = "innerkant";
if (mode == "original") {
    body();
} else if (mode == "lengre") {
    lengre();
} else if (mode == "lengremedstorrehol") {
    lengremedstorrehol();
} else if (mode == "innerkant") {
    innerkant();
}
