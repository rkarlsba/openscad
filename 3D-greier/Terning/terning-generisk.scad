$fn = $preview ? 16 : 128;

terning_x = 100;
terning_y = terning_x;
terning_z = terning_x;
curvage = sqrt(2);

intersection() {
    translate([terning_x/2,terning_y/2,terning_z/2]) {
        sphere(d=terning_x*curvage);
    }
    cube([terning_x,terning_y,terning_z]);
}