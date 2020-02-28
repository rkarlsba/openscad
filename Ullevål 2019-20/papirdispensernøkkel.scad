$fn=256;

difference() {
    hull() {
        cylinder(h=30,d=3);
        translate([20,0,0])
            cylinder(h=30,d=3);
    }
    translate([10,-43,0]) cylinder(h=30,d=85);
    translate([10,43,0]) cylinder(h=30,d=85);
}
