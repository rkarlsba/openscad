/*
 * Hull: 4,4mm
 * Avstand, ytterkant til ytterkant: 134mm 
 * Avstand, sentrum til sentrum: 134-4,4=129,6mm
 * Dybde: 16,2mm
 */

$fn = $preview ? 16 : 64;

hole_d = 4.4;           // In door
screw_d = 4;            // M4
screw_d_clearance = 0.2;   
holes_distance=129.6;   // Between the two
screw_length=16.2;      // Through door
back_disc_d = 16;
back_disc_h = 2;
sprout=10;
screw_sprout_clearance=2;
feste_clearence=.3;

handle_height = 40;
handle_d = 12;
handle_length = holes_distance-handle_d;


// hva skal tegnes?
tegne_feste = false;
tegne_utstikker = false;
tegne_handtak = true;

/* feste */
if (tegne_feste) {
    cylinder(h=back_disc_h, d=back_disc_d);
    cylinder(h=screw_length+back_disc_h+sprout, d=screw_d);
}

/* utstikker */
if (tegne_utstikker) {
    translate([30,0,0]) {
        difference() {
            cylinder(h=handle_height, d=handle_d);
            cylinder(h=sprout+screw_sprout_clearance, d=screw_d+screw_d_clearance);
        }
        translate([handle_d/2,0,handle_height]) {
            rotate([90,270,0]) rotate_extrude(convexity = 10, angle = 90)
                translate([handle_d/2, 0, 0])
                    circle(r = handle_d/2);
            translate([0,0,handle_d/2])
                rotate([0,90,0])
                    cylinder(d1=screw_d, d2=screw_d/2, h=sprout/2);
        }
    }
}
/* håndtak */
if (tegne_handtak) {
    translate([50,0,0]) {
        difference() {
            cylinder(h=handle_length, d=handle_d);
            cylinder(d1=screw_d+feste_clearence, d2=screw_d/2+feste_clearence, h=sprout/2);
            translate([0,0,handle_length-sprout/2])
                cylinder(d1=screw_d/2+feste_clearence, d2=screw_d+feste_clearence, h=sprout/2);
        }
    }
}
