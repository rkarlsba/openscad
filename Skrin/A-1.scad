include </Users/roy/src/git/lasercut-box-openscad/box.scad>

width = 150;
height = 40;
depth = 150;
hole_dist = 50;
$fn = 50;
thickness = 3.3;
finger_width = thickness*2;
open = false;
assemble = false;
inset = 0;

// Top

box(
    width = width, 
    height = height, 
    depth = depth, 
    dividers = [ 2, 1 ], 
    holes = [ [width-(width/2-hole_dist), height/2], [width/2, height/2] ], 
    ears = thickness*3, 
    thickness = thickness, 
    open = open, 
    assemble = assemble, 
    labels = true, 
    explode = 0,
    finger_width = finger_width,
    inset = inset,
    double_doors = 1
);

