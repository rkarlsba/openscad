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
// main() {{{

bunnramme(x, y, border_width, border_thickness);
translate([0,0,border_thickness]) {
    tak(x, y, thickness, hccellsize, roof_height);
}

// }}}
