cube([102,24,2]);
translate([0,0,2]) {
    difference() {
        cube([102,24,2]);
        translate([2,2,0]) {
            cube([98,20,2]);
        }
    }
}
translate([8,8,2]) {
    linear_extrude(2)  {
        text("Lars Christian");
    }
}