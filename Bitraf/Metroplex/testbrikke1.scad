use <ymse.scad>
use <threadlib/threadlib.scad>

$fn = 64;
corners = 2.5;
hole_size = 3.5;
hole_dist = 21.75;
border = 7;
base_x = border*2+hole_dist*2;
base_y = border*2+hole_size;
base_z = 7;
oblong_holes = 0;
m3mutter_d = 6.8; // f
//m3mutter_d = 6.5; // g
m3mutter_h = 2.5;

difference() {
    linear_extrude(base_z) {
        translate([-hole_dist-border,0]) {
            roundedsquare([base_x,base_y], corners);
        }
    }
    for (x=[-hole_dist,hole_dist]) {
        echo(str("x is ", x));
        if (oblong_holes) {
            hull() {
                translate([x*1.05,base_y/2]) {
                    cylinder(d=hole_size, h=base_z);
                    cylinder(d=m3mutter_d, h=m3mutter_h, $fn=6);
                }
                translate([x*.95,base_y/2]) {
                    cylinder(d=hole_size, h=base_z);
                    cylinder(d=m3mutter_d, h=m3mutter_h, $fn=6);
                }
            }
        } else {
            translate([x,base_y/2]) {
                cylinder(d=hole_size, h=base_z);
                cylinder(d=m3mutter_d, h=m3mutter_h, $fn=6);
            }                
        }
    }
    translate([0, base_y/2]) {
        cylinder(d=m3mutter_d, h=base_z, $fn=6);
    }
}
