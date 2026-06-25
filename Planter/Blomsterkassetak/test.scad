/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */
// Libs {{{

// ../../libraries/honeycomb/honeycomb.scad
// module honeycomb(x, y, dia, wall)  {

include <honeycomb/honeycomb.scad>

// }}}
// Variables {{{

test = false;
kassebredde = 146;
thickness = 2;
x = 155;
y = kassebredde;
hccellsize = 15;
border_width = test ? 4 : 8;
border_thickness = test ? thickness : 10;
roof_height = 150;

// }}}
// Code {{{


intersection() {
    honeycomb(x, y, hccellsize, thickness);
    translate([x/2, y/2, 0]) {
        cylinder(d=x-thickness, h=width);
    }
}

// }}}
