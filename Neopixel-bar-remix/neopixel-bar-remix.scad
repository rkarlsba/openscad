$fn=128;

module arm() {
    difference() {
        translate([15,0,0]) {
            rotate([0,0,45]) {
                import("Neopixel_Bar_Solid_Top.stl");
            }
        }
        translate([-200,-15,0]) {
            cube([150,30,15]);
        }
    }
}

union() {
    arm();
    rotate([0,0,180]) arm();
}