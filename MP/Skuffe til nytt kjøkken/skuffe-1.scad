include <box.scad>

width = 425;
depth = 485;
height = 63;
thickness = 4;
inner = false;
open = true;
inset = 0;
dividers = [ 0, 1 ];
// divpercent = 70;
//holes = [ ];
hole_dist = width/3;
//holes = [ [width-(width/3), height/2], [width/3*2, height/2] ];
hole_dia = 3;
assemble = false;
kerf = 0.15;
roof = false;


box(
  width = width,
  height = height,
  depth = depth,
  thickness = thickness,
  inner = inner,
  open = open,
  inset = inset,
  dividers = dividers,
  // divpercent = divpercent,
  //holes = holes,
  hole_dia = hole_dia,
  assemble = assemble,
  kerf = kerf,
  roof = roof);