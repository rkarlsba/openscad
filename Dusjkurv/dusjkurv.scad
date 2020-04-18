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

difference() {
    union() {
        difference() {
            avrundahulboks(bredde,dybde,hoyde,radius,veggtykkelse,0);
            echo(str("avrundahulboks(bredde=", bredde, ", dybde=", dybde, ", hoyde=", hoyde, ", radius=", radius, ", veggtykkelse=", veggtykkelse, ",0);"));
            /* oppe */
            echo(str("translate([", 40, ", ", dybde-veggtykkelse-.1, ", ", hoyde-hoyde/8*3, "])"));
            translate([40,dybde-veggtykkelse-.1,hoyde-hoyde/8*3])
                cube([4,veggtykkelse+.1,hoyde/4]);
            translate([bredde-40-veggtykkelse,dybde-veggtykkelse-.1,hoyde-hoyde/8*3])
                cube([4,veggtykkelse+.1,hoyde/4]);
            translate([(bredde+veggtykkelse)/2,dybde-veggtykkelse-.1,hoyde-hoyde/8*3])
                cube([4,veggtykkelse+.1,hoyde/4]);
            /* nede */
            translate([40,dybde-veggtykkelse-.1,hoyde*.2])
                cube([4,veggtykkelse+.1,hoyde/4]);
            translate([bredde-40-veggtykkelse,dybde-veggtykkelse-.1,hoyde*.2])
                cube([4,veggtykkelse+.1,hoyde/4]);
            translate([(bredde+veggtykkelse)/2,dybde-veggtykkelse-.1,hoyde*.2])
                cube([4,veggtykkelse+.1,hoyde/4]);
        }
        intersection() {
            avrundaboks(bredde,dybde,hoyde,radius);
            translate([veggtykkelse,veggtykkelse,0]) {
                linear_extrude(gulvtykkelse) {
                    honeycomb(bredde-veggtykkelse*2, dybde-veggtykkelse*2, 12, 2);
                }
            }
        }
    }
    translate([11,1,20]) {
        rotate([90,0,0]) {
            linear_extrude(1) {
                translate([0,3,0])
                    text("Sjampo", size=14, font="Courier:style=Regular");
                translate([47,-16,0])
                    text("Balsam", size=11, font="Impact:style=Regular");
                translate([185,3,0])
                    text("såpe", size=10, font="Herculanum:style=Regular");
                translate([109,-6,0])
                    text("iPhone", size=15, font=".Helvetica Neue DeskInterface:style=Bold");
                translate([216,-16,0])
                    rotate([0,0,40])
                        text("Dildo", size=5, font="Luminari:style=Regular");
            }
        }
    }
}
/*
translate([30,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
translate([bredde-30-hengebredde,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
*/
