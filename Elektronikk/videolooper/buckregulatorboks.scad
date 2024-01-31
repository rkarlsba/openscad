// Boks LM2596-basert buck-converter

debug = true;
idiot = $preview ? .5 : 0;
fn = $preview ? 12 : 31;

board_x = 43.5;
board_y = 21;
ol_height = 3; // overlapp
b_height = 9;
t_height = 13.5-b_height; // bare skruen stikker ut
walls = 3;
gap = 1;
bottom = 3;
hole_r = 1.5;
lh_width = 4; // lead hole
lh_height = 5.5; // lead hole

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
    translate([0,walls+gap,bottom]) {
        cube([walls,lh_width,lh_height]);
    }
    translate([0,walls+board_y-lh_width+gap,bottom]) {
        cube([walls,lh_width,lh_height]);
    }
    translate([walls+board_x+gap*2,walls+gap,bottom]) {
        cube([walls,lh_width,lh_height]);
    }
    translate([walls+board_x+gap*2,walls+board_y-lh_width+gap,bottom]) {
        cube([walls,lh_width,lh_height]);
    }
}

    
    /*
    translate([(walls+walls/2+3), walls+walls/2+3,-idiot], $fn=fn) {
        cylinder(r=hole_r,h=bottom+idiot*2);
    }
    translate([board_x-(walls-walls/2-3),(walls+walls/2+3),-idiot], $fn=fn) {
        cylinder(r=hole_r,h=bottom+idiot*2);
    }
    translate([(walls+walls/2+3),board_y-(walls-3),-idiot], $fn=fn) {
        cylinder(r=hole_r,h=bottom+idiot*2);
    }
    translate([board_x-walls+3,board_y-(walls-3),-idiot], $fn=fn) {
        cylinder(r=hole_r,h=bottom+idiot*2);
    }
    */
