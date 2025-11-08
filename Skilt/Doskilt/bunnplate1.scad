$fn = 128;

bugfix = $preview ? .1 : 0;

corners = 8;
height = 1.5;
shrink = height;
bottom_size = [100,110];
top_size = [bottom_size[0]-shrink*2,bottom_size[1]-shrink*2];
border = true;
border_width = 1;
border_height = 1;
holes = true;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;

module rounded_square(size, radius) {
    translate([radius,radius]) {
        minkowski() {
            square([size[0] - 2*radius, size[1] - 2 * radius]);
            circle(r=radius, $fn=50);
        }
    }
}

module rounded_cube(size, radius, height) {
    linear_extrude(height) {
        rounded_square(size, radius);
    }
}

module border() {
    translate([shrink,shrink,height]) {
        difference() {
            rounded_cube(size=top_size, radius=corners, border_height);
            translate([border_width,border_width,0]) {
                rounded_cube(size=[top_size[0]-border_width*2,
                    top_size[1]-border_width*2],
                    radius=corners, border_height);
            }
        }
    }
}

module bunnplate() {
    hull() {
        rounded_cube(size=bottom_size,radius=corners, .1);
        translate([shrink,shrink,height]) {
            rounded_cube(size=top_size,radius=corners, .1);
        }
    }
    if (border) {
        border();
    }
}

difference() {
    bunnplate();
    if (holes) {
        translate([hole_dist,bottom_size[1]-hole_dist,-bugfix]) {
            cylinder(d=hole_d,h=hole_h+bugfix*2);
        }
        translate([bottom_size[0]-hole_dist,
            bottom_size[1]-hole_dist,-bugfix]) {
            cylinder(d=hole_d,h=hole_h+bugfix*2);
        }
    }
}
