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
// include <catchnhole/catchnhole.scad>
// include <nuts_and_bolts_v1.95.scad>
// include <threads_2.5.scad>
include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;

// Power supplies from https://www.aliexpress.com/item/1005005553964246.html or
// similar. Measurements are relative to the PSU lying flat, viewed facing the
// contacts.
psu_s_250_12 = [100,165,45];        // S-250-12, 12V, 21A, 252W
psu_s_480_24 = [113,215,51];        // S-480-24, 24V, 20A, 480W

// Settings - booleans are set to true/false or 1/0, same thing.
fn = 128;
$fn = fn;
use_bugfix = .1;                    // Not currently in use
bugfix = $preview ? use_bugfix : 0; // Not currently in use
testprint = 0;
takover = 1;
debug = false;

// The onlys
onlyblock = 1;
onlyback = 0;

// Blocktype is either 0 or 1
blocktype = 1;
nutcatch_depth = [0,12];
psu = psu_s_480_24;
console = [111,65,57];
block = [[111,30,19.5],[111,20,19.5]];
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
c14screwholesize = [3.5,4.5];
c14screwholepos = [0,5.2];
c14nutscale = [1.03,1.03,1.03];
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
c14_height = [27.5,30.0];
c14_roundings = [3/2,3/2];
c14_cuttings = [6,6];
c14_x = [10+wall,10+wall];
c14_y = [7+wall,14+wall];
term_x = 71.2;
term_y = 39.5;
term_clips_h = 14;
// tolerance = .5;
tolerance = .25;

debprint(str("psu is ", psu, ", console is ", console, " max_height is ",
    max_height, " and max_width is ", max_width));

module debprint(s) {
    if (debug) {
        echo(s);
    }
}

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

module plate(dim,thickness,holesize,type) {
    debprint(str("plate(", dim, ", ", thickness, ", ", holesize, ", ", type, ")"));
    linear_extrude(thickness) {
        difference() {
            square(dim);
            for (x=[holesize*2:holesize*2:dim[0]-holesize*2]) {
                shift = x % (holesize*2);
                y_le = (type == "top" || type == "bottom") ? 130 : 100;
                y_ge = (type == "top" || type == "bottom") ? 170 : 140;
                for (y=[holesize*2:holesize*2:dim[1]-holesize*2]) {
                    if (y <= y_le || y >= y_ge) {
                        // echo(str(type, dim, " X is ", x, ", Y is ", y, " and shift is ", shift, ". Punching!"));
                        translate([x,y+shift/2]) {
                            circle(d=holesize, $fn=fn);
                        }
                    } else {
                        // echo(str(type, dim, " X is ", x, ", Y is ", y, " and shift is ", shift, ". Ignoring!"));
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
        plate([max_width+x_gap*2+wall*2,depth], wall, holesize, "bottom");
    }

    // Left
    translate([wall,0+_console_grip,wall]) {
        rotate([0,270,0]) {
            color("red") {
                plate([max_height+psu_z_gap,depth-_console_grip], wall, holesize, "left");
            }
        }
    }
    // Right
    translate([x_inner*tolerance_num+wall*2,0+_console_grip,wall]) {
        rotate([0,270,0]) {
            color("lightblue") {
                plate([max_height+psu_z_gap,depth-_console_grip], wall, holesize, "right");
            }
        }
    }
    // Top
    translate([0,0,max_height+psu_z_gap+wall]) {
        if (takover) {
            color("pink") {
                plate([max_width+x_gap*2+wall*2,depth], wall, holesize, "top");
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
    // _max_height = test ? max_height : max_height;
    // _x_inner = test ? x_inner : x_inner;
    _max_height_factor = (c14_model == 0 ) ? .5 : .8;
    _max_height = test ? max_height * _max_height_factor : max_height;
    _x_inner = test ? x_inner * .6 : x_inner;
    _rotate = test ? [0,0,0] : [90,0,0];

    difference() {
        color("darkorange") {
            translate([_wall,_depth,_wall]) {
                rotate(_rotate) {
                    linear_extrude(wall) {
                        difference() {
                            // square([x_inner,z_inner]);
                            square([_x_inner,_max_height+psu_z_gap]);

                            // Skruehøl
                            if (c14_model == 1) {
                                translate([c14_x[c14_model]+c14_length[c14_model]/2,c14_y[c14_model]-c14screwholepos[c14_model]]) {
                                    circle(d=c14screwholesize[c14_model], $fn=127);
                                }
                                translate([c14_x[c14_model]+c14_length[c14_model]/2,c14_height[c14_model]+c14_y[c14_model]+c14screwholepos[c14_model]]) {
                                    circle(d=c14screwholesize[c14_model], $fn=127);
                                }
                            }

                            // c14-høl
                            translate([c14_x[c14_model],c14_y[c14_model]]) {
                                polygon(c14_hole);
                            }
                        }
                    }
                }
            }
        }
        translate([_wall+c14_x[c14_model]+c14_length[c14_model]/2,_depth+c14_height[c14_model]+c14_y[c14_model]+c14screwholepos[c14_model],_wall+5]) {
            scale(c14nutscale) nut("M4");
        }
        translate([_wall+c14_x[c14_model]+c14_length[c14_model]/2,_depth+c14_y[c14_model]-c14screwholepos[c14_model],_wall+5]) {
            scale(c14nutscale) nut("M4");
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
    block_height = uptonut ? block_nut_depth : block[blocktype][2];
    if (ignorepreview) {
        color("greenyellow") {
            rotate([0,0,90]) {
                difference() {
                    cube([block[blocktype][1],block[blocktype][0],block_height]);
                    debprint(str("blocktype is ", blocktype, " and block[blocktype] is ", block[blocktype]));
                    translate([block[blocktype][1]-10,holesize*11,block[blocktype][2]-screwlength]) {
                        cylinder(d=screwholesize, h=screwlength+bugfix, $fn=fn);
                        translate([0,0,4]) {
                            // module nutcatch_sidecut (options, kind = "hexagon", height_clearance = 0, width_clearance = 0, length = A_LOT) {
                            // nutcatch_sidecut("M4", height_clearance = tolerance, width_clearance = tolerance);

                            // name   = "M3",  // name of screw family (i.e. M3, M4, ...)
                            // l      = 50.0,  // length of slot
                            // clk    =  0.0,  // key width clearance
                            // clh    =  0.0,  // height clearance
                            // clsl   =  0.1)  // slot width clearance
                            nutcatch_sidecut(name = "M4", l = nutcatch_depth[blocktype], clk = tolerance, clh = tolerance, clsl = tolerance);
                            debprint("=================================================================================================================");
                            debprint(str("tolerance is ", tolerance));
                            debprint("=================================================================================================================");
                        }
                    }
                }
            }
        }
    } else if ($preview) {
        color("darkgoldenrod") {
            difference() {
                cube(block[blocktype]);
                echo(str("translate([", block[blocktype][0]/2, ", ", block[blocktype][1]/2, ", ", block[blocktype][2]-screwlength, "]"));
                translate([block[blocktype][0]/2,holesize*4,block[blocktype][2]-screwlength]) {
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
wtf = false;

if (wtf) {
    translate([0,0,0]) {
        nut("M4"); // creates a standard M4 nut
    }
} else {
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
}
