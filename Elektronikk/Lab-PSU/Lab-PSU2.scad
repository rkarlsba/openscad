/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 *
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> some time in 2023 Fixed up and worked further on in August 2025 by the same guy. 
 *
 * Please note that if you have set 3D Rendering backend to CGAL, the rendering
 * of a large box will take a long time, as in possibly hours. Just don't do it.
 * Upgrade to something recent, even though it's not "stable" and change that
 * setting to "Manifold". It'll speed up rendering by an order of magnitude (or
 * three). I'm not kidding.
 *
 */

include <ymse.scad>

// Power supplies from https://www.aliexpress.com/item/1005005553964246.html or
// similar. Measurements are relative to the PSU lying flat, viewed facing the
// contacts.
psu_s_250_12 = [100,165,45];        // S-250-12, 12V, 21A, 252W
psu_s_480_24 = [113,215,51];        // S-480-24, 24V, 20A, 480W

// Settings
fn = 64;
use_bugfix = .1;                    // Not currently in use
bugfix = $preview ? use_bugfix : 0; // Not currently in use
testprint = 0;
takover = 1;

psu = psu_s_480_24;
console = [111,65,57];
max_height = console[2] == psu[2] ? console[2] : console[2] > psu[2] ? console[2] : psu[2];
min_height = console[2] == psu[2] ? console[2] : console[2] < psu[2] ? console[2] : psu[2];
max_width = console[0] == psu[0] ? console[0] : console[0] > psu[0] ? console[0] : psu[0];
min_width = console[0] == psu[0] ? console[0] : console[0] < psu[0] ? console[0] : psu[0];
psu_console_gap = 30;
console_grip = 30;
_console_grip = testprint ? testprint_depth : console_grip;
back_gap = 20;
console_gap = 30;

holesize = (50/10);
x_gap = 1;
console_z_gap = 1;
psu_z_gap = 20;
wall = 3;
x_outer = psu[0]+x_gap*2+wall*2;
z_outer = psu[2]+psu_z_gap*2+wall*2;
x_inner = psu[0]+x_gap*2;
z_inner = psu[2]+psu_z_gap;
testprint_depth = 20;
depth = testprint ? testprint_depth : psu[1]+console[1]+psu_console_gap+back_gap-console_gap;
length = testprint ? 10 : 35;
innerlength = 100;
c14_length = 48;
c14_height = 27.5;
c14_roundings = 3/2;
c14_cuttings = 6;
c14_x = 10+wall;
c14_y = 5+wall;
term_x = 71.2;
term_y = 39.5;
term_clips_h = 14;
// tolerance = .5;
tolerance = .25;

echo(str("psu is ", psu, ", console is ", console, " max_height is ",
    max_height, " and max_width is ", max_width));

module tube(length=length) {
    linear_extrude(length) {
        difference() {
            square([x_outer,z_outer]);
            translate([wall,wall]) {
                square([x_inner,z_inner]);
            }
        }
    }
}

module plate(dim,thickness,holesize) {
    linear_extrude(thickness) {
        difference() {
            square(dim);
            for (x=[holesize*2:holesize*2:dim[0]-holesize*2]) {
                shift = x % (holesize*2);
                for (y=[holesize*2:holesize*2:dim[1]-holesize*2]) {
                    echo(str("X is ", x, ", Y is ", y, " and shift is ", shift));
                    translate([x,y+shift/2]) {
                        circle(d=holesize, $fn=fn);
                    }
                }
            }
        }
    }
}

module outer_frame(x=0, tolerance=tolerance, depth=depth) {
    largest = z_inner > x_inner ? z_inner : x_inner;
    tolerance_num=largest/(largest + tolerance);
    echo(largest, tolerance, tolerance_num);
    
    // Bottom
    color("yellow") {
        plate([max_width+x_gap*2+wall*2,depth], wall, holesize);
    }

    // Left
    translate([0,0+_console_grip,wall]) {
        rotate([90,0,90]) {
            color("red") {
                plate([depth-_console_grip,max_height+psu_z_gap], wall, holesize);
            }
        }
    }
    // Right
    translate([x_inner*tolerance_num+wall,0+_console_grip,wall]) {
        rotate([90,0,90]) {
            color("lightblue") {
                plate([depth-_console_grip,max_height+psu_z_gap], wall, holesize);
            }
        }
    }
    // Top
    translate([0,0,max_height+psu_z_gap+wall]) {
        if (takover) {
            color("pink") {
                plate([max_width+x_gap*2+wall*2,depth], wall, holesize);
            }
        }
    }

    // Grab left
    translate([0,0,wall]) {
        rotate([90,0,90]) {
            color("red") {
                cube([_console_grip,max_height+psu_z_gap, (max_width-min_width)-tolerance+wall]);
            }
        }
    }
    // Grab right
    translate([x_inner*tolerance_num+wall-(max_width-min_width)+tolerance*2,0,wall]) {
        rotate([90,0,90]) {
            color("lightblue") {
                cube([_console_grip,max_height+psu_z_gap, (max_width-min_width)-tolerance+wall]);
                // plate([_console_grip,max_height+psu_z_gap], (max_width-min_width), holesize);
            }
        }
    }
}

module backplate() {
    c14_hole = [
        [0,0], 
        [0, c14_height], 
        [c14_length-c14_cuttings, c14_height],
        [c14_length, c14_height-c14_cuttings],
        [c14_length, c14_cuttings],
        [c14_length-c14_cuttings, 0]
    ];


    color("darkorange") {
        translate([wall,depth,wall]) {
            rotate([90,0,0]) {
                linear_extrude(wall) {
                    difference() {
                        // square([x_inner,z_inner]);
                        square([x_inner,max_height+psu_z_gap]);
                        translate([c14_x,c14_y]) {
                            polygon(c14_hole);
                            translate([-4.5,c14_height/2]) {
                                circle(d=3.5, $fn=fn);
                            }
                            translate([c14_length+4.5,c14_height/2]) {
                                circle(d=3.5, $fn=fn);
                            }
                        }
                    }
                }
            }
        }
    }
}

module draw_psu() {
    if ($preview) {
        color("Lime") {
            cube(psu);
        }
    } else {
        echo("Not preview, so not printing psu");
    }
}

module draw_console() {
    if ($preview) {
        color("beige") {
            cube(console);
        }
    } else {
        echo("Not preview, so not printing psu");
    }
}

//frontplate();
//tube();
//tube();
//translate([wall,60,0])

//psu_front_x_gap = 1;
//psu_front_z_gap = 1;
console_correction = (max_width - console[0])/2;

translate([x_gap+wall,console[1]+psu_console_gap,wall]) {
    draw_psu();
}

translate([x_gap+wall+console_correction,0,wall]) {
    draw_console();
}

translate([0,console_gap,0]) {
    outer_frame();
    backplate();
}

