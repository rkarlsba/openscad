// vim:ts=4:sw=4:sts=4:et:ai

use <utils/ymse.scad>

bredde=250;
dybde=80;
hoyde=40;
veggtykkelse=2;
gulvtykkelse=4;
radius=10;
hengebredde=20;
hengelengde=150;

module henger(lengde,bredde,tykkelse) {
    difference() {
        union() {
            cube([bredde,tykkelse,lengde-bredde/2]);
            translate([bredde/2,0,lengde-bredde/2])
                rotate([270,0,0])
                    cylinder(d=bredde,h=tykkelse);
        }
        translate([bredde/2,0,lengde-bredde/2]) {
            rotate([270,0,0]) {
                hull() {
                    cylinder(d=bredde*.65,h=tykkelse);
                    translate([0,10,0])
                        cylinder(d=bredde*.3,h=tykkelse);
                }
            }
        }
    }
}
/*
avrundahulboks(bredde,dybde,hoyde,radius,veggtykkelse,0);
intersection() {
    avrundaboks(bredde,dybde,hoyde,radius);
    translate([veggtykkelse,veggtykkelse,0]) {
        linear_extrude(gulvtykkelse) {
            honeycomb(bredde-veggtykkelse*2, dybde-veggtykkelse*2, 12, 2);
        }
    }
}

translate([bredde/8,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
translate([bredde-bredde/8-hengebredde,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
*/
henger(40,hengebredde,veggtykkelse);