/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 *
 * Dings til å henge bakå ei symaskin og så sette fra seg sytrådsneller på.
 *
 * Se README.md for detaljer og LICENSE.txt for lisens.
 */

$fn = 128;

bugfix = $preview ? .2 : 0;

tol = .25; // Tolerance

x = 70;
y1 = 5;
y2 = 26;
x1 = 13;
r1 = 10;
r2 = (4.6+tol)/2;
thickness = 2.5;
slotthickness = 0.5;
pinne1 = 2.4;
pinne2 = 2.0;
echo(str("tol = ", tol, " and r2 = ", r2, ", so d2 is ", r2*2));

difference() {
    hull() {
        cube([x,y1,thickness]);
        translate([x1,y1+y2]) {
            cylinder(r=r1, h=thickness);
        }
        translate([x-x1,y1+y2]) {
            cylinder(r=r1, h=thickness);
        }
    }
    translate([x1,y1+y2,-bugfix]) {
        cylinder(r=r2, h=thickness+bugfix*2);
    }
    translate([x-x1,y1+y2,-bugfix]) {
        cylinder(r=r2, h=thickness+bugfix*2);
        translate([0, 0, slotthickness]) {
            cylinder(r=r1, slotthickness);
        }
    }
}

color("red")
translate([x-x1,y1+y2,-bugfix]) {
    translate([0, 0, slotthickness]) {
        cylinder(r=r1, slotthickness);
    }
}


translate([r1,-10]) {
    cylinder(r=r1, thickness);
    cylinder(r1=pinne1,r2=pinne2,h=40);
}

translate([r1*3.2,-10]) {
    difference() {
        cylinder(r=r1, thickness);
        translate([0,0,-bugfix]) {
            cylinder(r=r2, h=thickness+bugfix*2);
        }
    }
}

translate([r1*5.4,-10]) {
    difference() {
        cylinder(r=r1, thickness);
        translate([0,0,-bugfix]) {
            cylinder(r=r2, h=thickness+bugfix*2);
        }
    }
}

translate([r1*7.6,-10]) {
    cylinder(r=r1, thickness);
    cylinder(r1=pinne1,r2=pinne2,h=40);
}

