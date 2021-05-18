$fn=32;

difference() {
    linear_extrude(5) {
        hull() {
            translate([0,0]) circle(d=1);
            translate([10,0]) circle(d=1);
            translate([0,10]) circle(d=1);
            translate([10,10]) circle(d=1);
        }
    }

    translate([1,1,1]) {
        linear_extrude(4) {
            hull() {
                translate([0,0]) circle(d=1);
                translate([8,0]) circle(d=1);
                translate([0,8]) circle(d=1);
                translate([8,8]) circle(d=1);
            }
        }
    }
}