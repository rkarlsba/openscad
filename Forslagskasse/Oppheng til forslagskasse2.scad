use <ymse.scad>

$fn = $preview ? 16 : 64;

ned_til_skruer = 20;
skrue_til_topp = 72;
skruehull = 5.5;
box_h = 210;
box_b = 160;
box_d = 5;
box_bunn_b = 164;
box_bunn_d = 84;
box_mellom_skruer = 44;
box_resten = 160 - box_mellom_skruer;
box_skrue = box_resten / 2;
hylletykkelse = 5;
kant_h = 3;
kant_b = 12;
kant_d = 12;

/*
 * Moduler
 */
module brett() {
    difference() {
        roundedcube([box_bunn_b+kant_b*2,box_bunn_d+kant_d*2,hylletykkelse+kant_h], 4);
        translate([kant_b,kant_d,kant_h]) {
            cube([box_bunn_b,box_bunn_d,hylletykkelse]);
        }
    }
}

module oppheng(b=120, t=5) {
    translate([b/2*sqrt(2)+kant_b,0,b/2*sqrt(2)+(hylletykkelse+kant_h)/2]) {
        rotate([0,135,0]) {
            difference() {
                union() {
                    roundedcube([20,t,b],1);
                    roundedcube([b,t,20],1);
                }
                translate([0,0,b]) {
                    rotate([0,45,0]) {
                        roundedcube([b*sqrt(2),t,20],1);
                    }
                }
                translate([42.5,0,10]) {
                    rotate([270,0,0]) {
                        cylinder(d=skruehull, h=t);
                    }
                }
                translate([10,0,42.5]) {
                    rotate([270,0,0]) {
                        cylinder(d=skruehull, h=t);
                    }
                }
            }

        }
    }
}

/* main.c */
brett();
oppheng();
