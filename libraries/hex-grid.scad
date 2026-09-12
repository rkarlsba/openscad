// vim:ft=openscad
include <BOSL2/std.scad>
// The Belfry OpenSCAD Library V2
// Source: https://github.com/revarbat/BOSL2
// Documentation: https://github.com/revarbat/BOSL2/wiki
// BOSL2 is licensed under BSD 2-Clause License
//    https://github.com/revarbat/BOSL2/blob/master/LICENSE

////////////////////////////////////////////////////////////////////
// cell: takes three parameters and returns a single hexagonal cell
//
//   SW_hole: scalar value that specifies the width across the flats
//     of the interior hexagon
//   height: scalar value that specifies the height/depth of the 
//     cell (i.e. distance from from front to back
//   wall: scalar vale that specifies the thickness of the wall 
//     surrounding the interior hex (hole). e.g. if SW_hole is 8 
//     and wall is 2 then the total width across the flats of the
//     cell is 8 + 2(2) = 12.
////////////////////////////////////////////////////////////////////
module cell(SW_hole, height, wall) {
  tol = 0.001; // used to clean up difference artifacts
  difference() {
    cyl(d=SW_hole+2*wall,h=height,$fn=6,circum=true);
    cyl(d=SW_hole,h=height+tol,$fn=6,circum=true);
  }
}

////////////////////////////////////////////////////////////////////
// grid: takes three parameters and returns the initial grid of 
//    hexagons
//
//    size: 3-vector (x,y,z) that specifies the  size of the cube 
//      that contains the hex grid
//    cell_hole: scalar value specifying width across flats of the 
//      interior hexagon (hole)
//    cell_wall: scalar value that specifies wall thickness of the
//      hexagon
////////////////////////////////////////////////////////////////////
module grid(size,cell_hole,cell_wall) {
  dx=cell_hole*sqrt(3)+cell_wall*sqrt(3);
  dy=cell_hole+cell_wall;

  ycopies(spacing=dy,l=size[1])    
    xcopies(spacing=dx,l=size[0]) {
      cell(SW_hole=cell_hole,
           height=size[2],
           wall=cell_wall);
      right(dx/2)fwd(dy/2)
      cell(SW_hole=cell_hole,
          height=size[2],
          wall=cell_wall);
    }
 }

////////////////////////////////////////////////////////////////////
// mask: creates a mask that is used by the module create_grid()
//   The mask is used to remove extra cells that are outside the 
//   cube that holds the final grid
////////////////////////////////////////////////////////////////////
module mask(size) {
  difference() {
    cuboid(size=2*size);
    cuboid(size=size);
  }
}

////////////////////////////////////////////////////////////////////
// create_grid: creates a rectangular grid of hexagons with an
//   independently configurable frame wall thickness.
//
//   size: 3-vector (x,y,z) that specifies the length, width, and
//     depth of the final grid
//   SW: scalar value that specifies the width across the flats of
//     the interior hexagon (the hole)
//   cell_wall: scalar value that specifies the wall thickness of
//     each individual hexagon cell
//   frame_wall: scalar value that specifies the thickness of the
//     surrounding rectangular frame
////////////////////////////////////////////////////////////////////
module create_grid(size, SW, cell_wall, frame_wall) {
  union() {
    difference() {
      cuboid(size=size);
      cuboid(size=[size[0]-2*frame_wall,
                  size[1]-2*frame_wall,
                  size[2]+frame_wall]);
    }
  }

  difference() {
    grid(size=size, cell_hole=SW, cell_wall=cell_wall);
    mask(size);
  }
}

////////////////////////////////////////////////////////////////////
// create_circular_grid: creates a hex grid inside a circular frame.
//
//   diameter: scalar value specifying the outer diameter of the
//     circular frame
//   height: scalar value specifying the depth (z) of the grid
//   SW: scalar value that specifies the width across the flats of
//     the interior hexagon (the hole)
//   cell_wall: scalar value that specifies the wall thickness of
//     each individual hexagon cell
//   frame_wall: scalar value that specifies the radial thickness
//     of the surrounding circular frame
//   $fn: number of facets used to approximate curved surfaces
//     (default 36). Higher values produce smoother circles at the
//     cost of longer render times.
////////////////////////////////////////////////////////////////////
module create_circular_grid(diameter, height, SW, cell_wall, frame_wall, $fn=36) {
  tol = 0.001;
  grid_size = [diameter, diameter, height];

  // Circular frame ring
  difference() {
    cyl(d=diameter, h=height);
    cyl(d=diameter - 2*frame_wall, h=height + tol);
  }

  // Hex grid clipped to the full circular area
  intersection() {
    difference() {
      grid(size=grid_size, cell_hole=SW, cell_wall=cell_wall);
      mask(grid_size);
    }
    cyl(d=diameter, h=height);
  }
}

////////////////////////////////////////////////////////////////////
// Examples
//
// Rectangular grid with separate cell and frame wall widths:
//   create_grid(size=[100,150,10], SW=20, cell_wall=2, frame_wall=4);
//
// Circular grid:
//   create_circular_grid(diameter=120, height=10, SW=20,
//                        cell_wall=2, frame_wall=4);
//
// Circular grid with smoother curves ($fn=128):
//   create_circular_grid(diameter=120, height=10, SW=20,
//                        cell_wall=2, frame_wall=4, $fn=128);
////////////////////////////////////////////////////////////////////
//create_grid(size=[100,150,10], SW=20, cell_wall=2, frame_wall=4);
//create_circular_grid(diameter=120, height=10, SW=20, cell_wall=2, frame_wall=4, $fn=128);
