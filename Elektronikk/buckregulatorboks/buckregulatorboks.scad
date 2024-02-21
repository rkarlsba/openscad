/*
 * Friction-fit Chassis for LM2596-based buck converter
 *
 * Designed and written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2024
 * Licensed under CC BY NC 4.0 https://creativecommons.org/licenses/by/4.0/
 */

debug = true;
idiot = $preview ? .5 : 0;
fn = $preview ? 12 : 31;

board_x = 43.5;
board_y = 21;
ol_height = 3; // overlapp
b_height = 9;
t_height = 16-b_height; // bare skruen stikker ut
walls = 3;
gap = 1;
bottom = 3;
top = 2;
hole_r = 1.5;
lh_width = 4; // lead hole
lh_height = 5.5; // lead hole
tolerance_x = .05;
tolerance_z = .4;
pot_x = 9.5;
pot_y = 5.1;
pot_z = 1.5;
b_wedge = 1.15;
t_wedge = .01;
w_wedge = 2;

module bottom() {
    difference() {
        cube([board_x+walls*2+gap*2,board_y+walls*2+gap*2,b_height+bottom]);
        translate([walls,walls,bottom]) {
            cube([board_x+gap*2,board_y+gap*2,b_height+idiot]);
        }
        translate([0,0,bottom+b_height-ol_height]) {
            difference() {
                cube([board_x+walls*2+gap*2,board_y+walls*2+gap*2,ol_height]);
                translate([walls/2,walls/2,0]) {
                    cube([board_x+walls+gap*2,board_y+walls+gap*2,ol_height]);
                }
            }
        }
        translate([0,walls+gap,bottom-1]) {
            cube([walls+5,lh_width,lh_height+1]);
        }
        translate([0,walls+board_y-lh_width+gap,bottom-1]) {
            cube([walls+5,lh_width,lh_height+1]);
        }
        translate([walls+board_x+gap*2-5,walls+gap,bottom-1]) {
            cube([walls+5,lh_width,lh_height+1]);
        }
        translate([walls+board_x+gap*2-5,walls+board_y-lh_width+gap,bottom-1]) {
            cube([walls+5,lh_width,lh_height+1]);
        }
        translate([walls+gap+23.8,walls+board_y+gap-pot_y,bottom-pot_z]) {
            cube([pot_x,pot_y,pot_z]);
        }
    }
    translate([walls+board_x*.15,walls,bottom]) {
        hull() {
            cube([w_wedge,b_wedge,t_wedge]);
            translate([0,0,b_height]) {
                cube([w_wedge,t_wedge,t_wedge]);
            }
        }
    }
    translate([walls+board_x*.85-1,walls,bottom]) {
        hull() {
            cube([w_wedge,b_wedge,t_wedge]);
            translate([0,0,b_height]) {
                cube([w_wedge,t_wedge,t_wedge]);
            }
        }
    }
    translate([walls+board_x*.15,board_y+walls+gap*2-b_wedge,bottom]) {
        hull() {
            cube([w_wedge,b_wedge,t_wedge]);
            translate([0,b_wedge,b_height]) {
                cube([w_wedge,t_wedge,t_wedge]);
            }
        }
    }
    translate([walls+board_x*.85-1,board_y+walls+gap*2-b_wedge,bottom]) {
        hull() {
            cube([w_wedge,b_wedge,t_wedge]);
            translate([0,b_wedge,b_height]) {
                cube([w_wedge,t_wedge,t_wedge]);
            }
        }
    }
    translate([walls,board_y/2+walls-w_wedge/2,bottom]) {
        hull() {
            cube([b_wedge,w_wedge,t_wedge]);
            translate([0,b_wedge,b_height]) {
                cube([t_wedge,w_wedge,t_wedge]);
            }
        }
    }
    translate([walls+board_x+gap*2-b_wedge,board_y/2+walls-w_wedge/2,bottom]) {
        hull() {
            cube([b_wedge,w_wedge,t_wedge]);
            translate([b_wedge,0,b_height]) {
                cube([t_wedge,w_wedge,t_wedge]);
            }
        }
    }
}

module top() {
    difference() {
        cube([board_x+walls*2+gap*2,board_y+walls*2+gap*2,t_height+top]);
        translate([walls,walls,top]) {
            cube([board_x+gap*2,board_y+gap*2,t_height+idiot]);
        }
        translate([walls/2-tolerance_x/2,walls/2-tolerance_x/2,top+t_height-ol_height-tolerance_z]) {
            cube([board_x+walls+gap*2-tolerance_x,board_y+walls+gap*2-tolerance_x,ol_height+tolerance_z]);
        }
        translate([walls+gap+18,walls+board_y+gap-(pot_y-3.5),0]) {
            cylinder(d1=3.4, d2=4.6, h=top+idiot, $fn=fn);
        }
        for (x=[walls*2-.2:3.1:board_x+walls]) {
            translate([x,walls*2,0]) {
                hull() {
                    corr = (x > 20 && x < 26) ? -pot_y/2-.5 : 0;
                    cylinder(h=top, r=.7, $fn=fn);
                    translate([0,17+corr,0]) {
                        cylinder(h=top, r=.7, $fn=fn);
                    }
                }
            }
        }
    }
}

/* Draw them */
//bottom();
top();
/*
translate([0,-32,0]) {
    top();
}
*/
