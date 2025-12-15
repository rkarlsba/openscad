/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */
include <ymse.scad>

$fn = $preview ? 64 : 512;

bugfix = $preview ? .1 : 0;

kuledia = 200;
kutt = 85;
tykkelse = 5;
bunn = 3;
mellomgulv = 3;
klippeito = true;

module hul_kule(dia, tykkelse) {
    difference() {
        sphere(d=dia);
        sphere(d=dia-tykkelse);
    }
}

module halvkule(dia, tykkelse) {
    difference() {
        hul_kule(dia, tykkelse);
        translate([-dia/2,-dia/2,-dia/2]) {
            cube([dia,dia,dia/2]);
        }
    }
}

// Main
module main() {
    halvkule(kuledia, tykkelse);
    if (bunn > 0) {
        cylinder(d=kuledia,h=bunn);
    }
    if (mellomgulv > 0) {
        r = kuledia/2;
        mh = r/2;
        pe = sqrt(pow(r,2)-pow(mh,2));
        echo(str("kuledia = ", kuledia, ", mh = ", mh, " og pe = ", pe));
        translate([0,0,mh]) {
            cylinder(r=pe-bunn,h=bunn);
        }
    }
}

if (klippeito) {
    difference() {
        main();
        translate([0,-kuledia/2,-bugfix]) {
            cube([kuledia/2,kuledia,kuledia/2]);
        }
    }
} else {
    main();
}

