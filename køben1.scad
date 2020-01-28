// Køben

// Helt ok
//$fn=64;

// Superpetimeter
$fn=1024;

ytre_diameter = 13;
indre_diameter = 8;
indre_diameter_krymp = -0.0;
ytre_hoyde = 27;
indre_hoyde = 22.7;
indre_hoyde_krymp = -1;

difference() {
    cylinder(h=ytre_hoyde, d=ytre_diameter);
    translate([0, 0, ytre_hoyde-(indre_hoyde-indre_hoyde_krymp)]) {
        cylinder(h=indre_hoyde-indre_hoyde_krymp, d=indre_diameter-indre_diameter_krymp);
    }
}