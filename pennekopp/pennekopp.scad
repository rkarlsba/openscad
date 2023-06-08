$fn = $preview ? 16 : 256;
preview_fix = $preview ? 0.1 : 0; // preview shows shadows with zero thin layers, so stop that

inner_h = 100;
inner_d = 72.5;
wall    = 6;
bottom  = 10;
outer_d = inner_d + wall*2;
outer_h = inner_h + bottom;

difference() {
    cylinder(h=outer_h, d=outer_d);
    translate([0,0,bottom]) {
        cylinder(h=inner_h+preview_fix, d=inner_d);
    }
}
