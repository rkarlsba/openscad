// rotate_extrude($fn=100, convexity = 10, angle=210) translate([12, 0, 0]) square([3,3]);

module handtak1() {
    difference() {
        union() {
            rotate([0,0,90]) {
                rotate_extrude($fn=100, convexity = 2, angle=90) {
                    translate([5, 0, 0]) {
                        circle(d=3);
                    }
                }
            }
            translate([0,5,0]) {
                rotate([0,90,0]) {
                    cylinder(d=3, h=20, $fn=100);
                }
            }

            translate([20,0,0]) {
                rotate_extrude($fn=100, convexity = 2, angle=90) {
                    translate([5, 0, 0]) {
                        circle(d=3);
                    }
                }
            }
        }
        translate([-10,0,-10]) {
            cube([40,10,10]);
        }
    }
}

// rotate_extrude($fn=100, convexity = 10, angle=210) translate([12, 0, 0]) square([3,3]);

module nittigrader() {
    rotate_extrude($fn=100, convexity = 2, angle=90) {
        translate([5, 0, 0]) {
            difference() {
                circle(d=3);
                translate([-2,-2]) {
                    square([4,2]);
                }
            }
        }
    }
}

module halvpinne() {
    rotate([0,90,0]) {
        linear_extrude(20) {
            difference() {
                circle(d=3, $fn=100);
                translate([0,-2]) {
                    square([2,4]);
                }
            }
        }
    }
}


module handtak() {
    difference() {
        union() {
            rotate([0,0,90]) {
                nittigrader();
            }
            translate([0,5,0]) {
                halvpinne();
            }
            translate([20,0,0]) {
                nittigrader();
            }
        }
    }
}

handtak1();