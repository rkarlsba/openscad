// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Filament rack, lasercut or 3D printed. A module with tree slots will just fit
// on a 256mm cubed printer. For lasercut MDF, I chose eight slots, since that
// fits neatly on the MDF sheets I have available for use with a lasercutter.
// Change the settings as you like and press F5 to preview, F6 to render. If you
// want to 3D print it, make sure "assemble = true" in the box() call. For
// lasercut, make sure "asseble = false". To export files for lasercutting,
// press F6 to render and choose File | Export and export in the format the
// laser software can read. Lightburn works well with SVG, while other software
// may need DXF.
//
// This uses my fork of the box.scad library, available from
// https://github.com/rkarlsba/lasercut-box-openscad
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY v4.0 or later. Please see
// https://creativecommons.org/licenses/by/4.0/ for details.
//
// module box {{{
//
// module box(
//   width, height, depth, thickness,
//   finger_width, // (default = 2 * thickness)
//   finger_margin, // (default = 2 * thickness)
//   inner = false,
//   open = false,
//   open_bottom = false,
//   inset = 0,
//   dividers = [ 0, 0 ],
//   divpercent = 0,
//   holes = [],
//   hole_dia = 0,
//   ears = 0,
//   robust_ears = false,
//   assemble = false,
//   hole_width = false,
//   kerf = 0.0,
//   labels = false,
//   explode = 0,
//   spacing = 0,
//   double_doors = false,
//   door_knob = 0,
//   perf_size = 0,
//   perf_all = false,
//   perf_walls = false,
//   perf_top = false,
//   perf_floor = false,
//   roof = false)
//
//   }}}
include <box.scad>

debug = true;

// Parameters
n = 8;                  // Number of shelves
spool_diameter = 210;
spool_width = 73;
material_thickness = 2; // This also controls the wall width if 3d printed.
assemble = true;        // True for showing a nice preview or for exporting an STL.
hole_dia = 4;
bottom_holes = [ [ spool_diameter/4, spool_width*n-spool_width/2 ], [ spool_diameter/4*3, spool_width*n-spool_width/2 ] ];

echo(str("DEBUG: Høyden blir ", spool_width*n+material_thickness*2));
box(width = spool_diameter, depth = spool_width*n, height = spool_diameter,
    inner = true, open = true, dividers = [ n-1, 0 ], thickness = material_thickness,
    bottom_holes = bottom_holes, hole_dia = hole_dia,
    assemble = assemble);

