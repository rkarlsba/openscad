use <honeycomb/honeycomb.scad>;

/*
radius = 100;

for (a = [0:5.45:180]) {
    rotate([a,0,0])
        translate([0, radius, 0])
            rotate([90,0,0])
                linear_extrude(height=2)
                    honeycomb(50,10,5,1);
}
*/
module honey_panel(x, thickness, hccellsize) {
    rotate([90,0,0])
        linear_extrude(height=thickness)
            honeycomb(x, hccellsize*2.9, hccellsize, 1);
}

module tak(x, radius, thickness, hccellsize) {
    for (a = [0:4:174]) {
        rotate([a,0,0])
            translate([0, radius, 0])
                honey_panel(x, thickness, hccellsize);
    }
}
