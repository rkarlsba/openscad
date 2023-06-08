$fn=64;

module feste() {
    difference() {
        union() {
            cube([8,8,20]);
            translate([4,0,0]) {
                cylinder(h=20,d=8);
            }
        }
        translate([4,0,0]) {
            cylinder(h=20,d=3);
        }        
    } 
}

feste();