// vim:ts=4:sw=4:sts=4:et:ai

use <utils/ymse.scad>

jall = $preview ? .5 : 0;
$fn = $preview ? 8: 32 ;

bredde=260;
dybde=95;
hoyde=80;
veggtykkelse=2;
gulvtykkelse=4;
radius=10;
hengebredde=20;
hengelengde=150;

/*
 * Se under
pluggpadding = 5;
pluggbredde = 21;
pluggbredde_i = 14.5;
pluggdybde = 5.4;
pluggdybde_i = 2.8;
*/
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

module boks(feste) {
    difference() {
        union() {
            difference() {
                avrundahulboks(bredde,dybde,hoyde,radius,veggtykkelse,0);
                echo(str("avrundahulboks(bredde=", bredde, ", dybde=", dybde, ", hoyde=", hoyde, ", radius=", radius, ", veggtykkelse=", veggtykkelse, ",0);"));
                if (feste == "spalter") {
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
        translate([16,1,27]) {
            rotate([90,0,0]) {
                linear_extrude(1) {
                    translate([2.6,25,0])
                        text("Sjampo", size=25, font="Courier:style=Regular");
                    translate([10,-19,0])
                        text("Balsam", size=18, font="Impact:style=Regular");
                    rotate([0,0,-22])
                        translate([75,34,0])
                            text("tannkost", size=11, font="Marker Felt:style=Thin");
                    translate([175,26,0])
                        text("såpe", size=16, font="Herculanum:style=Regular");
                    translate([140,0,0])
                        text("iPhone", size=14, font=".Helvetica Neue DeskInterface:style=Bold");
                    translate([215,-25,0])
                        rotate([0,0,35])
                            text("Dildo", size=6, font="Luminari:style=Regular");
                }
            }
        }
    }
}

pluggpadding = 5;
pluggbredde = 21;
pluggbredde_i = 15;
pluggdybde = 5.2;
pluggdybde_i = 3.0;

difference() {
    union() {
        boks();
        translate([bredde/2-pluggbredde/2-pluggpadding,dybde-pluggdybde-pluggpadding,0]) {
            cube([pluggbredde+pluggpadding*2,pluggdybde+pluggpadding,25]);
        }
    }
    translate([bredde/2-pluggbredde/2,dybde-pluggdybde,0]) {
        cube([pluggbredde,pluggdybde_i,25]);
    }
    translate([bredde/2-pluggbredde_i/2,dybde-pluggdybde_i,0]) {
        cube([pluggbredde_i,pluggdybde_i,25]);
    }
}

/*
translate([30,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
translate([bredde-30-hengebredde,0,0])
    henger(hengelengde,hengebredde,veggtykkelse);
*/
