/*
 * Monteringsplate for terminalblokk, typisk brukt i bil.
 *
 * Skrevet av Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 *
 * Lisensiert under Creative Commons BY-NC-SA v4
 *   https://creativecommons.org/licenses/by-nc-sa/4.0/deed.no
 */

// Generelle moduler
module roundedcube(size, radius) {
    translate([radius,radius,radius]) {
        hull() {
            for (z = [0, size[2]-radius*2]) {
                translate([0, 0, z]) sphere(r=radius);
                translate([size[0]-radius*2, 0, z]) sphere(r=radius);
                translate([0, size[1]-radius*2, z]) sphere(r=radius);
                translate([size[0]-radius*2, size[1]-radius*2, z]) sphere(r=radius);
            }
        }
    }
}

module skruehull(diameter, lengde, innsenkning = 0) {
    cylinder(d = diameter, h = lengde);
    if (innsenkning != 0) {
        translate([0, 0, lengde-innsenkning]) {
            cylinder(h=innsenkning, d1=diameter, d2=diameter+innsenkning);
        }
    }
}
// Variabler

// Antall fasetter på en sirkel
$fn = $preview ? 16 : 64;

// Monteringsplata, ytre mål.
platebredde = 150;
platedybde = 40;
platehoyde = 8;

// Indre ramme for montering av terminalblokk. Dette er indre mål, 
// så ytre mål blir indre + rammetykkelse * 2
rammehoyde = platehoyde;
rammebredde = 100;
rammedybde = 20;
rammetykkelse = 3;

hullbredde = 3;
innsenkning = 2;

// Ymse
avrunding = 1.5;


// regne ut x og y for plassering av  ramma for å få den sentrert på toppen
pos_x = (platebredde - rammebredde)/2 - rammetykkelse;
pos_y = (platedybde - rammedybde)/2 - rammetykkelse;
echo("Posisjoner", pos_x,pos_y,platehoyde);

// regne ut størrelsen på ytterrammma
str_x = rammebredde + rammetykkelse * 2;
str_y = rammedybde + rammetykkelse * 2;
echo("Størrelse", str_x, str_y);

// Lokale moduler - bruker variablene over som globale
module ramme() {
    translate([pos_x,pos_y,platehoyde]) {
        difference() {
            // Utvid denne 'avrunding' nedover sånn at den ikke blir avrunda under.
            translate([0, 0, -avrunding]) {
                roundedcube([str_x, str_y, rammehoyde+avrunding], avrunding);
            }
            translate([rammetykkelse,rammetykkelse,0]) {
                cube([rammebredde, rammedybde, rammehoyde]);
            }
        }
    }
}

module bunnplate() {
    difference() {
        // Monteringsplata
        translate([0, 0, -avrunding]) {
            difference() {
                roundedcube([platebredde,platedybde,platehoyde+avrunding], avrunding);
                cube([platebredde,platedybde,avrunding]);
                translate([(innsenkning/2+avrunding)*2, (innsenkning/2+avrunding)*2, avrunding]) {
                    skruehull(diameter=hullbredde, lengde=platehoyde, innsenkning = innsenkning);
                }
                translate([platebredde-(innsenkning/2+avrunding)*2, (innsenkning/2+avrunding)*2, avrunding]) {
                    skruehull(diameter=hullbredde, lengde=platehoyde, innsenkning = innsenkning);
                }
                translate([(innsenkning/2+avrunding)*2, platedybde-(innsenkning/2+avrunding)*2, avrunding]) {
                    skruehull(diameter=hullbredde, lengde=platehoyde, innsenkning = innsenkning);
                }
                translate([platebredde-(innsenkning/2+avrunding)*2, platedybde-(innsenkning/2+avrunding)*2, avrunding]) {
                    skruehull(diameter=hullbredde, lengde=platehoyde, innsenkning = innsenkning);
                }
            }
        }
        echo("Bunnplate", [platebredde,platedybde,platehoyde], avrunding);
    }
    echo("Skruehull", (innsenkning/2+avrunding)*2, (innsenkning/2+avrunding)*2, 2);
    echo("Translate (skruehull)", [(innsenkning/2+avrunding)*2, (innsenkning/2+avrunding)*2, 0]);
}

module platemedramme() {
    union() {
        ramme();
        bunnplate();
    }
}


platemedramme();
