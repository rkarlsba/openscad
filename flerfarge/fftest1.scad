linear_extrude(1) {
    difference() {
        square([9,9]);
        translate([1,1]) {
            square([7,7]);
        }
    }

    translate([2,2]) {
        difference() {
            square([5,5]);
            translate([1,1]) {
                square([3,3]);
            }
        }
    }
}
