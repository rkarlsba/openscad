/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */
/* Documentation and credits {{{
 *
 * urtehjell.scad
 *
 * This is an attempt to make a form of drying stand for herbs, since I just got
 * a nice collection of those myself and they're growing all to fast and needs
 * to get dried. Problem is, if you just toss them in an open box, then the
 * ones at bottom, quite easily rots and that can spread, so, I thought of some
 * sort of rack where I could spread them out.
 *
 * THE NAME
 *
 * Urtehjell is a contraction of "urt", meaning "herb", a genitive-e and
 * "hjell", which best translates to fish flake, that is, a specialized rack for
 * drying fish. So I'll just borrow that word, becuse even it's very specific,
 * rules are there to be broken!
 * 
 * CHANGELOG
 *
 * v0.1.0, 2026-06-16:
 *   Initial version
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

// ../../libraries/honeycomb/honeycomb.scad
// module honeycomb(x, y, dia, wall)  {

include <honeycomb/honeycomb.scad>
// include <BOSL2/std.scad>;

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

kassebredde = 146;
thickness = 2;
x = 155;
y = kassebredde;
hccellsize = 15;
border_width = 8;
base_thickness = 20;
roof_height = 150;
sidevegg_type = "grid"; // Possible values are "grid", "honeycomb", "blank" and "none"

// }}}
// module bunnramme(x, y, border_width, thickness) {{{

module bunnramme(x, y, border_width, thickness) {
    // Bunnramme
    linear_extrude(thickness) {
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

module grid(size, step, thickness, angle=0)
{
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
// module tak(x, y, thickness, hccellsize, height, border_height) {{{

module tak(x, y, thickness, hccellsize, height, border_height) {
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
// module buet_sidevegg(x, y, thickness, hccellsize, height) {{{

module buet_sidevegg(x, y, thickness, hccellsize, height) {
    translate([0, y/2, border_width+2]) {
        for (a = [0:hccellsize*.28:174]) {
            rotate([a,0,0]) {
                translate([0, y/2, 0]) {
                    rotate([90,0,0]) {
                        
                        // VENSTRE vegg
                        translate([0, 0, 0])
                            cube([thickness, hccellsize, thickness]);

                        // HØYRE vegg
                        translate([x-thickness, 0, 0])
                            cube([thickness, hccellsize, thickness]);
                    }
                }
            }
        }
    }
}

// }}}
// module buet_sidevegg_glatt(x, y, thickness, step=2) {{{

module buet_sidevegg_glatt(x, y, thickness, step=2) {
    translate([0, y/2, border_width]) {

        for (a = [0:step:180-step]) {
            hull() {
                for (aa = [a, a+step]) {
                    rotate([aa,0,0]) {
                        translate([0, y/2, 0]) {
                            rotate([90,0,0]) {

                                // VENSTRE
                                translate([0,0,0])
                                    cube([thickness, 1, thickness]);

                                // HØYRE
                                translate([x-thickness,0,0])
                                    cube([thickness, 1, thickness]);
                            }
                        }
                    }
                }
            }
        }
    }
}

// }}}
// module takkant(x, y, width, thickness) {{{

module takkant(x, y, width, thickness) {
    translate([0, y/2, 0]) {
        rotate([90,0,90]) {
            difference() {
                cylinder(d=x-thickness+2, h=width);
                cylinder(d=x-thickness*2, h=width);
                translate([-x/2,-y-15,0]) {
                    cube([x,y,width]);
                }
            }
        }
    }
}

// }}}
// module gavlvegg(x, y, width, thickness) {{{

module gavlvegg(x, y, width, thickness, hccellsize, type="grid") {
    translate([0, y/2, 0]) {
        rotate([90,0,90]) {
            difference() {
                cylinder(d=x-thickness, h=width);
                cylinder(d=x-thickness*2, h=width);
                translate([-x/2,-y,0]) {
                    cube([x,y,width]);
                }
            }
            translate([0, thickness-1, thickness/2]) {
                difference() {
                    intersection() {
                        translate([-x/2,-y/2,0])
                        linear_extrude(thickness) {
                            if (sidevegg_type == "honeycomb") {
                                honeycomb(x, y, hccellsize/4, thickness/4);
                            } else if (sidevegg_type == "grid") {
                                grid(x, 20, thickness/4, 45);
                            } else if (sidevegg_type == "plain") {
                                cube([x,y,width]);
                            } else if (sidevegg_type == "none") {
                                // nada
                            } else {
                                assert(str("Invalid wall type \"", sidevegg_type, "\". Giving up!\n"));
                            }
                        }
                        translate([0,-6,-2]) cylinder(d=x-thickness*2, h=thickness);
                    }
                    translate([-x/2,-y,0]) {
                        cube([x,y-7,width]);
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
    bunnramme(x, y, border_width, base_thickness);
    translate([0,0,base_thickness]) {
        tak(x, y, thickness, hccellsize, roof_height);
        translate([x-10, 0, 0]) {
            gavlvegg(x, y, 10, 8, hccellsize);
            takkant(x, y, 10, 8);
        }
        takkant(x, y, 10, 8);
        translate([thickness*5, 0, 0]) {
            mirror([1,0,0]) {
                gavlvegg(x, y, 10, 8, hccellsize);
            }
        }
    }
    // buet_sidevegg(x, y, 10, hccellsize, thickness);
    // buet_sidevegg_glatt(x, y, 10);
    //
    // width = 10;
    // translate([200,200,0]) rotate([90,0,90]) linear_extrude(5) grid(100, 10, 1, 45);
}

// }}}
