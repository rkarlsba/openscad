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
include <catchnhole/catchnhole.scad>

// Power supplies from https://www.aliexpress.com/item/1005005553964246.html or
// similar. Measurements are relative to the PSU lying flat, viewed facing the
// contacts.
psu_s_250_12 = [100,165,45];        // S-250-12, 12V, 21A, 252W
psu_s_480_24 = [113,215,51];        // S-480-24, 24V, 20A, 480W

// Settings - booleans are set to true/false or 1/0, same thing.
fn = 64;
use_bugfix = .1;                    // Not currently in use
bugfix = $preview ? use_bugfix : 0; // Not currently in use
testprint = 0;
takover = 1;

// The onlys
onlyblock = 0;
onlyback = 1;

psu = psu_s_480_24;
console = [111,65,57];
block = [111,30,19.5];
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
screwholesize = 3.9;
screwlength = 16;
block_nut_depth = 10;
nut_height = 3;
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

c14_model = 1; // Either 0 or 1
c14_length = [48,40];
c14_height = [27.5,28.5];
c14_roundings = [3/2,3/2];
c14_cuttings = [6,6];
c14_x = [10+wall,10+wall];
c14_y = [5+wall,5+wall];
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
                    // echo(str("X is ", x, ", Y is ", y, " and shift is ", shift));
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

module backplate(test=false, holes=true, c14_model = c14_model) {
    c14_hole = [
        [0,0], 
        [0, c14_height[c14_model]], 
        [c14_length[c14_model]-c14_cuttings[c14_model], c14_height[c14_model]],
        [c14_length[c14_model], c14_height[c14_model]-c14_cuttings[c14_model]],
        [c14_length[c14_model], c14_cuttings[c14_model]],
        [c14_length[c14_model]-c14_cuttings[c14_model], 0]
    ];


    _wall = test ? 0 : wall;
    _depth = test ? 0 : depth;
    _max_height = test ? max_height/2 : max_height;
    _x_inner = test ? x_inner * .6 : x_inner;
    _rotate = test ? [0,0,0] : [90,0,0];

    color("darkorange") {
        translate([_wall,_depth,_wall]) {
            rotate(_rotate) {
                linear_extrude(wall) {
                    difference() {
                        // square([x_inner,z_inner]);
                        square([_x_inner,_max_height+psu_z_gap]);
                        translate([c14_x[c14_model],c14_y[c14_model]]) {
                            polygon(c14_hole);
                            if (holes) {
                                translate([-4.5,c14_height[c14_model]/2]) {
                                    circle(d=3.5, $fn=fn);
                                }
                                translate([c14_length[c14_model]+4.5,c14_height[c14_model]/2]) {
                                    circle(d=3.5, $fn=fn);
                                }
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

module draw_block(ignorepreview = false, uptonut = false) {
    block_height = uptonut ? block_nut_depth : block[2];
    if (ignorepreview) {
        color("greenyellow") {
            rotate([0,0,90])
            difference() {
                cube([block[1],block[0],block_height]);
                translate([holesize*4,holesize*11,block[2]-screwlength]) {
                    cylinder(d=screwholesize, h=screwlength+bugfix, $fn=fn);
                    translate([0,0,4]) {
                        nutcatch_sidecut("M4", height_clearance = tolerance, width_clearance = tolerance);
                    }
                }
            }
        }
    } else if ($preview) {
        color("darkgoldenrod") {
            difference() {
                cube(block);
                echo(str("translate([", block[0]/2, ", ", block[1]/2, ", ", block[2]-screwlength, "]"));
                translate([block[0]/2,holesize*4,block[2]-screwlength]) {
                    cylinder(d=holesize, h=screwlength+bugfix, $fn=fn);
                }
            }
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

if (onlyblock) {
    draw_block(ignorepreview = true, uptonut = false);
} else if (onlyback) {
    backplate(test=true, holes=false, c14_model);
} else {
    translate([x_gap+wall,console[1]+psu_console_gap,wall]) {
        draw_psu();
    }

    translate([x_gap+wall+console_correction,0,wall]) {
        draw_console();
    }

    translate([x_gap+wall+console_correction,console_grip,wall+console[2]]) {
        draw_block();
    }

    translate([0,console_gap,0]) {
        outer_frame();
        backplate();
    }
}
