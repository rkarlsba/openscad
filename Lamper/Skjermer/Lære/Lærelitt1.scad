// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

$fa = 1;
$fs = 0.2;
 
// function f(x) = (x/6) * (x/6);
// function f(x) = (x/6)^2.1;
// function f2(x) = x < 40 ? (x/6)^2.1 : ((80 - x)/6)^2.1;
// function f3(x) = sin(x * 180 / 80); // gir en bølge fra 0 til 180 grader
//function f4(x) = -((x - 40)/6)^2 + 45; // topp ved x=40, høyde 45
// function f4(x) = -((x - 40)/6)^2 + 45; // topp ved x=40, høyde 45
function f(x) = x < 40 ? (x/6)^2.1 : ((80 - x)/6)^2.1;
 
// rotate_extrude()
{
    // Sokkelplate
    translate([30, 0]) {
        square([21, 3]);
    }
    translate([30, 2]) {
        square([26, 1]);
    }
    translate([30, 3]) {
        square([29, 1]);
    }
 
    // Skjerm
    translate([50, 1]) {
        for (x = [0 : 80]) {
            x2 = x*.8;
            rotate(270) mirror([1,0,0])
            hull() {
                translate([x2, f(x)]) {
                    circle(1);
                }
                translate([x2 + 1, f(x + 1)]) {
                    circle(1);
                }
            }
        }
    }
}
