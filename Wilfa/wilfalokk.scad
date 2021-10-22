$fn = $preview ? 32 : 128;

outer_dim = 111.5;
inner_dim = 108.5;
bleed = 0.5;
height = 8;
thickness = 1.5;

difference() {
    cylinder(d=outer_dim+bleed, h=height);
    translate([0,0,thickness]) {
        cylinder(d=inner_dim-bleed, h=height);
    }
}