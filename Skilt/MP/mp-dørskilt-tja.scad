// vim modeline {{{
//
// vim:ts=4:sw=4:ts=4:et:ai:si:fdm=marker:tw=120
//
// }}}
// Libraries {{{

include <BOSL2/std.scad>

// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Variables {{{

skilt_r = 3;
skilt_base = 1.5;
holes = 4;
tekst = "Eva og Sigurd Karlsbakk";
font_face = "Chalkduster";
font_size = 25;
bilde = false;
skilt_dim = [150,50,skilt_base];

// }}}
// module skilt() {{{

module skilt(dim, tekst, r=0, base=skilt_base, border=skilt_border, bilde=undef, tekst=undef) {
    cube(dim);
    translate([0,0,base]) {
        difference()
        {
            cube([dim]);
            cube([dim[0]-border*2, dim[1]-border*2, text_height]);
        }
    }
}

// }}}
// module gammeltskilt() {{{

module gammeltskilt() {
    translate([0,0,2]) {
        difference() {
            cube([102,24,2]);
            translate([2,2,0]) {
                cube([98,20,2]);
            }
        }
    }

    translate([8,8,2]) {
        linear_extrude(2)  {
            text(tekst);
        }
    }
}

// }}}
// main() {{{

skilt(skilt_dim, skilt_r);
/*
translate([0, -30, 0]) {
    gammeltskilt();
}
*/

// }}}
