x=21;
y=17;
z=6;
pad=1;
vegg=1.5;

draw_box = 0;
draw_lid = 1;

if (draw_box) {
    difference() {
        cube([x+vegg*2,y+vegg*2,z+vegg]);
        translate([vegg,vegg,vegg]) {
            cube([x,y,z+vegg]);
        }
    }
    translate([vegg+2.5,vegg+2.5,vegg]) { cylinder(r=.8,h=1.5,$fn=50); }
    translate([x-vegg+.5,vegg+2.5,vegg]) { cylinder(r=.8,h=1.5,$fn=50); }
}

if (draw_lid) {
    translate([0,(draw_box > 0) ? -y-3 : 0, 0]) {
        cube([x+vegg*2,y-3,vegg]);
        translate([vegg,vegg,vegg]) {
            cube([x,y-3-vegg,vegg]);
        }
    }
}