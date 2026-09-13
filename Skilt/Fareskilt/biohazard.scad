// vim modeline {{{
//
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker:tw=120
//
// }}}
// Libraries {{{

include <BOSL2/std.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

svg_size = [122.35049, 107.14191]; // rtfsvg
margin = 2.0;

corners = 8;
height = 1.5;
shrink = height;

border = true;
border_width = 1;
border_height = 1;
text_height = $preview ? border_height + 3 : border_height;

text_area_height = 0; // Set to <= 0 to disable text
font_face = "Arial:style=Bold";

holes = false;
hole_d = 5;
hole_h = height*2;
hole_dist = 10;

graphics_file = "biohazard-symbol.svg";

// ---- Derived sizes ----
base_size = [
    svg_size.x + margin*2 + shrink*2,
    svg_size.y + margin*2 + shrink*2
];

echo(str("Base size is ", base_size));

// }}}
// Functions {{{

// }}}

// module rounded_square(size, radius) {{{

module rounded_square(size, radius) {
    translate([radius,radius]) {
        minkowski() {
            square([size[0] - 2*radius, size[1] - 2*radius]);
            circle(r=radius, $fn=50);
        }
    }
}


// }}}
// module rounded_cube(size, radius, h) {{{

module rounded_cube(size, radius, h) {
    linear_extrude(h) {
        rounded_square(size, radius);
    }
}

// }}}
// module module border_shape() {{{

module border_shape(size) {
    translate([shrink,shrink,height]) {
        difference() {
            rounded_cube(size, corners, border_height);
            translate([border_width, border_width, 0]) {
                rounded_cube(
                    [ size[0]-border_width*2,
                      size[1]-border_width*2 ],
                    corners,
                    border_height
                );
            }
        }
    }
}

// }}}
// module baseplate(size, text_area_height, border) { {{{

module baseplate(size, text_area_height, border) {
    baseplate_size = [
        size.x,
        size.y + text_area_height
    ];

    minisize = [size.x - shrink*2, size.y - shrink*2];
    echo(str("minisize is ", minisize));

    hull() {
        rounded_cube(baseplate_size, corners, .1);
        translate([shrink,shrink,height]) {
            rounded_cube(minisize, corners, .1);
        }
    }
    if (border) {
        border_shape(size);
    }
}

// }}}
// module sign(size, border) {{{

// Image location is FRONT or BACK
module sign(size, image_location=BACK, border) {
    // Sanity check
    assert(image_location == BACK || image_location == FRONT || image_location == CENTER, 
        "image_location must be BACK or FRONT (for now). Fix it yourself if that's a problem!");
    
    // Baseplate and perhaps holes
    difference() {
        baseplate(base_size, text_area_height, border);
        if (holes) {
            translate([hole_dist,size[1]-hole_dist,-bugfix])
                cylinder(d=hole_d,h=hole_h+bugfix*2);
            translate([size[0]-hole_dist,
                      size[1]-hole_dist,-bugfix])
                cylinder(d=hole_d,h=hole_h+bugfix*2);
        }
    }
    
    // SVG
    back(image_location == BACK ? text_area_height :
         image_location == CENTER ? text_area_height / 2 : 0) {
        translate([
            (size[0] - svg_size[0]) / 2,
            (size[1] - svg_size[1]) / 2,
            height
        ]) {
            linear_extrude(text_height)
                import(graphics_file);
        }
    }

    // Text
    txtpos1 = 3;
    txtpos2 = 34;

    up(height) {
        if (text_area_height > 0) {
            back(image_location == BACK ? text_area_height-txtpos1 :
                 image_location == CENTER ? text_area_height / 2-txtpos1 : 0) {
                right(size.x / 2) {
                    linear_extrude(text_height) {
                        text("Danger", size=22, halign="center", valign="top", font=font_face);
                        fwd(txtpos2)
                        text("Biological hazard", size=10, halign="center", valign="top", font=font_face);
                    }
                }
            }
        }
    }
}

// }}}

// Main code {{{

render() {
    sign(size=base_size, image_location=BACK, border=false);
}

// }}}
