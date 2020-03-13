include </Users/roy/src/git/rkarlsba/lasercut-box-openscad/box.scad>

// HUSK: Alt er ytre mål!
width = 140;
height = 140;
depth = 300;
hole_dist = 50;
$fn = 50;
thickness = 3.3;
finger_width = thickness*2;
open = true;
assemble = true;
inset = 0;
divpercent = 30;

// Top

box(
    width = width, 
    height = height, 
    depth = depth, 
    dividers = [ 1, 0 ], 
    divpercent = divpercent,
    holes = [ [width-(width/2-hole_dist), height/2], [width/2, height/2] ], 
//    ears = thickness*3, 
    thickness = thickness, 
    open = open, 
    assemble = assemble, 
    labels = true, 
    explode = 0,
    finger_width = finger_width,
    inset = inset
);

