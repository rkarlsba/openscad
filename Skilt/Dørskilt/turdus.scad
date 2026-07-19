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
skilt_border = 1;
text_height = 1;
hole_d_bottom = 3;
hole_d_top = 5.5;
tekst = "Turdus";
//bilde = false;
bilde = "svarttrost-skilt3.svg";
// font_face = "Chalkduster";
// font_face = "Helvetica";
// font_face = "Helvetica:style=Bold";
font_face = "Cochin:style=Bold";
font_size = 10.5;
skilt_dim = [78,33,skilt_base];
rounding_size = skilt_base;
holes = false;
bildepos = [1,3];
tekstpos = bildepos + [24,7.7];
avrunding = 2.5;

// }}}
// Functions {{{

// }}}
// module skilt() {{{

module skilt(dim, r=0, tekst=tekst, bilde=bilde, base=skilt_base, border=skilt_border) {
    difference() {
        union() {
            // cube(dim);
            linear_extrude(height=dim.z) {
                rect([dim.x, dim.y], rounding=avrunding, anchor=FRONT+LEFT);
            }

            translate([0, 0, base]) {
                linear_extrude(text_height) {
                    difference() {
                        rect([dim.x, dim.y], rounding=avrunding, anchor=FRONT+LEFT);
                        translate([skilt_border,skilt_border]) {
                            rect([dim.x, dim.y]-[skilt_border*2,skilt_border*2], rounding=avrunding, anchor=FRONT+LEFT);
                        }
                    }

                    // Bilde
                    if (bilde) {
                        translate(bildepos) {
                            shrink=.8;
                            scale([shrink,shrink,shrink]) {
                                import(bilde);
                            }
                        }
                    }
                    
                    // Tekst
                    if (tekst) {
                        translate(tekstpos) {
                            text(tekst, size=font_size, font=font_face, spacing=1);
                        }
                    }
                    
                }
            }
        }
        // Høl
        // Nederst til venstre
        if (holes) {
            translate([7,7]) {
                cylinder(d1=hole_d_bottom, d2=hole_d_top, skilt_base+text_height);
            }

            // Øverst til venstre
            translate([7,43]) {
                cylinder(d1=hole_d_bottom, d2=hole_d_top, skilt_base+text_height);
            }

            // Øverst til høyre
            translate([skilt_dim[0]-7,43]) {
                cylinder(d1=hole_d_bottom, d2=hole_d_top, skilt_base+text_height);
            }

            // Nederst til høyre
            translate([skilt_dim[0]-7,7]) {
                cylinder(d1=hole_d_bottom, d2=hole_d_top, skilt_base+text_height);
            }
        }

    }
}

// }}}
// main() {{{

render(convexity=10) { // Make preview behave correctly
    skilt(skilt_dim, skilt_r);
}

// }}}
