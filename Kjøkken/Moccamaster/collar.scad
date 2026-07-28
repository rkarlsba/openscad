// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

import("Collar-centered.stl");

d=8;
height=2.5;

intersection() 

render() {
    difference() { 
        difference() {
            cylinder(d=141.6, h=17);
            cylinder(d=138.6, h=17);
        }
        union() {
            translate([0,32,0]) cylinder(d=d, h=height);
            translate([22,26,0]) cylinder(d=d, h=height);
            translate([-22,26,0]) cylinder(d=d, h=height);
            translate([23,-20,0]) cylinder(d=d, h=height);
            translate([-23,-20,0]) cylinder(d=d, h=height);
            translate([23,-60,0]) cylinder(d=d, h=height);
            translate([-23,-60,0]) cylinder(d=d, h=height);
        }
    }
}
