include </Users/roy/driiiiit/Nextcloud/Dokumenter/Bitraf/Laserkutterting/lasercut-box-openscad/box.scad>

depth = 250;
width = 160;
height = 40;
thickness = 3.6;
spacing = 1;
assemble = false;
open = true;
name = "Anafon";
font = "Copperplate Normal";
textspacing = 1;
textsize = 10;

if (!assemble) {
    translate([0,0,-0.5])
        linear_extrude(height=1)
            text(name, size=textsize, spacing=textspacing, font=font);
}

box(
    width = width,
    height = height,
    depth = depth,
    thickness = thickness,
    open = false,
    assemble = assemble,
    spacing = spacing
);

