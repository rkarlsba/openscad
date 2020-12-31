x = 4*25.4;
y = 68;
height = 12;
thickness = 1.5;
xspace = 3;
yspace = 2;

intx = x + xspace;
inty = y + yspace;

difference() {
    cube([intx, inty, height]);
    translate([thickness,0,thickness]) {
        cube([intx-thickness*2, inty-thickness, height-thickness]);
    }
}