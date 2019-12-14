$fn = 32;

difference() {
    cube([20,50,3]);
    translate([10,10,0]) {
        cylinder(d=6,h=3);
        translate([-3,0,0]) {
            cube([6,30,3]);
        }
        translate([0,30,0]) {
            cylinder(d=6,h=3);
        }
    }
}
