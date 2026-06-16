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
/* Variables {{{

// Dimension presets
midt_midt = [180, 135, 120];
smal_framme = [200, 85, 110];

// Settings
size = smal_framme;     // Total size of the basket
dia = 22;               // Honeycomb cell diameter
honeycomb_wall = 4;     // Honeycomb wall width
thickness = 3.5;        // Bottom and wall thickness
border = 10;            // Border width for each panel

}}} */
/* module draw_panel(size, border, dia, honeycomb_wall) {{{
 * */

module draw_panel(size, border, dia, honeycomb_wall) {
    linear_extrude(thickness) {
        difference() {
            square(size);
            translate([border,border]) {
                square(size-[border*2,border*2]);
            }
        }
        translate([border,border]) {
            honeycomb(size[0]-border*2, size[1]-border*2, dia, honeycomb_wall);
        }
    }
}

/* }}} */
/* module draw_basket(size, border, dia, honeycomb_wall) {{{
 * */
module draw_basket(size, border, dia, honeycomb_wall) {
    // Bunnplata
    draw_panel([size[0], size[1]], border, dia, honeycomb_wall);

    // Venstre vegg
    translate([thickness, 0, 0]) {
        rotate([0, 270, 0])
        {
            draw_panel([size[2], size[1]], border, dia, honeycomb_wall);
        }
    }

    // Hæyre vegg
    translate([size[0], 0, 0]) {
        rotate([0, 270, 0])
        {
            draw_panel([size[2], size[1]], border, dia, honeycomb_wall);
        }
    }

    // Hitre vegg
    translate([0, size[1], 0]) {
        rotate([90, 0, 0])
        {
            draw_panel([size[0], size[2]], border, dia, honeycomb_wall);
        }
    }

    // Ditre vegg
    translate([0, thickness, 0]) {
        rotate([90, 0, 0])
        {
            draw_panel([size[0], size[2]], border, dia, honeycomb_wall);
        }
    }
}
/* }}} */
/* Main program {{{

draw_basket(size, border, dia, honeycomb_wall);

/* }}} */
