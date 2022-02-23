$fn = $preview ? 10 : 64;

module roundedsquare(size, radius) {
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([radius, radius]) circle(r=radius);
            translate([size[0]-radius, radius]) circle(r=radius);
            translate([radius, size[1]-radius]) circle(r=radius);
            translate([size[0]-radius, size[1]-radius]) circle(r=radius);
        }
    }
}

linear_extrude(10) {
    difference() {
        roundedsquare([205,145,10], 5);
        translate([10,10,0]) {
            roundedsquare([185,125,10], 5);
        }
    }
}