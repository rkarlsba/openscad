// Køben

// Helt ok
$fn=$preview ? 32 : 128;

// Superpetimeter
//$fn=1024;

/*
 * Køtype - sett her
 *
 * standard - vanlig delbar kø laga for limetupp
 * husko    - standard huskø laga for skutupp
 *
 */
kotype = "husko";

// Standardkø
ytre_diameter = 13;
indre_diameter = 8;
indre_diameter_krymp = -0.0;
ytre_hoyde = 27;
indre_hoyde_standard = 22.7;
indre_hoyde_husko = 15;
indre_hoyde_krymp = -1;

// Huskø - endrer verdiene som avviker
indre_hoyde = (kotype == "standard") ? indre_hoyde_standard : indre_hoyde_husko;


difference() {
    cylinder(h=ytre_hoyde, d=ytre_diameter);
    translate([0, 0, ytre_hoyde-(indre_hoyde-indre_hoyde_krymp)]) {
        cylinder(h=indre_hoyde-indre_hoyde_krymp, d=indre_diameter-indre_diameter_krymp);
    }
}