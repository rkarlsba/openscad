difference() {
    cube([68,19.5,3.9]);
    translate([30,1.8,0])
        cube([7.8,3.7,3.9]);
}
translate([20,19.5,0]) {
    cube([27,6,3.9]);
    translate([3.5,3,3.9]) {
        cube([20,3,3]);
    }
}