include </Users/roy/src/git/rkarlsba/lasercut-box-openscad/box.scad>

$fn = 50;

thickness = 3;
w = 140;
h = 50;
d = 140;
middle_dividers = [ 2, 0 ];
bottom_dividers = [ 0, 1 ];

assemble=false;
open=false;
//assemble=true;
//open=true;

box(width = w, height = h, depth = d,
    dividers = [ 0, 1 ],
    ears = 10,
    thickness = thickness,
    open = open, assemble = assemble, labels = true,
    robust_ears = false,
    spacing=1,
    divpercent=70);
