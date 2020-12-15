$fn = $preview ? 8 : 64;

translate([0,0,2]) {
    rotate([180,0,0]) {
        difference() {
            hull() {   
                cylinder(d=72,h=0.5);
                translate([0,0,0])
                    cylinder(d=64,h=1.5);
            }
            cylinder(h=2, d=41);
        }
    }
}
translate([0,0,2]) {
    difference() {
        cylinder(d=72,h=2);
        cylinder(d=70,h=2);
    }
}