use <torus.scad>
// module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50);
// module rounded_cylinder(d=1, h=1, r=0.1, center=true, $fn=100);

// Variables/settings
$fn = $preview ? 16 : 256;
preview_fix = $preview ? 0.1 : 0; // preview shows shadows with zero thin layers, so stop that
d_top = 55;
d_bottom = 45;
thickness = 1.5;
height = 50;
brim_width = 85;
brim_height = thickness*2;
//font="Herculanum:style=Regular";
font="Caligraf Bold PERSONAL USE:style=Regular";
name="Miriam";

// Main code
rounded_cylinder(d=brim_width, h=brim_height, r=brim_height/2, center=false);
translate([0,0,2.5]) {
    difference() {
        cylinder(h=height, d1=d_bottom+thickness*2, d2=d_top+thickness*2);
        cylinder(h=height+preview_fix, d1=d_bottom, d2=d_top);
    }
    translate([0,0,height]) {
        torus(r1=thickness/2, r2=d_top/2+thickness/2);
    }
}
translate([-20,-4,brim_height])
linear_extrude(1) {
    text(name, font=font, size = 8.5);
}