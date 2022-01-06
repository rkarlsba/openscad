linear_extrude(1) {
    translate([1,1]) {
        difference() {
            square([7,7]);
            translate([1,1]) {
                square([5,5]);
            }
        }
    }

    translate([3,3]) {
        difference() {
            square([3,3]);
            translate([1,1]) {
                square([1,1]);
            }
        }
    }
}
