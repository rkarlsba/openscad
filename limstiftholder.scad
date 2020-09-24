$fn = $preview ? 16 : 128;

teppebredde=72;
teppelengde=36;
teppehoyde=3;
sylindertykkelse=2;
sylinderbredde=27;
sylinderhoyde=40;
avrunding=2;

module roer() {
    translate([sylinderbredde/2+teppelengde-sylinderbredde-sylindertykkelse*1.5,teppelengde/2,teppehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde,r=(sylinderbredde+sylindertykkelse)/2);
            translate([0,0,teppehoyde]) cylinder(h=sylinderhoyde,r=sylinderbredde/2);
        }
    }
    translate([sylinderbredde*1.5+teppelengde-sylinderbredde+sylindertykkelse*1.5,teppelengde/2,teppehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde*.85,r=(sylinderbredde+sylindertykkelse)/2);
            cylinder(h=sylinderhoyde*.85,r=sylinderbredde/2);
        }
    }
}

hull() {
    translate([avrunding,avrunding,0])cylinder(r=2,h=teppehoyde);
    translate([avrunding,teppelengde-avrunding,0])cylinder(r=2,h=teppehoyde);
    translate([teppebredde-avrunding,teppelengde-avrunding,0])cylinder(r=2,h=teppehoyde);
    translate([teppebredde-avrunding,avrunding,0])cylinder(r=2,h=teppehoyde);
}
difference() {
    roer();
    rotate([0,10,0]) {
        translate([-5,0,sylinderhoyde+teppehoyde*1.1]) { 
            cube([teppebredde,teppelengde,teppehoyde*2]); 
        } 
    }
}