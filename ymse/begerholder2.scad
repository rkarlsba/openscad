use <torus.scad>
// module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50);
// module rounded_cylinder(d=1, h=1, r=0.1, center=true, $fn=100);

// Variables/settings
//$fn = $preview ? 16 : 256;
$fn = $preview ? 16 : 64;
d_top = 55;
d_bottom = 45;
wall_thickness = 2;
bottom_thickness = 3;
height = 50;

// Functions
module handle(hwidth=10, start=10, stop=10, hheight=height-20, angle=0, dist=32) {
    move_x = d_bottom/2;
    diff_x = d_top-d_bottom;
    x_per_h = diff_x/height;
    tverrligger_h = 3;
    
    rotate([0,0,angle]) {
        echo(move_x, diff_x, x_per_h);
        translate([0, -hwidth/2, start]) {
            cube([dist, hwidth, tverrligger_h]);
        }
        echo("height/2 is ", height/2);
        translate([0, -hwidth/2, height/2]) {
            cube([dist, hwidth, tverrligger_h]);
        }
        translate([0, -hwidth/2, height-stop]) {
            cube([dist, hwidth, tverrligger_h]);
        }
        hull() {
            translate([dist,0,height-stop+tverrligger_h]) {
                sphere(d=hwidth);
            }
            /*
            translate([dist,0,start+tverrligger_h/2]) {
                sphere(r=hwidth/2);
            }
            */
            translate([dist,0,0]) {
                cylinder(d=hwidth, h=.1);
            }
        }
    }
}

// Main code
difference() {
    union() {
        cylinder(h=height, d1=d_bottom+wall_thickness*2, d2=d_top+wall_thickness*2);
        handle(dist=42, angle=0);
        handle(dist=42, angle=60);
    }
    translate([0, 0, bottom_thickness]) {
        cylinder(h=height-bottom_thickness, d1=d_bottom, d2=d_top);
    }
}

translate([0,0,height]) {
    torus(r1=wall_thickness/2, r2=d_top/2+wall_thickness/2);
}
