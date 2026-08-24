/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */
/* Documentation and credits {{{
 *
 * lora-adapterring.scad
 *
 * INTRODUCTION AND NAME
 *
 * CHANGELOG
 *
 * v0.1.0, 2026-07-08:
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

// use <nuts_and_bolts_v1.9.6.scad>

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

debug = true; // Turn this off for producion
wall_thickness = 2.3;
ring_ext_width = 16.1;
ring_int_width = 7.0;
ring_lip_height = 1.2;
ring_lip_width = 2.0;
nub_dia = 2.5;
nub_spacing = 0;
nub_height = 1.0;
nub_vpos_from_h = wall_thickness + nub_dia / 2 + nub_spacing;
ring_height = nub_vpos_from_h + nub_dia;
nub_vpos = ring_height - nub_vpos_from_h;

// }}}
// Debug {{{

if (debug) {
    echo(str("nub_vpos_from_h is ", nub_vpos_from_h));
    echo(str("nub_vpos is ", nub_vpos));
    echo(str("ring_height is ", ring_height));
}

// }}}
// module jalladrit(asdf=0) {{{

module jalladrit(asdf) {
}

// }}}
// module adapterring() {{{

module adapterring() {
    difference() {
        union() {
            cylinder(d = ring_ext_width, h = ring_height);
            for (x = [ring_ext_width/2, -ring_ext_width/2] ) {
                translate([x, 0, nub_vpos]) {
                    scale([0.5,1,1]) {
                        sphere(d=nub_dia);
                    }
                }
            }
            translate([0, 0, ring_height]) {
                cylinder(d = ring_ext_width + ring_lip_width, h = ring_lip_height);
            }
        }
        cylinder(d = ring_int_width, h = ring_height + ring_lip_height);
        nut_trap_inline(spec="M5", height=ring_height + ring_lip_height - ring_lip_height, $slop=.10);
    }
}

// }}}
// main() {{{

render(convexity=4){
    adapterring();
}

// }}}
