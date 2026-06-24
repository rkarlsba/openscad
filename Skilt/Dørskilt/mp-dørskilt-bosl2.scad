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
skilt_border = skilt_base;
text_height = skilt_base;
holes = 4;
tekst = "Eva og Sigurd Karlsbakk";
bilde = false;
// bilde = "Dørskilt-enkelt.svg";
font_face = "Chalkduster";
font_size = 25;
skilt_dim = [150,50,skilt_base];
rounding_size = skilt_base;
jointype = "miter";

// }}}
// module skilt() {{{

module skilt(dim, tekst, r=0, base=skilt_base, border=skilt_border, bilde=undef, tekst=undef) {
    cube(dim, center=true);
    translate([0,0,base]) {
        linear_extrude(text_height) {
            // stroke(rect([dim[0], dim[1]]), width=skilt_border, closed=true, jointype="miter");
            // stroke(
            //     offset(delta=-border/2) rect(([dim[0], dim[1]]), center=true),
            //     width=skilt_border,
            //     jointype="round"      // "round", "bevel", "miter"
            // );
            //
    // offset_stroke(path, [width], [rounded=], [chamfer=], [start=], [end=], [check_valid=], [quality=], [closed=],...) [ATTACHMENTS];
            offset(-skilt_border/2) offset_stroke(rect([dim[0], dim[1]]), skilt_border*1.5, rounded=true, closed=true);
        }


    }
}

// }}}
// main() {{{

render(convexity=10) { // Make preview behave correctly
    skilt(skilt_dim, skilt_r);
}

// }}}
// /
// Loaded design '/Users/roysk/src/git/rkarlsba/openscad/Skilt/MP/mp-dørskilt.scad'.
// ERROR: Parser error: syntax error in file Users/roysk/src/git/rkarlsba/openscad/Skilt/MP/mp-dørskilt.scad, line 49
// Execution aborted
