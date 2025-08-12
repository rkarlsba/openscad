include <ymse.scad>

fn = 11;
antifuckup = .1;
afu = $preview ? antifuckup : 0;
testprint = 1;

psu = [100,165,45];
psu_gap = 10;
wall = 3;
x_outer = psu[0]+psu_gap*2+wall*2;
y_outer = psu[2]+psu_gap*2+wall*2;
x_inner = psu[0]+psu_gap*2;
y_inner = psu[2]+psu_gap;
depth = testprint ? 20 : psu[1]+80;
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

module tube(length=length) {
    linear_extrude(length) {
        difference() {
            square([x_outer,y_outer]);
            translate([wall,wall]) {
                square([x_inner,y_inner]);
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

module inner_frame(x=0, tolerance=tolerance, depth=depth) {
    largest = y_inner > x_inner ? y_inner : x_inner;
    tolerance_num=largest/(largest + tolerance);
    echo(largest, tolerance, tolerance_num);
    
    translate([wall,wall,0]) {
        rotate([0,270,0]) {
            plate([depth,y_inner*tolerance_num], wall, 3);
        }
    }
    translate([wall,wall*2,0]) {
        rotate([90,0,0]) {
            plate([(x_inner)*tolerance_num,depth], wall, 3);
        }
    }
    translate([wall,(y_inner+wall)*tolerance_num,0]) {
        rotate([90,0,0]) {
            plate([(x_inner)*tolerance_num,depth], wall, 3);
        }
    }
    translate([x_inner*tolerance_num+wall,wall,0]) {
        rotate([0,270,0])
        plate([depth,y_inner*tolerance_num], wall, 3);
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
                square([x_inner,y_inner]);
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

module frontplate() {
    translate([wall,wall,0]) {
        difference() {
            linear_extrude(wall) {
                difference() {
                    square([x_inner,y_inner]);
                    translate([25-2,(y_inner-term_clips_h)/2]) {
                        square([term_x+4,term_clips_h]);
                    }
                    translate([25,(y_inner-term_y)/2]) {
                        square([term_x,term_y]);
                    }
                    translate([9,y_inner/3]) {
                        circle(d=4.2, $fn=fn*2);
                    }
                    translate([9,y_inner/3*2]) {
                        circle(d=4.2, $fn=fn*2);
                    }
                }
            }
        }
    }
}

module draw_psu() {
    
    if ($preview) {
        echo("preview");
    } else {
        echo("not preview");
    }

    if ($preview) {
        color("Lime") {
            cube(psu);
        }
    } else {
        echo("Not printing psu");
    }
}

//frontplate();
//tube();
//backplate();
//tube();
//translate([wall,60,0])
inner_frame();
translate([psu_gap+wall,psu[2]+wall*2,0]) 
{
    rotate([90,0,0]) 
    {
        draw_psu();
    }
}