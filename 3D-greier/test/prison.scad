// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// variables
x = 60;
y = 40;
z = 20;
th = 1;
walls = 4;
door = 10;
door_height = y/4;
font = ".New York";

render(convexity=4) {
    difference() {
        cube([x,y,z]);
        translate([walls,walls,0]) {
            cube([x-walls*2,y-walls*2,z]);
        }
        translate([x/2,0,door_height]) {
            rotate([270,0,0]) {
                cylinder(h=walls, d=door);
            }
        }
        translate([x/2-door/2,0,0]) {
            cube([door,walls,door_height]);
        }
    }
}
