// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Test
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY-NC-SA v4.0 or later. Please see
// https://creativecommons.org/licenses/by-nc-sa/4.0/ for details.
//

include <honeycomb.scad>

bredde_totalt = 51;
lengde_totalt = 137;
bredde_skaft = 37;
hoyde_skaft = 90;
vinkel = 150;
ramme = 5;

ytterskrape = [
    [0,0],
    [-bredde_skaft/2,tan(vinkel) * (0 - bredde_skaft/2)],
    [-bredde_skaft/2,hoyde_skaft],
    [-bredde_totalt/2,hoyde_skaft+tan(vinkel) * (0 - (bredde_totalt-bredde_skaft)/2)],
    [-bredde_totalt/2,lengde_totalt],
    [bredde_totalt/2,lengde_totalt],
    [bredde_totalt/2,hoyde_skaft+tan(vinkel) * (0 - (bredde_totalt-bredde_skaft)/2)],
    [bredde_skaft/2,hoyde_skaft],
    [bredde_skaft/2,tan(vinkel) * (0 - bredde_skaft/2)],
];

innerskrape = [
    [0,ramme],
    [-bredde_skaft/2+ramme,tan(vinkel) * (0 - bredde_skaft/2)+ramme/2],
    [-bredde_skaft/2+ramme,hoyde_skaft+ramme/2],
    [-bredde_totalt/2+ramme,hoyde_skaft+tan(vinkel) * (0 - (bredde_totalt-bredde_skaft)/2)+ramme/2],
    [-bredde_totalt/2+ramme,lengde_totalt-ramme],
    [bredde_totalt/2-ramme,lengde_totalt-ramme],
    [bredde_totalt/2-ramme,hoyde_skaft+tan(vinkel) * (0 - (bredde_totalt-bredde_skaft)/2)+ramme/2],
    [bredde_skaft/2-ramme,hoyde_skaft+ramme/2],
    [bredde_skaft/2-ramme,tan(vinkel) * (0 - bredde_skaft/2)+ramme/2],
];

module ramme() {
    difference() {
        polygon(ytterskrape);
        polygon(innerskrape);
    }
}

linear_extrude(7) {
    intersection() {
        polygon(innerskrape);
        translate([-bredde_totalt-7.15,-37.9]) {
            rotate([0,0,30]) {
                // module honeycomb(x, y, dia, wall)
                honeycomb(bredde_totalt*4, lengde_totalt*2, 14.74, 1.77);
            }
        }
    }
    ramme();
}

