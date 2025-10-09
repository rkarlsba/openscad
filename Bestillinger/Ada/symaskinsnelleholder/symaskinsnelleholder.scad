/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 *
 * Dings til å henge bakå ei symaskin og så sette fra seg sytrådsneller på.
 *
 * Se README.md for detaljer og LICENSE.txt for lisens.
 */

$fn = 128;

tol = .25; // Tolerance

x = 70;
y1 = 5;
y2 = 26;
x1 = 11;
r1 = 8;
r2 = (4.6+tol)/2;
echo(str("tol = ", tol, " and r2 = ", r2, ", so d2 is ", r2*2));

linear_extrude(2) {
    difference() {
        hull() {
            square([x,y1]);
            translate([x1,y1+y2]) {
                circle(r=r1);
            }
            translate([x-x1,y1+y2]) {
                circle(r=r1);
            }
        }
        translate([x1,y1+y2]) {
            circle(r=r2);
        }
        translate([x-x1,y1+y2]) {
            circle(r=r2);
        }
    }
}
