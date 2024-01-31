$fn=$preview ? 64 : 256;

dia=44;
skall=2;
var=2.9;
h=15;
feste_h=3.5;
feste_b=7;

module dings(di, dy) {
    difference() {
        circle(d=di);
        translate([0,-di/2]) {
            square([di,di]);
        }
    }
    translate([0,-di/2]) {
        square([dy,di]);
    }
}

module skjerm(h) {
    linear_extrude(h) {
        difference() {
            dings(di=dia, dy=dia/var);
            dings(di=dia-skall, dy=dia/var);
        }
    }
}

module feste_hunn(di,sk,h,b) {
    difference() 
    {
        skjerm(feste_h);
        translate([0,di/2-sk/4*3,0]) {
            cube([b,sk,h]);
        }
        translate([b/4,-di/2-sk/4,0]) {
            cube([b,sk,h]);
        }
        translate([-di/2,-b/2,0]) {
            cube([sk,b,h]);
        }
    }
}

module feste_hann(di,sk,h,b) {
    difference() {
        skjerm(h);
        feste_hunn(di,sk,h,b);
    }
}

module midt(h=h) {
    feste_hunn(dia, skall, feste_h, feste_b);
    translate([0,0,feste_h]) {
        skjerm(h);
        translate([0,0,h]) {
            feste_hann(dia, skall, feste_h, feste_b);
        }
    }
}

module hannkant(h=h) {
    skjerm(h);
    translate([0,0,h]) {
        feste_hann(dia, skall, feste_h, feste_b);
    }
}

module hunnkant(h=h) {
    feste_hunn(dia, skall, feste_h, feste_b);
    translate([0,0,feste_h]) {
        skjerm(h);
    }
}

//hannkant(h=150);
skjerm(h=195);