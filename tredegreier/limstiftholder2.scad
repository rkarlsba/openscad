$fn = $preview ? 16 : 128;

include <ymse.scad>

//platebredde = 72;
//platelengde = 36;
platehoyde = 3;
sylindertykkelse = 2;
sylinderbredder = [27,27,32];
sylinderhoyde = 40;
avrunding = 2;
mellomrom = 5;
roer_min = 1;
roer_maks = 3;
//                  27               2*2                 5        36
//platebredde = sylinderbredde + sylindertykkelse * 2 + mellomrom = 36;
platebredde = (max(sylinderbredde) + 2 * sylindertykkelse + mellomrom);
platelengde = 72;

module roer(nr) {
    assert((nr >= roer_min) && (nr <= roer_maks), 
        str("Kan bare lage [", nr, "] rør, ikke mellom ", roer_min, " og ", roer_maks, " rør"));
//    pb = platebredde;
}

module alle_roer() {
    for (sylinderbredde = sylinderbredder) {
    // 1/2 * sylinderbredde
    translate([sylinderbredde*(+platelengde-sylinderbredde-sylindertykkelse*1.5,platelengde/2,platehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde,r=(sylinderbredde+sylindertykkelse)/2);
            translate([0,0,platehoyde]) cylinder(h=sylinderhoyde,r=sylinderbredde/2);
        }
    }
    // 3/2 * sylinderbredde
    translate([sylinderbredde*1.5+platelengde-sylinderbredde+sylindertykkelse*1.5,platelengde/2,platehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde*.87,r=(sylinderbredde+sylindertykkelse)/2);
            cylinder(h=sylinderhoyde*.87,r=sylinderbredde/2);
        }
    }
    // 5/2 * sylinderbredde?
    translate([sylinderbredde*2.7+platelengde-sylinderbredde+sylindertykkelse*1.5,platelengde/2,platehoyde]) {
        difference() {
            cylinder(h=sylinderhoyde*.7,r=(sylinderbredde+sylindertykkelse)/2);
            cylinder(h=sylinderhoyde*.7,r=sylinderbredde/2);
        }
    }
}

module plate() {
    linear_extrude(platehoyde) {
        roundedsquare([platebredde,platelengde], 2);
    }
}

plate();
difference() {
    alle_roer();
    rotate([0,10,0]) {
        translate([-5,0,sylinderhoyde+platehoyde*1.1]) { 
            cube([platebredde,platelengde,platehoyde*2]); 
        } 
    }
}