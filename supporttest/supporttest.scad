difference() {
    union() {
        rotate([0,45,0]) cube([100,10,100]);
        translate([50,0,0]) rotate([0,45,0]) cube([100,10,100]);
    }
    union() {
        translate([14.2,0,0]) rotate([0,45,0]) cube([80,10,80]);
        translate([64.2,0,0]) rotate([0,45,0]) cube([80,10,80]);
        translate([0,0,-100]) cube([200,10,100]);
    }

}