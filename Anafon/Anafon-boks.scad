include </Users/roy/driiiiit/Nextcloud/Dokumenter/Bitraf/Laserkutterting/lasercut-box-openscad/box.scad>

depth=250;
width=160;
height=40;
thickness=3.6;
spacing = 1;
assemble = true;
open = true;

box(
    width = width,
    height = height,
    depth = depth,
    thickness = thickness,
    open = false,
    assemble = assemble,
    spacing = spacing
);
