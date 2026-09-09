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

// Kun selve label-teksten
mylabel = "0,5";

// Bytt til en stencil-font du har installert (eksempler: "Stardos Stencil", "Stencil")
font_name = "Stardos Stencil:style=Bold";

// Lead-in chamfer (åpningsfas)
chamfer_angle   = 15;    // grader (vinkel mot vertikalen/innerveggen)
chamfer_depth   = 2.5;   // mm (vertikal dybde på fasen, f.eks. 2–3 mm)
chamfer_enabled = true;  // slå av/på fas

// Kun for innsiden (hulrom + fas). Sett f.eks. 96/128 for glattere innside. La være undef for standard.
inner_fn = 16;

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

    // Innvendig hulrom (åpning ved bunn/z=0, topplokk i z=height)
    up(-0.01) {
        if (is_undef(inner_fn)) {
            cylinder(
                d = inner_d,
                h = height - top_thick + 0.01
            );
        } else {
            $fn = inner_fn;
            cylinder(
                d = inner_d,
                h = height - top_thick + 0.01
            );
        }
    }

    // Lead-in fas ved åpningen (innvendig kant ved bunn)
    if (chamfer_enabled) {
        let(
            inner_r = inner_d/2,
            a = chamfer_angle,
            // Sikkerhetsgrenser: ikke gjennom vegg eller dypere enn hulrommet
            max_depth_wall = (wall / tan(a)) - 0.05,
            max_depth_hole = (height - top_thick) - 0.1,
            hch = max(0, min(chamfer_depth, max_depth_wall, max_depth_hole)),
            delta_r = tan(a) * hch
        )
        if (hch > 0)
        translate([0, 0, -0.01]) {
            if (is_undef(inner_fn)) {
                cyl(
                    h = hch + 0.02,
                    r1 = inner_r + delta_r,   // ved åpningen (bunn)
                    r2 = inner_r,             // innover i delen
                    anchor = BOT
                );
            } else {
                $fn = inner_fn;
                cyl(
                    h = hch + 0.02,
                    r1 = inner_r + delta_r,
                    r2 = inner_r,
                    anchor = BOT
                );
            }
        }
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
