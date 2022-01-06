$fn = $preview ? 32 : 256;

outer_dim = 111.5;
inner_dim = 108.5;
bleed = 0.5;
height = 8;
theight = 0.5;
thickness = 1.5;

difference() {
    union() {
        difference() {
            cylinder(d=outer_dim+thickness*2+bleed, h=height);
            translate([0,0,thickness]) {
                cylinder(d=outer_dim+bleed, h=height-thickness);
            }
        }

        difference() {
            cylinder(d=inner_dim-bleed, h=height);
            translate([0,0,thickness]) {
                cylinder(d=inner_dim-bleed, h=height);
            }
        }
    }
    translate([23,-6,0]) {
        linear_extrude(theight) {
            mirror([1,0,0]) {
                text(text = "Kaffe", size=14);
            }
        }
    }
}
