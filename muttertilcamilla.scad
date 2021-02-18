include <cyl_head_bolt.scad>;

//nut("M5", thread="modeled");
difference() {
    nut("M5");
    translate([0,0,-5])
        cylinder(d=4.5,h=5,$fn=32);
}
if ($preview) {
    translate([5,-5,0]) {
        cube([2,10,1]);
    }
}