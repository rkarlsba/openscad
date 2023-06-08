use <torus.scad>
// module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50);
// module rounded_cylinder(d=1, h=1, r=0.1, center=true, $fn=100);

// Variables/settings
$fn = $preview ? 16 : 256;
d_top = 55;
d_bottom = 45;
thickness = 3;
height = 50;
brim_width = 85;
brim_height = thickness;

// Main code
rounded_cylinder(d=brim_width, h=brim_height, r=brim_height/2, center=false);
translate([0,0,2.5]) {
    difference() {
        cylinder(h=height, d1=d_bottom+thickness*2, d2=d_top+thickness*2);
        cylinder(h=height, d1=d_bottom, d2=d_top);
    }
    translate([0,0,height]) {
//        torus(r1=d_top/2, r2=thickness);
        torus(r1=thickness/2, r2=d_top/2+thickness/2);
    }
}