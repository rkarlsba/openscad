// Dings!
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker

// Biblioteker
// use <ymse.scad>

// Oppløsningk
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Variabler
kryssbredde = 2;
krysshoyde = kryssbredde; // gjetter her

sylinder_ytre_d = 19.9; // diameter på den store
sylinder_ytre_h = 40; // høyde på den store
sylinder_indre_d = 14.8;
sylinder_indre_h = sylinder_ytre_h+krysshoyde;
sylinder_midten_d = 6.4;
sylinder_midten_h = krysshoyde;

hoyde = 40; // hele greia

render(convexity=10) {
    cylinder(h=sylinder_ytre_h, d=sylinder_ytre_d);
    difference() {
        cylinder(h=sylinder_indre_h, d=sylinder_indre_d);
        translate([-sylinder_ytre_d/2, -kryssbredde/2, sylinder_ytre_h]) {
            cube([sylinder_ytre_h, kryssbredde, krysshoyde]);
        }
        translate([-kryssbredde/2, -sylinder_ytre_d/2, sylinder_ytre_h]) {
            cube([kryssbredde, sylinder_ytre_h, krysshoyde]);
        }
        translate([0, 0, sylinder_ytre_h]) {
            cylinder(h=sylinder_midten_h, d=sylinder_midten_d);
        }
    }
}
