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
// Dokumentasjon {{{
//
// Skumplastgreie
//
// Lisensiert under CC BY-NC 4.0
// Se https://creativecommons.org/licenses/by-nc/4.0/legalcode.en for detaljer
// 
// Skrevet av Roy Sigurd Karlsbakk <roy@karlsbakk.net> i et varmt hjørne av Oslo et sted i Mai 2026
//
// }}}
// Variabler {{{

edge_rounding = 5;
text_height = .4;
holder_floor = 1.5;
sponge_dim = [60, 40, 6];
sponge_holder_edge = 8.5;
sponge_holder_dim = sponge_dim + [sponge_holder_edge * 2, sponge_holder_edge * 2, holder_floor];

// }}}
// Code {{{

render(convexity=10) { // Make preview behave correctly
    difference() {
        cuboid(sponge_holder_dim, anchor=FRONT+LEFT+BOT, rounding=edge_rounding,
            edges=[
                TOP+FRONT, TOP+BACK, TOP+LEFT, TOP+RIGHT,
                FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT
            ]);
        translate([sponge_holder_edge, sponge_holder_edge, holder_floor]) {
            cube(sponge_dim);
        }
    }
}

// }}}
// test {{{

// translate([0, -40, 0]) {
//     minkowski() {
//         cube([10,20,30]);
//         sphere(r=2);
//     }
// }
// }}}
