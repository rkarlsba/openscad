include <ymse.scad>

fn = 11;
antifuckup = .1;
afu = $preview ? antifuckup : 0;
testprint = 0;

//psu = [100,165,45];
psu = [113,215,51]; // S-480-24, 24V, 20A, 480W
console = [111,65,57];
max_height = console[2] == psu[2] ? console[2] : console[2] > psu[2] ? console[2] : psu[2];
max_width = console[0] == psu[0] ? console[0] : console[0] > psu[0] ? console[0] : psu[0];
psu_console_gap = 30;
back_gap = 5;
box_skip = 30;

x_gap = 1;
console_z_gap = 1;
psu_z_gap = 20;
wall = 3;
x_outer = psu[0]+x_gap*2+wall*2;
z_outer = psu[2]+psu_z_gap*2+wall*2;
x_inner = psu[0]+x_gap*2;
z_inner = psu[2]+psu_z_gap;
depth = testprint ? 20 : psu[1]+console[1]+psu_console_gap+back_gap-box_skip;
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
                for (y=[holesize*2:holesize*2:dim[1]-holesize*2]) {
                    // echo("X is ", x, "Y is ", y);
                    translate([x,y]) {
                        circle(d=holesize, $fn=16);
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
    color("yellow") plate([max_width+x_gap*2+wall*2,depth], wall, 3);

    // Left
    translate([0,0,wall]) {
        rotate([90,0,90]) {
            color("red") plate([depth,max_height+psu_z_gap], wall, 3);
        }
    }
    // Right
    translate([x_inner*tolerance_num+wall,0,wall]) {
        rotate([90,0,90]) {
            color("lightblue") plate([depth,max_height+psu_z_gap], wall, 3);
        }
    }
    // Top
    translate([0,0,max_height+psu_z_gap+wall]) {
        color("pink") plate([max_width+x_gap*2+wall*2,depth], wall, 3);
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


    translate([wall,wall,0]) {
        linear_extrude(wall) {
            difference() {
                square([x_inner,z_inner]);
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
//backplate();
//tube();
//translate([wall,60,0])

//psu_front_x_gap = 1;
//psu_front_z_gap = 1;
largest_x = (console[0] > psu[0]) ? console[0] : psu[0];
console_correction = (largest_x - console[0])/2;

translate([x_gap+wall,console[1]+psu_console_gap,wall]) {
    draw_psu();
}

translate([x_gap+wall+console_correction,0,wall]) {
    draw_console();
}

translate([0,box_skip,0]) {
    outer_frame();
}
