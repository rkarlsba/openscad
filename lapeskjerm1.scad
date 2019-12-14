$fn=64;

indre_d = 50;
ytre_d_bunn = 67;
ytre_d_topp = 100;
hoyde = 123;
tykkelse = 3;

//defaults: cylinder();  yields: cylinder($fn = 0, $fa = 12, $fs = 2, h = 1, r1 = 1, r2 = 1, center = false);
difference() {
    cylinder(h=hoyde, r1=ytre_d_bunn, r2=ytre_d_topp);
    translate([0,0,tykkelse]) {
        cylinder(h=hoyde-tykkelse, r1=ytre_d_bunn-tykkelse, r2=ytre_d_topp-tykkelse);
    }
    cylinder(h=tykkelse, r=indre_d);
}
