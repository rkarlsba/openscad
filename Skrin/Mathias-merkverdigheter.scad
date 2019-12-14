include </Users/roysk/src/git/lasercut-box-openscad/box.scad>

//w = 210;
//h = 50;
//d = 297;

d = 210;
w = 148;
h = 40;
assemble = false;
hole_dist = 50;
thickness = 3.8;
$fn = 50;
spacing = 2;

// Top

box(width = w, height = h, depth = d, dividers = [ 2, 1 ], holes = [ [w-(w/2-hole_dist), h/2], [w/2, h/2] ], ears = 12, thickness = thickness, open = false, assemble = assemble, labels = true, explode = 0, spacing = spacing);

