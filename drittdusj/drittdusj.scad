$fn = $preview ? 18 : 64;

use <threadlib/threadlib.scad>

d1 = 35;
d2_min = 41;
d2_max = 44;
d2 = d2_max;
d3 = 33;
d4 = 37;
d_skip = 3;
cwalls = 5;

h1 = 28.5;
h2 = 14;
h3 = 6;
h4 = 28.5;
//
knott_ytre_d = d2;
knott_t = 6;
knott_b = 11;

a_inner=d1+3;
a_inner2=a_inner+3;
a_outer=a_inner+10;
a_outer2=a_outer+3;

storesfaere = 51;
lillesfaere=d4;

skruetype = "M10";

module spylefaen() {
    difference() {
        union() {
            cylinder(d=d1, h=h1);
            translate([0,0,h1]) {
                cylinder(d=d2, h=h2);
                translate([0,0,h2]) {
                    cylinder(d=d3, h=h3);
                    translate([0,0,h3]) {
                        cylinder(d=d4, h=h4/2);
                        translate([0,0,h4/2]) {
                            sphere(d=d4);
                        }
                    }
                }
            }
        }
        //cylinder(d=d1-cwalls, h=h1*2);
    }
}

module hode() {
    a_inner=38;
    a_inner2=41;
    a_outer=48;
    a_outer2=51;

    difference() {
        union() {
//            cylinder(d=d4, h=h4/2);
//            translate([0,0,0]) {
                sphere(d=storesfaere);
//            }
        }
        union() {
  //          translate([0,0,h4/2]) {
                sphere(d=lillesfaere);
//            }
            translate([0,0,18]) {
                cylinder(d=12, h=10);
            }
            translate([-a_outer2/2,-a_outer2/2,-a_outer2]) {
                cube([a_outer2,a_outer2,a_outer2]);
            }
        }
    }
    translate([0,0,18]) {
        nut(skruetype, turns=4, Douter=12);
    }
}

module adapterdrit(hann=1) {
    a_h=15;
    x=17;

    module kropp(hode=1) {
        difference() {
            union() {
                cylinder(d=a_outer, h=h1-1);
                difference() {
                    union() {
                        cylinder(d=a_outer2, h=h1+h2+h3+h4/3*2-1);
    // <hode>
                        if (hode) {
                            hode();
                        }
    // </hode>

                    }
                    union() {
                        cylinder(d=a_inner2+4, h=h1+h2+h3+h4/3*2+1);
                        rotate([0,0,90]) {
                            rotate_extrude(angle = 180, convexity = 2) {
                                square([a_outer2/2,h1+h2+h3+h4/3*2-1]);
                            }
                        }
                    }
                }
            }
            union() {
                cylinder(d=a_inner, h=h1+1);
                rotate([0,0,90]) {
                    rotate_extrude(angle = 180, convexity = 2)
                    {
                        square([a_outer/2,h1+1]);
                    }
                }
            }
        }
    }
    
    echo("hann er ", hann);
    if (hann) {
        union() {
            kropp(hann);
            translate([-2, a_inner/2+2.1, 7.9]) {
                cube([2,1.8,10.1]);
            }
            translate([-2, -(a_inner/2)-4.1, 7.9]) {
                cube([2,1.8,10.1]);
            }
        }
    } else {
        difference() {
            union() {
                kropp(hann);
            }
            union() {
                translate([0, a_inner/2+1.9, 8.1]) {
                    cube([2,2.2,9.9]);
                }
                translate([0, -(a_inner/2)-4.1, 8.1]) {
                    cube([2,2.2,9.9]);
                }
            }
        }
    }
}  

module skrue(skruetype, gjenger) {
    linear_extrude(3) {
        hull() {
            translate([0,25,0]) circle(d=12.5);
            translate([0,0,0]) circle(d=20);
            translate([0,-25,0]) circle(d=12.5);
        }
    }
    translate([0,0,1]) {
        bolt(skruetype, gjenger);
    }
}

tegne_dummy = 0;
tegne_adapter_m = 1;
tegne_adapter_f = 0;
tegne_hode = 0;
tegne_skrue = 0;
stable_adapter_dummy = 0;

adapterskift = (tegne_dummy && !stable_adapter_dummy) ? [50,0,0] : [0,0,0];
skrueskift = (tegne_skrue >= 0 && (tegne_adapter_m || tegne_adapter_m || tegne_dummy)) ? [-50,0,0] : [0,0,0];

if (tegne_dummy) {
    color("lightgreen") {
        spylefaen();
    }
}

if (tegne_hode) {
    translate(adapterskift) {
        color("green") {
            hode();
        }
    }
}

if (tegne_adapter_m) {
    translate(adapterskift) {
        color("pink") {
            adapterdrit(hann=1);
        }
    }
}

if (tegne_adapter_f) {
    translate(adapterskift) {
        color("pink") {
            adapterdrit(hann=0);
        }
    }
}

if (tegne_skrue) {
    translate(skrueskift) {
        color("yellow") {
            skrue(skruetype, 12);
        }
    }
}
