difference() {
    rotate([0,0,45]) {
        translate([-1,-1,0]) {
            cube([2,12,2]);
        }
    }
    cylinder(d=1, h=12, $fn=64);
}