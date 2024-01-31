$fn = $preview ? 32 : 64;

base_h = 15;
base_r = 80;
base_scale = [1,1,1/3];
pole_r = 11.5;
pole_h = 250;

intersection() {
    scale(base_scale) {
        sphere(r=base_r);
    }
    translate([0,0,-base_h/2]) {
        cylinder(h=base_h,r=base_r);
    }
}
cylinder(r=pole_r, h=pole_h);