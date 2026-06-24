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
text_height = .6;
hole_d_bottom = 3;
hole_d_top = 5.5;
tekst = "Helga Mari Merula";
//bilde = false;
bilde = "svarttrost-skilt1.svg";
// font_face = "Chalkduster";
// font_face = "Helvetica";
font_face = "Helvetica:style=Bold";
font_size = 7.7;
skilt_dim = [135,50,skilt_base];
rounding_size = skilt_base;

// }}}
// Functions {{{

// }}}
// module skilt() {{{

module skilt(dim, r=0, tekst=tekst, bilde=bilde, base=skilt_base, border=skilt_border) {
    difference() {
        union() {
            cube(dim);
            translate([0, 0, base]) {
                linear_extrude(text_height)
                {
                    difference() {
                        square([dim[0], dim[1]]);
                        translate([skilt_border,skilt_border]) {
                            square([dim[0], dim[1]]-[skilt_border*2,skilt_border*2]);
                        }
                    }

                    translate([skilt_border*3,skilt_border*3]) {
                        difference() {
                            square([dim[0], dim[1]]-[skilt_border*6,skilt_border*6]);
                            translate([skilt_border*1,skilt_border*1]) {
                                square([dim[0], dim[1]]-[skilt_border*8,skilt_border*8]);
                            }
                        }
                    }

/* innvendig ramme og buer ikke i bruk her {{{
                    // Buer

                    // Nederst til venstre
                    translate([6,6]) {
                        path = arc(r=5, angle=90);
                        stroke(path, endcap1="butt", endcap2="butt", width=skilt_border);
                    }

                    // Øverst til venstre
                    translate([6,44]) {
                        path = arc(r=5, angle=90, start=270);
                        stroke(path, endcap1="butt", endcap2="butt", width=skilt_border);
                    }

                    // Øverst til høyre
                    translate([144,44]) {
                        path = arc(r=5, angle=90, start=180);
                        stroke(path, endcap1="butt", endcap2="butt", width=skilt_border);
                    }

                    // Nederst til høyre
                    translate([144,6]) {
                        path = arc(r=5, angle=90, start=90);
                        stroke(path, endcap1="butt", endcap2="butt", width=skilt_border);
                    }

                    // Linjer

                    // Venstre
                    stroke([[6+skilt_border/2,13], [6+skilt_border/2,37]], endcap1="butt", endcap2="butt", width=skilt_border);

                    // Topp
                    stroke([[13,43+skilt_border/2], [137,43+skilt_border/2]], endcap1="butt", endcap2="butt", width=skilt_border);

                    // Høyre
                    stroke([[144-skilt_border/2,13], [144-skilt_border/2,37]], endcap1="butt", endcap2="butt", width=skilt_border);

                    // Bunn
                    stroke([[13,6+skilt_border/2], [137,6+skilt_border/2]], endcap1="butt", endcap2="butt", width=skilt_border);

}}} */

                    // Bilde
                    if (bilde) {
                        translate([4,13.3]) {
                            shrink=.8;
                            scale([shrink,shrink,shrink]) {
                                import(bilde);
                            }
                        }
                    }
                    
                    // Tekst
                    if (tekst) {
                        translate([28,21]) {
                            text(tekst, size=font_size, font=font_face, spacing=1);
                        }
                    }
                    
                }
            }
        }
        // Høl
        // Nederst til venstre
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

// }}}
// main() {{{

render(convexity=10) { // Make preview behave correctly
    skilt(skilt_dim, skilt_r);
}

// }}}
