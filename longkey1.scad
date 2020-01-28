$fn=64;
r=1;
h=3;

module equ_triangle(side_length,corner_radius,triangle_height) {
    translate([0, corner_radius, 0]) {
        hull() {
            cylinder(r=corner_radius, h=triangle_height);
            rotate([0,0,180]) translate([side_length-corner_radius*2,0,0]) cylinder(r=corner_radius, h=triangle_height);
            rotate([0,0,120]) translate([side_length-corner_radius*2,0,0]) cylinder(r=corner_radius, h=triangle_height);
        }
    }
}

cube([90,9,3]);
translate([10,0,3])
//    mirror([0,1,0])
        equ_triangle(10, 1, 3);
/*
cylinder(r=r, h=h);
translate([8,0,0]) cylinder(r=r, h=h);
translate([4,7,0]) cylinder(r=r, h=h);
*/