include </Users/roy/src/git/rkarlsba/lasercut-box-openscad/box.scad>

w = 210;
h = 50;
d = 297;
assemble = true;
open = true;
hole_dist = 50;
thickness = 3.8;
$fn = 50;
spacing = 2;

// Top

box(width = w, height = h, depth = d, dividers = [ 3, 1 ], holes = [ [w-(w/2-hole_dist), h/2], [w/2, h/2] ], ears = 12, thickness = thickness, open = open, assemble = assemble, labels = true, explode = 0, spacing = spacing);

