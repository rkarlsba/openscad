width = 5;
length = 20;
max_thickness = 8;
min_thickness = 0.6;

hull() {
    cube([0.1, width, min_thickness]);
    translate([length-0.1, 0, 0]) {
        cube([0.1, width, max_thickness]);
    }
}