/* bt-nøkkel.scad
 *
 * Nøkkel til tøkepapirdispenser fra Biltema
 *
 * Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 * Lisensiert under https://creativecommons.org/licenses/by-nc-sa/4.0/deed.no
 */
 
$fn=$preview ? 8 : 16;

indre_triangel_r = 3;
indre_triangel_lengde = 30;
indre_triangel_hoyde = 7;

midtre_triangel_bredde = 12;
midtre_triangel_hoyde = 5;

/*
 * Versjon a: Tykkelse 3,0
 * Versjon b: Tykkelse 2,8
 * Versjon c: Tykkelse 2,8 */
tykkelse = 2.8;

pinnebredde=9.5;
pinnelengde=14;
pinneglippe=20.5;

module indre_triangel() {
    translate([indre_triangel_r,indre_triangel_r,0]) {
        hull() {
            cylinder(r=indre_triangel_r,h=tykkelse);
            translate([indre_triangel_lengde,0,0])
                cylinder(r=indre_triangel_r,h=tykkelse);
            translate([indre_triangel_lengde/2, indre_triangel_hoyde,0]) 
                cylinder(r=indre_triangel_r,h=tykkelse);
        }
    }
}

module midtre_triangel() {
    translate([indre_triangel_r,indre_triangel_r,0]) {
        hull() {
            cylinder(r=indre_triangel_r,h=tykkelse);
            translate([indre_triangel_lengde+midtre_triangel_bredde*2,0,0])
                cylinder(r=indre_triangel_r,h=tykkelse);
            translate([indre_triangel_lengde/2+midtre_triangel_bredde, indre_triangel_hoyde+midtre_triangel_hoyde,0]) 
                cylinder(r=indre_triangel_r,h=tykkelse);
// translate([indre_triangel_lengde/2+midtre_triangel_bredde*2, indre_triangel_hoyde+midtre_triangel_hoyde*2,0]) 
        }
    }
}

module pinne() {
    r1=1.5;
    r2=r1*2;
    
    hull() {
        translate([r1,r1,0]) sphere(r1);
        translate([pinnebredde+r1,r1,0]) sphere(r1);
        translate([pinnebredde,pinnelengde-r2,0]) sphere(r2);
        translate([r2,pinnelengde-r2,0]) sphere(r2);
    }
}

module pinner() {
    pinne();
    translate([pinneglippe+pinnebredde,0,0])
        pinne();
}

module nokkelpinner() {
    // font="Urban Sketch:style=Regular"
    font="X.Template:style=Regular";
    
    cube([pinnebredde,pinnelengde,tykkelse]);
    translate([pinneglippe+pinnebredde,0,0]) {
        difference() {
            cube([pinnebredde,pinnelengde,tykkelse]);
//            translate([2,2,0]) linear_extrude(tykkelse) text("b", font=font, size=8);
        }
    }
}

module nokkel() {
    difference() {
        midtre_triangel();
        translate([midtre_triangel_bredde, midtre_triangel_hoyde/2,0]) {
            indre_triangel();
        }
    }
//    translate([indre_triangel_lengde+pinnebredde,-pinnelengde,,0]) { nokkelpinne(); }
//    translate([indre_triangel_lengde-pinnebredde,-pinnelengde,,0]) {
    translate([10,-pinnelengde,0]) {
        nokkelpinner();
    }
}

//pinner();
nokkel();
