/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */
/* Documentation and credits {{{
 *
 * blomsterkassetak.scad
 *
 * INTRODUCTION AND NAME
 *
 * Blomsterkassetak is Norwegian for "[balcony] planter box roof", so this is a
 * roof/cover to be used with a balcony planter box. Mine has an internal width
 * of 146mm or thereabout and this is made for just that. The size should have
 * been easily adjustable, but not all the code is as good as it shouldn've been
 * and I really should rewrite it all some time I find the time. This is a fine
 * mix between copilot code and my own, since copilot can be pretty far out when
 * it comes to OpenSCAD. 
 *
 * CHANGELOG
 *
 * v0.1.0, 2026-06-25:
 *   Initial version
 *
 * v0.1.1, 2026-06-25:
 *   Code cleanup, translation to English for most of it.
 *
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net>.
 *
 * GENERAL PERFORMANCE NOTE:
 *
 * If you are running OpenSCAD (since more software supports scad these days,
 * after all) and have set 3D Rendering backend to CGAL, the rendering of a
 * large box will take a long time, as in possibly hours. Just don't do it.
 * Upgrade to something recent, even though it's not "stable" and change that
 * setting to "Manifold". It'll speed up rendering by an order of magnitude (or
 * three). If your OpenSCAD doesn't support manifold, it's too old, and that
 * fact is still true if it's the latest release for your platform. At the time
 * of writing this, that version is from back in january 2021 and a *lot* has
 * happened since. Go to https://openscad.org/downloads.html and Scroll down to
 * Development Snapshots and find the latest for your platform. It'll be better,
 * faster, cooler, and probably just as stable as the "stable" release you've
 * been using till now, and *way* fast. I'm not kidding.
 *
 * }}} */
// Libs {{{


// module honeycomb(x, y, dia, wall)
include <honeycomb/honeycomb.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

box_width = 146;
thickness = 3;
x = 155;
y = box_width;
hccellsize = 15;
border_width = 8;
base_height = 20;
roof_height = 150;
side_wall_type = "grid"; // Possible values are "grid", "honeycomb", "blank" and "none"
// side_wall_type = "honeycomb"; // Possible values are "grid", "honeycomb", "blank" and "none"
// side_wall_type = "blank"; // Possible values are "grid", "honeycomb", "blank" and "none"
// side_wall_type = "none"; // Possible values are "grid", "honeycomb", "blank" and "none"

// }}}
// module honeycomb_cylinder(r_outer, wall_thickness, height, cell_d, spacing, rows, angle_span, start_angle, tilt) {{{

