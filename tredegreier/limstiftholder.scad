$fn = $preview ? 16 : 128;

platebredde=72;
platelengde=36;
platehoyde=3;
sylindertykkelse=2;
sylinderbredde=27;
sylinderhoyde=40;
avrunding=2;

module roer() {
    translate([sylinderbredde/2+platelengde-sylinderbredde-sylindertykkelse*1.5,platelengde/2,platehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde,r=(sylinderbredde+sylindertykkelse)/2);
            translate([0,0,platehoyde]) cylinder(h=sylinderhoyde,r=sylinderbredde/2);
        }
    }
    translate([sylinderbredde*1.5+platelengde-sylinderbredde+sylindertykkelse*1.5,platelengde/2,platehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde*.85,r=(sylinderbredde+sylindertykkelse)/2);
            cylinder(h=sylinderhoyde*.85,r=sylinderbredde/2);
        }
    }
}

module plate() {
    hull() {
        translate([avrunding,avrunding,0])cylinder(r=2,h=platehoyde);
        translate([avrunding,platelengde-avrunding,0])cylinder(r=2,h=platehoyde);
        translate([platebredde-avrunding,platelengde-avrunding,0])cylinder(r=2,h=platehoyde);
        translate([platebredde-avrunding,avrunding,0])cylinder(r=2,h=platehoyde);
    }
}

plate();
difference() {
    roer();
    rotate([0,10,0]) {
        translate([-5,0,sylinderhoyde+platehoyde*1.1]) { 
            cube([platebredde,platelengde,platehoyde*2]); 
        } 
    }
}