$fn = $preview ? 16 : 96;

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

knott_ytre_d = d2;
knott_t = 6;
knott_b = 11;

a_inner=d1+3;
a_inner2=a_inner+3;
a_outer=a_inner+10;
a_outer2=a_outer+3;

storesfaere = 51;
lillesfaere = d4;

// Disse var M10 og 12
skruetype = "M12";
skruehull = 14;


module cf(height = 1, scale = 1) {
    linear_extrude(height, scale = scale, center = true) {
        children();
    }
}

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
    }
}

module hode() {
    storesfaere = 53;
    lillesfaere = 39;
    kant=4;
    lift=4;

    translate([0,0,lift+kant]) {
        difference() {
            union() {
                sphere(d=storesfaere);
            }
            union() {
                sphere(d=lillesfaere);
                translate([0,0,18]) {
                    cylinder(d=skruehull, h=12);
                }
                translate([-storesfaere/2,-storesfaere/2,-storesfaere]) {
                    cube([storesfaere,storesfaere,storesfaere]);
                }
            }
        }
        translate([0,0,18]) {
            nut(skruetype, turns=4, Douter=skruehull+2);
        }
    }
    translate([0,0,lift]) {
        difference() {
            cylinder(d=storesfaere-kant, h=kant);
            cylinder(d=lillesfaere, h=kant);
        }
    }

    difference() {
        cylinder(d=storesfaere, h=lift);
        cylinder(d=lillesfaere, h=lift);
    }
}

module kropp() {
    r1=25;
    r2=27.25;
    r3=18.5;
    h1=2.5;
    h2=36;
    h3=5;
    sb=7; // stripsbredde
    
    /*
    module feste() {
        union() {
            cube([
    }
    */

    profil = [
        [0,0],              // 0
        [r1,0],             // 1
        [r1,h1],            // 2
        [r2,h1+.8],         // 3
        [r2,h1+h2-2],       // 4
        [r3,h1+h2+2],         // 5
        [r3,h1+h2+h3],      // 6
        [0,h1+h2+h3]        // 7
    ];

    difference() {
        cylinder(r=30,h=h1+h2+h3);
        rotate_extrude($fn=180, angle=360, convexity = 2)
            polygon(profil);
        translate([-50,0,0]) {
            cube([100,50,50]);
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

module cbue(rounded=1, width=8, bowangle=270, diff=0) {
    translate([0, 0, rounded]) {
        rotate_extrude($fn=100, convexity = 2, angle=bowangle) {
            translate([56/2+rounded+diff, 0, rounded*20]) {
                if (rounded) {
                    minkowski() {
                        square([1,width-2+diff]);
                        circle(r=1);
                    }
                } else {
                    square([3,width+diff]);
                }
            }
        }
    }
}

tegne_cbue = 0;
tegne_dummy = 0;
tegne_kropp = 0;
tegne_hode = 0;
tegne_skrue = 1;
stable_adapter_dummy = 0;

adapterskift = (tegne_dummy && !stable_adapter_dummy) ? [50,0,0] : [0,0,0];
skrueskift = (tegne_skrue >= 0 && (tegne_kropp || tegne_dummy)) ? [-50,0,0] : [0,0,0];

if (tegne_dummy) {
    color("lightgreen") {
        spylefaen();
    }
}

if (tegne_hode) {
    translate([-50,0,0]) {
        color("green") {
            hode();
        }
    }
}

if (tegne_kropp) {
    color("pink") {
        difference() {
            kropp();
            translate([0,0,h1*.65]) {
                cbue(bowangle=360, diff=1);
            }
        }
        /*
        cube([10,8,2]);
        difference(){
            translate([0,0,2])rotate([0,10,0])cube([5,8,2]);
            translate([0,-1,2])rotate([0,-5,0])cube([8,10,2]);
        }*/
    }
}

if (tegne_skrue) {
    color("yellow") {
        skrue(skruetype, 20);
    }
}

if (tegne_cbue) {
    cbue(rounded=1, diff=0);
}