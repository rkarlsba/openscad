$fn=32;

difference() {
    cube([5,6,4]);
    translate([2.5,3,0]) {
        cylinder(h=4,r=1.75);
    }
}