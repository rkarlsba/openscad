bredde=10;
lengde=80;
dybde=20;
skruehull=4.5;
skruesynk=2; // mm for skruehull, -1 for v-synk
skruesynk_d=11; // ved v-synk, normalt skruehull * 2

hylleknekt_p = [
    [0, 0],
    [0, lengde],
    [lengde, lengde],
    [lengde, lengde-bredde],
    [bredde*4, lengde-bredde],
    [bredde, lengde-bredde*4],
    [bredde, 0],
];

module skruehull(lengde, dia, synk, synk_d=0) {
    synk_d = (synk_d==0) ? dia*2 : synk_d;  
    rotate([0, 90, 0]) {
        cylinder(h=lengde, d=dia);
        if (synk == -1) {
            translate([0, 0, lengde-dia]) {
                cylinder(h=dia, d1=dia, d2=synk_d);
            }
        } else {
            translate([0, 0, lengde-synk]) {
                cylinder(h=dia, d=synk_d);
            }        
        }
    }
}

difference() {
    linear_extrude(dybde) {

        difference() {
            polygon(hylleknekt_p);
            translate([bredde*4,lengde-bredde*4]) {
                circle(r=bredde*3, $fn=128);
            }
        }
    }
    translate([0, lengde*.45, dybde/2]) {
        skruehull(bredde, skruehull, skruesynk, skruesynk_d, $fn=64);
    }
    translate([0, lengde*.15, dybde/2]) {
        skruehull(bredde, skruehull, skruesynk, skruesynk_d, $fn=64);
    }
    translate([lengde*.85, lengde, dybde/2]) {
        rotate([0,0,270]) {
            skruehull(bredde, skruehull, skruesynk, skruesynk_d, $fn=64);
        }
    }
    translate([lengde*.55, lengde, dybde/2]) {
        rotate([0,0,270]) {
            skruehull(bredde, skruehull, skruesynk, skruesynk_d, $fn=64);
        }
    }
}
