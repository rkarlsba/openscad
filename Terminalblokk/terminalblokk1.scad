/*
 * Monteringsplate for terminalblokk, typisk brukt i bil.
 *
 * Skrevet av Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 *
 * Lisensiert under Creative Commons BY-NC-SA
 *   https://creativecommons.org/licenses/by-nc-sa/4.0/deed.no
 */

// Moduler
module roundedcube(size, radius) {
    translate([radius,radius,radius]) {
        hull() 
        {
            for (z = [0, size[2]-radius*2]) {
                translate([0, 0, z]) sphere(r=radius);
                translate([size[0]-radius*2, 0, z]) sphere(r=radius);
                translate([0, size[1]-radius*2, z]) sphere(r=radius);
                translate([size[0]-radius*2, size[1]-radius*2, z]) sphere(r=radius);
            }
        }
    }
}

// Variabler

// Antall fasetter på en sirkel
$fn = 32;

// Monteringsplata, ytre mål.
platebredde = 150;
platedybde = 40;
platehoyde = 10;

// Indre ramme for montering av terminalblokk. Dette er indre mål, 
// så ytre mål blir indre + rammetykkelse * 2
rammehoyde = platehoyde;
rammebredde = 100;
rammedybde = 30;
rammetykkelse = 3;

// Ymse
avrunding = 1;

// Programkode
roundedcube([rammebredde,rammedybde,rammehoyde], avrunding);
