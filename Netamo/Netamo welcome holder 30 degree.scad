// See https://www.thingiverse.com/thing:4020636/files for an original

$fn = $preview ? 24 : 64;
preview_fix = $preview ? .1 : 0;

module top_ring(dia=49, height=6, thickness=2) {
    difference() 
    {
        cylinder(d=dia, h=height);
        translate([0,0,-preview_fix]) {
            cylinder(d=dia-thickness*2, h=height+preview_fix*2);
        }
    }
}

module bottom_plate(dia=43,thickness=4, height=4) {
    cylinder(d=dia, h=height);
}

bottom_plate();
translate([0,0,45]) {
    top_ring();
}
