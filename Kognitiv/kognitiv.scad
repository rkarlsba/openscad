$fn = $preview ? 12 : 64;

module equ_triangle(side_length, corner_radius) {
    hull() {
        translate([corner_radius,corner_radius,corner_radius]) {
            sphere(r=corner_radius);
            translate([side_length-corner_radius*2,0,0]) {
                sphere(r=corner_radius);
                rotate([0,0,120]) {
                    translate([side_length-corner_radius*2,0,0]) {
                        sphere(r=corner_radius);
                    }
                }
            }
        }
        rotate([0,-55,45]) {
            translate([side_length-corner_radius*2,0,0]) {
                sphere(r=corner_radius);
            }
        }
    }
}
side_length=70;
corner_radius=1;

equ_triangle(side_length,corner_radius);
