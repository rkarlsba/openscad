height=30;

module helegreia() {
    translate([-100,-107,0]) {
        import("/Users/roy/Downloads/Modified Hexasphericon Plate.stl");
    }
}

module sekskant() {
    intersection() {
        helegreia();
        translate([20,-10,0]) {
            cube([30,30,20]);
        }
    }
}

module v1() {
    difference() {
    intersection() {
        helegreia();
        translate([-40,-4,0]) {
            cube([60,80,40]);
        }
    }
        translate([-10,-10,0]) {
            cube([15,15,10]);
        }
    }
}
v1();