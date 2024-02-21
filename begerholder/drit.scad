// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker

// Boksholder til krykke

// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2024
use <torus.scad>

$fn = $preview ? 32 : 128;

idiot = $preview ? .5 : 0;
std_can_d = 66;
std_can_bottom_d = 50;
bottom_taper_h = 8;
500ml_can_h = 168;
330ml_can_h = 116;
wall = 2;
bottom = 4;
gap = 2;
test = false;

can_extrude = 20;
can_h = test ? 40 : 330ml_can_h-can_extrude;
can_d = std_can_d + gap*2;
can_outer_d = can_d+wall*2;

crutch_d = 20;
handle_height = can_h;
handle_width=crutch_d*sqrt(2);
handle_depth=crutch_d*1.2;

cable_tie_height=10;
cable_tie_width=5;
cable_ties=3;

/*
 * module can() - draw can
 *
 * This takes the following arguments:
 *   h      Can height
 *   d      Can diameter
 *   w      Wall
 *   bd     Can bottom diameter
 *   bth    Bottom taper height
 *   b      Bottom height
 *   hh     Handle height (Z)
 *   hw     Handle width (Y)
 *   hd     Handle depth (X)
 *   cd     Crutch diameter
 *   cth    Cable tie height
 *   ctw    Cable tie width
 *   ct     Cable ties
 */
 module can(h=can_h, d=can_d, w=wall, bd=std_can_bottom_d, bth=bottom_taper_h, 
    b=bottom, hh=handle_height, hw=handle_width, hd=handle_depth, cd=crutch_d,
    cth=cable_tie_height, ctw=cable_tie_width, ct=cable_ties) {

    od=d+w*2;
    
    module handle(h=h, d=od, hh=hh, hw=hw, cd=cd, cth=cth, ctw=ctw, ct=ct) {
        difference() 
        {
            translate([-d/2-hw+3,-hd/2,h/2-hh/2]) {
                cube([hw,hd,hh]);
            }
            translate([-d/2-hw+3,-hw,h/2-hh/2-idiot]) {
                cylinder(h=hh+idiot*2, d=cd);
                /*
                for (i = [1:ct]) {
                    translate([cd,-hd/2-idiot,(hh/(ct+2))*i+1]) {
                        cube([ctw,cd,cth]);
                    }
                }
                */
            }
        }
    }

    cylinder(d=od,h=b);
    translate([0,0,b]) {
        difference() {
            union() {
                cylinder(d=od, h=h-b);
                translate([0,0,h-b]) {
                    torus(r1=w/2, r2=d/2+w/2);
                }
                translate([0,0,-b]) {
                    handle();
                }
            }
            union() {
                cylinder(d1=bd, d2=d, h=bth+idiot);
                translate([0,0,bth]) {
                    cylinder(d=d, h=h-bth-b+idiot);
                }
            }
        }
    }
}

if (test) {
    difference() {
        can(h=40);
        union() {
            translate([-(can_d/2+wall),0,0]) {
                cube([can_d+wall*2,can_d/2+wall,can_h+wall/2]);
            }
            rotate([0,0,90]) {
                translate([-(can_d/2+wall),0,0]) {
                    //cube([400,200,40]);
                    cube([can_d+wall*2,can_d/2+wall,can_h+wall/2]);
                }
            }
        }
    }
} else {
    can();
}