module honeycomb_cylinder(
    r_outer = 25,
    wall_thickness = 2,
    height = 80,
    cell_d = 6,
    spacing = 1.5,
    rows = 10,
    angle_span = 360,
    start_angle = 0,
    tilt = 20
) {
    r_inner = r_outer - wall_thickness;

    difference() {
        // Base hollow cylinder
        difference() {
            cylinder(h = height, r = r_outer, $fn = 120);

            translate([0,0,-1]) {
                cylinder(h = height + 2, r = r_inner, $fn = 120);
            }
        }

        // Honeycomb holes
        for (z_i = [0:rows-1]) {
            z = (height / rows) * z_i + (height / rows) / 2;

            // Offset every other row
            angle_offset = (z_i % 2) * ((cell_d + spacing) / r_outer * 180);

            angular_pitch = (cell_d + spacing) / r_outer * 180;
            cols = floor(angle_span / angular_pitch);

            for (a_i = [0:cols]) {
                angle = start_angle + a_i * angular_pitch + angle_offset;

                rotate([0,0,angle]) {
                    rotate([0, tilt, 0]) {
                        translate([r_inner, 0, z]) {
                            cylinder(
                                h = wall_thickness * 3,
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
// module base(x, y, border_width, thickness) {{{

module base(x, y, border_width, height) {
    linear_extrude(height) {
        difference() {
            {
                echo(str("DEBUG-1> x + border_width * 2: ", x + border_width * 2, ", y + border_width * 2: ", y + border_width * 2));
                square([x,y]);
            }
            translate([border_width,border_width]) {
                square([x-border_width*2,y-border_width*2]);
            }
            echo(str("DEBUG-3> x: ", x, ", y: ", y));
        }
    }
}

// }}}
// module grid(size, step, thickness) {{{

// grid(x, 20, thickness, 45);
module grid(size, step, thickness, angle=0) {
    translate([size/2, size/2]) { // flytt sentrum til origo
        rotate([0,0,angle]) {
            translate([-size/2, -size/2]) { // flytt sentrum til origo
                
                // Vertical lines
                for (x = [0:step:size]) {
                    translate([x, 0]) {
                        square([thickness, size + thickness]);
                    }
                }

                // Horizontal lines
                for (y = [0:step:size]) {
                    translate([0, y]) {
                        square([size + thickness, thickness]);
                    }
                }
            }
        }
    }
}

// }}}
// module grid3d(size, step, thickness, angle=0, height=42) {{{

module grid3d(size, step, thickness, angle=0, height=42) {
    linear_extrude(height)
        grid(size, step, thickness, angle);
}

// }}}
// module roof(x, y, thickness, hccellsize, height, border_height) {{{

module roof(x, y, thickness, hccellsize, height, border_height) {
    translate([0, y/2]) {
        // for (a = [0:4.0:174]) {
        for (a = [0:hccellsize*.28:174]) {
            rotate([a,0,0]) {
                translate([0, y/2, 0]) {
                    rotate([90,0,0]) {
                        linear_extrude(height=thickness) {
                            // honeycomb(x,hccellsize*2.9,hccellsize,1);
                            honeycomb(x,hccellsize,5,1);
                        }
                    }
                }
            }
        }
    }
}

// }}}
// module roof_band(x, y, width, width) {{{

module roof_band(x, y, width, width) {
    translate([0, y/2, 0]) {
        rotate([90,0,90]) {
            difference() {
                cylinder(d=x-width+2, h=width);
                cylinder(d=x-width*2, h=width);
                translate([-x/2,-y-15,0]) {
                    cube([x,y,width]);
                }
            }
        }
    }
}

// }}}
// module gable_wall(x, y, width, thickness, hccellsize, walltype="grid") // {{{

module gable_wall(x, y, wall_width, thickness, hccellsize, walltype="grid") {
    echo(str("DEBUG-4: x = ", x, ", y = ", y, ", wall_width = ", wall_width, ", thickness = ", thickness, ", hccellsize = ", hccellsize, " and walltype = \"", walltype, "\""));
    translate([0, y/2, 0]) {
        rotate([90,0,90]) {
            difference() {
                cylinder(d=x-thickness*2, h=wall_width);
                cylinder(d=x-thickness*3, h=wall_width);
                translate([-x/2,-y,0]) {
                    cube([x,y,wall_width]);
                }
            }
            translate([0, thickness, wall_width]) {
                difference() {
                    intersection() {
                        translate([-x/2,-y/2,-thickness]) {
                            linear_extrude(thickness*2)
                            {
                                if (walltype == "honeycomb") {
                                    // module honeycomb(x, y, dia, wall)
                                    honeycomb(x, y, hccellsize/3, thickness/5);
                                } else if (walltype == "grid") {
                                    grid(x, 20, thickness, 45);
                                } else if (walltype == "plain") {
                                    cube([x, y, wall_width]);
                                } else if (walltype == "none") {
                                    // nada
                                } else {
                                    assert(str("Invalid wall type \"", walltype, "\". Giving up!\n"));
                                }
                            }
                        }
                        translate([0,-6,-4]) {
                            cylinder(d=x-thickness*2, h=thickness*2);
                        }
                    }
                    translate([-x/2,-y,-thickness]) {
                        cube([x,y-7,wall_width]);
                    }
                }
            }
        }
    }
}

// }}}
// main() {{{

render(convexity=4)
{
    base(x, y, border_width, base_height);
    translate([0,0,base_height]) {
        roof(x, y, thickness, hccellsize, roof_height);
        translate([x-10, 0, 0]) {
            roof_band(x, y, 10, 8);
            gable_wall(
                x = x,
                y = y,
                wall_width = border_width,
                thickness = thickness,
                hccellsize = hccellsize,
                walltype = side_wall_type
            );
        }
        roof_band(x, y, 10, 8);
        translate([10, 0, 0]) {
            mirror([1,0,0]) {
                gable_wall(
                    x = x,
                    y = y,
                    wall_width = border_width,
                    thickness = thickness,
                    hccellsize = hccellsize,
                    walltype = side_wall_type
                );
            }
        }
    }
}

// }}}
