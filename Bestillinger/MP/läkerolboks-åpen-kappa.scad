// vim modeline {{{
//
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker:tw=120
//
// }}}
// Libraries {{{

include <BOSL2/std.scad>
include <BOSL2/miscellaneous.scad>

// }}}
// Oppløsning {{{

// $fn = 0;   // fixed number of fragments
// $fs = 0.5; // minimum fragment size (linear)
// $fa = 3;   // minimum fragment angle (angular)

$fn = 0;     // fixed number of fragments
$fs = 0.125; // minimum fragment size (linear)
$fa = 0.75;  // minimum fragment angle (angular)

// }}}
// Dokumentasjon {{{
//
// Stor, åpen läkerol-boks
//
// Bare ei enkel, stor läkerolboks. Jeg legger ved mål for den lille også. Kunne sikkert bare brukt standard openscad,
// men gøy å bruke BOSL2 også.
//
// KI sier:
//
// Liten Läkerol-eske (ca. 25 g)
// 
// Lengde: ~80–85 mm
// Bredde: ~45–50 mm
// Tykkelse: ~15–18 mm
// 
// Stor Läkerol-eske (ca. 75 g “family pack” / større variant)
// 
// Lengde: ~100–110 mm
// Bredde: ~60–70 mm
// Tykkelse: ~20–25 mm
//
// Lisensiert under CC BY-NC 4.0
//
// Se https://creativecommons.org/licenses/by-nc/4.0/legalcode.en for detaljer
// 
// Skrevet av Roy Sigurd Karlsbakk <roy@karlsbakk.net> in a hot corner of Oslo in May, 2026
//
// }}}
// Variabler {{{

// Se dokumentasjonen for mulige størrelser, det varierer litt.
lakerol_small = [50,20,60]; // liten, 25g
lakerol_large = [60,30,85]; // Stor, 75g
walls = 1.5;
bottom = walls*1.5;
edge_rounding = walls;
lakerol_box = lakerol_large;
lakerol_hull = lakerol_box - [walls*2,walls*2,bottom];

// }}}
// Kode {{{

render(convexity=10) { // Make preview behave correctly
    difference() {
        cuboid(lakerol_box, anchor=FRONT+LEFT+BOT, rounding=edge_rounding,
            edges=[
                TOP+FRONT, TOP+RIGHT, TOP+LEFT, TOP+BACK,
                FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]);
        translate([walls,walls,bottom]) {
            cuboid(lakerol_hull, anchor=FRONT+LEFT+BOT, rounding=edge_rounding,
                edges=[
                    BOTTOM+FRONT, BOTTOM+RIGHT, BOTTOM+LEFT, BOTTOM+BACK,
                    FRONT+RIGHT, FRONT+LEFT, BACK+RIGHT, BACK+LEFT]);
        }
    }
}

// }}}
