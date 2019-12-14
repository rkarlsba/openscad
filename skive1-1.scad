$fn=32;

union() {
    difference() {
        cube([10,6,4]);
        translate([2.5,3,0]) {
            cylinder(h=4,r=1.75);
        }
    }
    translate([7.5,3,0]) {
        cylinder(h=5.5,r=0.55);
    }
}