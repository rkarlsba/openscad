// Triangle key
// All numbers are supposed to be millimeters

height = 25;
diameter = 14;
depth = 11;
tri_round = 1.5;
tri_side = 9.7;
handle_arm = 14;
handle_height = 5;
scale_=(1/9)*9.1;

tri_height = tri_side * sqrt(3) / 2;
tri_apothem = tri_height / 3;

handle_round = handle_height;
hh = handle_height / 2;

scale([scale_,scale_,scale_]) {
    union() {

        difference() {
            cylinder(h=height, d=diameter, center=false, $fn=100);
            
            translate([0,-(tri_apothem - tri_round / 4),height - depth]) {
                hull() {
                    translate([(tri_side - tri_round / 2) / 2,0,0]) {
                        cylinder(h=depth + 1, d=tri_round, center=false, $fn=100);
                    }
                    translate([-(tri_side - tri_round / 2) / 2,0,0]) {
                        cylinder(h=depth + 1, d=tri_round, center=false, $fn=100);
                    }
                    translate([0,(tri_height - tri_round / 2),0]) {
                        cylinder(h=depth + 1, d=tri_round, center=false, $fn=100);
                    }
                }
            }
        }
        
        hull() {
            translate([handle_arm,0,0]) {
                cylinder(h=hh, d=handle_round, center=false, $fn=100);
            }
            translate([-handle_arm,0,0]) {
                cylinder(h=hh, d=handle_round, center=false, $fn=100);
            }
        }

        translate([0,0,hh]) hull() {
            translate([handle_arm,0,0]) {
                sphere(d=handle_round, $fn=100);
            }
            translate([-handle_arm,0,0]) {
                sphere(d=handle_round, $fn=100);
            }
        }
        
        hull() {
            translate([0,handle_arm,0]) {
                cylinder(h=hh, d=handle_round, center=false, $fn=100);
            }
            translate([0,-handle_arm,0]) {
                cylinder(h=hh, d=handle_round, center=false, $fn=100);
            }
        }

        translate([0,0,hh]) hull() {
            translate([0,handle_arm,0]) {
                sphere(d=handle_round, $fn=100);
            }
            translate([0,-handle_arm,0]) {
                sphere(d=handle_round, $fn=100);
            }
        }
    }
}



echo(version=version());

// Created by Alexey Kondratov <kondratov.aleksey@gmail.com>
