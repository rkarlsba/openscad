/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */

$fn = 128;

bugfix = $preview ? .1 : 0;

corners = 8;
height = 1.5;
shrink = height;
bottom_size = [165,120];
top_size = [bottom_size[0]-shrink*2,bottom_size[1]-shrink*2];
border = true;
border_width = 1;
border_height = 1;
text_height = border_height;
holes = false;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;
graphics_file = "la-linea-dass3.svg";

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

module main() {
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
    if (0)
    translate([10,10,height]) {
        linear_extrude(text_height) {
            import(graphics_file);
        }
    }
}

main();

translate([5,5,height]) {
    linear_extrude(text_height) {
        import(graphics_file);
    }
}


