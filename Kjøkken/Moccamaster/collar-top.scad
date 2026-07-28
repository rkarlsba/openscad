// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

import("Collar-top-centered.stl");

$fn = 200;
d = 4;
height = $preview ? 2.5 : 2;

intersection() 

render() {
    difference() { 
        union() {
            translate([-43,22.5,0]) cylinder(d=d, h=height);
            translate([0,22.5,0]) cylinder(d=d, h=height);
            translate([43,22.5,0]) cylinder(d=d, h=height);
            translate([47.7,0,0]) cylinder(d=d, h=height);
            translate([-43,-22.5,0]) cylinder(d=d, h=height);
            translate([0,-22.5,0]) cylinder(d=d, h=height);
            translate([43,-22.5,0]) cylinder(d=d, h=height);
        }
    }
}
