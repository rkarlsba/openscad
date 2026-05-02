// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:ft=openscad

$fn = 128;
bugfix = $preview ? .1 : 0;

// ---- Parameters (from Python) ----
svg_size = [150.0, 85.52530670166016];
margin = 2.0;

corners = 8;
height = 1.5;
shrink = height;

border = true;
border_width = 1;
border_height = 1;
text_height = border_height;

holes = true;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;

graphics_file = "/Users/roysk/src/git/rkarlsba/openscad/Skilt/Doskilt/balum133.svg";

// ---- Derived sizes ----
bottom_size = [
    svg_size[0] + margin*2 + shrink*2,
    svg_size[1] + margin*2 + shrink*2
];

top_size = [
    bottom_size[0] - shrink*2,
    bottom_size[1] - shrink*2
];

// ------------ Geometry ------------

module rounded_square(size, radius) {
    translate([radius,radius]) {
        minkowski() {
            square([size[0] - 2*radius, size[1] - 2*radius]);
            circle(r=radius, $fn=50);
        }
    }
}

module rounded_cube(size, radius, h) {
    linear_extrude(h) {
        rounded_square(size, radius);
    }
}

module border_shape() {
    translate([shrink,shrink,height]) {
        difference() {
            rounded_cube(top_size, corners, border_height);
            translate([border_width,border_width,0]) {
                rounded_cube(
                    [ top_size[0]-border_width*2,
                      top_size[1]-border_width*2 ],
                    corners,
                    border_height
                );
            }
        }
    }
}

module baseplate() {
    hull() {
        rounded_cube(bottom_size, corners, .1);
        translate([shrink,shrink,height]) {
            rounded_cube(top_size, corners, .1);
        }
    }
    if (border) border_shape();
}

module main() {
    difference() {
        baseplate();
        if (holes) {
            translate([hole_dist,bottom_size[1]-hole_dist,-bugfix])
                cylinder(d=hole_d,h=hole_h+bugfix*2);
            translate([bottom_size[0]-hole_dist,
                      bottom_size[1]-hole_dist,-bugfix])
                cylinder(d=hole_d,h=hole_h+bugfix*2);
        }
    }
}

main();

// ---- SVG ----
translate([
    (bottom_size[0] - svg_size[0]) / 2,
    (bottom_size[1] - svg_size[1]) / 2,
    height
]) {
    linear_extrude(text_height)
        import(graphics_file);
}

