bredde=12;
lengde=140;
dybde=20;

hylleknekt_p = [
    [0, 0],
    [0, lengde+bredde],
    [lengde+bredde, lengde+bredde],
    [lengde+bredde, lengde],
    [bredde*5, lengde],
    [bredde, lengde-bredde*4],
    [bredde, 0],
];

module skruehull(lengde, dia) {
    rotate([0, 90, 0]) {
        cylinder(h=lengde, d=dia);
        translate([0, 0, lengde-dia]) {
            cylinder(h=dia, d1=dia, d2=dia*2);
        }
    }
}

difference() {
    linear_extrude(dybde) {

        difference() {
            polygon(hylleknekt_p);
            translate([bredde*5,lengde-bredde*4])
                circle(r=bredde*4, $fn=128);
        }
        translate([lengde+bredde*2.4,lengde+bredde/2]) {
            difference() {
                circle(d=bredde*4.8, $fn=128);
                circle(d=bredde*2.8, $fn=128);
                translate([-bredde*2.4,bredde/2,0]) {
                    square([bredde*4.8,bredde*2]);
                }
            }
        }
    }
    translate([0, lengde*.6, dybde/2]) {
        skruehull(bredde, 3, $fn=64);
    }
    translate([0, lengde*.15, dybde/2]) {
        skruehull(bredde, 3, $fn=64);
    }
}