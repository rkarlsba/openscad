// boksholder

$fn = $preview ? 32 : 128;

std_can_d = 66;
std_can_bottom_d = 50;
bottom_taper_h = 12;
500ml_can_h = 168;
330ml_can_h = 116;
wall = 2;
bottom = 3;
gap = 2;

can_h = 330ml_can_h;
can_d = std_can_d + gap*2;
can_outer_d = can_d+wall*2;

cylinder(d=can_outer_d,h=bottom);
translate([0,0,bottom]) {
    difference() {
        cylinder(d=can_outer_d, h=can_h);
        union() {
            cylinder(d1=std_can_bottom_d, d2=can_d, h=bottom_taper_h);
            translate([0,0,bottom_taper_h]) {
                cylinder(d=can_d, h=can_h-bottom_taper_h);
            }
        }
    }
}