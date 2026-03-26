/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 *
 * oppvaskmaskinkurv1.scad
 *
 * This is a basket for dishwasher use. Dimensions are predefined below, just
 * make one and set size = that_one. 
 *
 * This uses the honeycomb library available from
 * https://www.printables.com/model/263718-honeycomb-library-openscad
 *
 * Some of the variables and comments are in Norwegian, live with it!
 *
 * CHANGELOG
 *
 * v0.1.0, 2026-03-25:
 *   Initial version
 *
 * v0.1.1, 2026-03-26: 
 *   Increased honeycomb_wall from 2.5mm to 4mm, since the initial print came
 *   out missing parts of the structure that just broke off. Also, More docs.
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
 * three). I'm not kidding.
 *
 */

include <honeycomb/honeycomb.scad>

// Dimension presets
midt_midt = [180, 135, 120];
smal_framme = [200, 85, 110];

// Settings
size = smal_framme;     // Total size of the basket
dia = 22;               // Honeycomb cell diameter
honeycomb_wall = 4;     // Honeycomb wall width
thickness = 3.5;        // Bottom and wall thickness
border = 10;            // Border width for each panel

// And code
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

draw_basket(size, border, dia, honeycomb_wall);
