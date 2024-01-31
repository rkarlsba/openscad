/*
$fn=64;

indre_d = 50;
ytre_d_bunn = 67;
ytre_d_topp = 100;
hoyde = 123;
tykkelse = 3;

translate([indre_d/2, 0]) {
    square([indre_d/4, tykkelse]); 
    translate([indre_d/4, 0]) {
        square([tykkelse, hoyde]);
   }
}

*/
/*
$fa = 1; $fs = 0.2;
 
function f(x) = (x/4) * (x/4);
 
rotate_extrude() {
    translate([20, 0]) square([10, 2]);
 
    translate([30, 1]) for (x = [0 : 38]) {
        hull() {
            translate([x, f(x)]) circle(1);
            translate([x + 1, f(x + 1)]) circle(1);
        }
    }
}

*/

$fa = 1; $fs = 0.2;
 
function f(x) = pow(x/3.85,2);
 
rotate_extrude() {
    translate([20, 0]) {
        square([10, 2]);
    }
 
    translate([25, 1]) {
        for (x = [0 : 48]) {
            hull() {
                translate([x, f(x)]) {
                    circle(1);
                }
                translate([x + 1, f(x + 1)]) {
                    circle(1);
                }
            }
        }
    }
}