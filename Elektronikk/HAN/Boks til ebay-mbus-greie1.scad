// Boks til M-Bus-adapter

debug = true;
idiot = $preview ? .5 : 0;
fn = $preview ? 12 : 31;
board_x = 48;
board_y = 31;
height = debug ? 6 : 22;
walls = 1.5;
gap = 2;
bottom = 2;
hole_r = 1.5;

difference() {
    cube([board_x+walls*2+gap*2,board_y+walls*2+gap*2,height+bottom]);
    translate([walls,walls,bottom]) {
        cube([board_x+gap*2,board_y+gap*2,height+idiot]);
    }
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
}