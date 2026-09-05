// Vim modeline {{{
//
// vim:ts=4:sw=4:sts=4:et:ai:si:tw=100:fdm=marker
//
// }}}
// Copyright or left and author info {{{
//
// Copyleft 2026 Roy Sigurd Karlsbakk (lots of changes)
//
// }}}
// Includes and usees {{{

include <BOSL2/std.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Globals {{{

inner_d     = 25;    // innvendig diameter
wall        = 2;     // veggtykkelse
height      = 12;    // total høyde
top_thick   = 2;     // tykkelse på topplokk
rounding    = 1.2;   // avrunding toppkant
fontsize    = 9.0;   // fontsize

mylabel = "0,25";

// Bytt til en stencil-font du har installert (eksempler: "Stardos Stencil", "Stencil")
font_name = "Stardos Stencil:style=Bold";

// Chamfer-parametre
chamfer_angle = 15;   // grader
chamfer_depth = 1.0;  // mm (vertikal dybde på chamferen)

// }}}
// Model {{{

// ------------------
// Hovedmodell
// ------------------

difference() {

    // Ytre form
    cyl(
        d = inner_d + wall*2,
        h = height,
        rounding1 = 0,
        rounding2 = rounding,
        anchor = BOT
    );

    // Innvendig hulrom
    up(-0.01) {
        cylinder(
            d = inner_d,
            h = height - top_thick + 0.01
        );
    }

    // Tekst (gjennomskjært, men med stencil-font)
    translate([0, 0, height - top_thick - 0.2]) {
        linear_extrude(top_thick + 1) {
            text(
                mylabel,
                size = fontsize,
                halign = "center",
                valign = "center",
                font = font_name
            );
        }
    }
}

// (FJERNET) Broer gjennom tallene – ikke nødvendig med stencil-font

// }}}
