/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */
// Libs {{{

// ../../libraries/honeycomb/honeycomb.scad
// module honeycomb(x, y, dia, wall)  {

include <honeycomb/honeycomb.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

test = false;
kassebredde = 146;
thickness = 2;
x = 155;
y = kassebredde;
hccellsize = 15;
border_width = test ? 4 : 8;
border_thickness = test ? thickness : 10;
roof_height = 150;

// }}}
// module honeycomb_cylinder(r_outer, wall_thickness, height, cell_d, spacing, rows, angle_span, start_angle, tilt) {{{

module honeycomb_cylinder(
    r_outer = 25,
    wall_thickness = 2,
    height = 80,
    cell_d = 6,
    spacing = 1,
    angle_span = 360,
    start_angle = 0
) {
    r_inner = r_outer - wall_thickness;

    pitch      = cell_d + spacing;
    z_step     = pitch * sqrt(3) / 2;
    angle_step = pitch / r_outer * 180 / PI;

    difference() {
        // Tube
        difference() {
            cylinder(h = height, r = r_outer, $fn = 120);
            translate([0,0,-1]) {
                cylinder(h = height + 2, r = r_inner, $fn = 120);
            }
        }

        // Rows
        rows = ceil(height / z_step);
        for (row = [0:rows-1]) {
            z = row * z_step + z_step / 2;

            // ✅ 50% offset every other row
            row_offset = (row % 2) * (angle_step / 2);

            // Columns
            cols = ceil(angle_span / angle_step);

            for (col = [0:cols]) {
                angle = start_angle + col * angle_step + row_offset;
                if (angle <= start_angle + angle_span) {
                    rotate([0,0,angle]) {
                        translate([r_inner, 0, z]) {
                            // ✅ radial hex cutter (THIS is the important part)
                            cylinder(
                                h = wall_thickness * 4,
                                r = cell_d / 2,
                                $fn = 6,
                                center = true
                            );
                        }
                    }
                }
            }
        }
    }
}

// }}}
// main() {{{

render(convexity=4) {
    honeycomb_cylinder();
}

// }}}
