r = 40;
thickness = 5;

difference() {
        cylinder(h = 100, r = r, $fn=50);
        translate([0, 0, -1])
        cylinder(h = 102, r = r-thickness, $fn=50);

        translate([0, 0, 20])
        for (i=[0:20:360]) {
                rotate([0, 0, i])
                translate([r-thickness-1, 0, 0])
                rotate([0, 90, 0])
                cylinder(h = thickness+2, r=5);
        }
} 