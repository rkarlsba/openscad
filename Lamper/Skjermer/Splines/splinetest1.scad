// /Users/roysk/src/git/rkarlsba/openscad/libraries/tjw-scad
use <tjw-scad/spline.scad>;
// use <tjw-scad/moves.scad>;

lamp_profile = [
    [0, 0],     // base center
    [6, 0],     // base outer
    [8, 10],    // flare out
    [6, 20],    // taper in
    [7, 30]     // top
];

spline_lathe(lamp_profile, subdivisions=5);
