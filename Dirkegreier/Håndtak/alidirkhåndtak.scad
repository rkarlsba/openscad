$fn = 200;
pickhandletemplatefn="/Users/roysk/src/git/rkarlsba/privat/Dokumenter/Inkscape/dirkhåndtak1c.svg";

linear_extrude(.5) {
    import(pickhandletemplatefn);
}

/*$fn = 64;

// Tykkelse
thickness = 1.0;

// Håndtak
handle_w = 8;
handle_h = 42;

// Skaft
neck_w = 2.0;
neck_h = 10;

// Hull
round_hole_d = handle_w*.375;
slot_hole_d = 2.2;
slot_len = round_hole_d*2;

module slot(slot_len = slot_len, width = slot_hole_d) {
    hull() {
        translate([-slot_len/2 + width/2, 0]) {
            circle(d = width);
        }

        translate([slot_len/2 - width/2, 0]) {
            circle(d = width);
        }
    }
}

linear_extrude(height = thickness) {
    difference() {
        union() {
            hull() {
                translate([0, 0]) {
                    circle(d = handle_w);
                }

                translate([0, handle_h]) {
                    circle(d = handle_w);
                }
            }

            translate([-neck_w/2, handle_h]) {
                square([neck_w, neck_h]);
            }
        }

        translate([0, 27]) {
            circle(d = round_hole_d);
        }

        translate([0, 18]) {
            rotate(-30) {
                slot();
            }
        }

        translate([0, 11]) {
            rotate(-30) {
                slot();
            }
        }
    }
}

*/