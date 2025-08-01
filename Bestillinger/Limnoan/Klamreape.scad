cube1 = [127,36,16];
cube2 = [31,36,36];
cube3 = [21,21,cube2[2]];
tube_ir = 4.6;
tube_or = 19; // ikke 18? som i cube1[1]/2?
setscrewhole_r = 3.1;

module skalk(inner_r, outer_r, thickness, angle=360) {
    rotate_extrude(convexity = 10, angle=angle)
        translate([inner_r, 0, 0])
            square([outer_r,thickness]);
}

module tube(inner_r, outer_r, length) {
    difference() {
        cylinder(h=length, r=outer_r);
        cylinder(h=length, r=inner_r);
    }
}

module setscrewhole() {
    translate([cube2[0]/2, cube2[1], cube1[2]]) {
        echo("r=", setscrewhole_r, "h=", (cube1[1]-cube3[1])/2);
        rotate([90,0,0]) {
            cylinder(r=setscrewhole_r, h=(cube1[1]-cube3[1])/2, $fn=100);
        }
    }
}

module klamreape() {
    difference() {
        union() {
            cube(cube1);
            cube(cube2);
            translate([cube2[0],0,0]) {
                rotate([270,270,0]) {
                    skalk(0, cube2[1], cube2[1], 90, $fn=100);
                }
            }
            translate([cube1[0],cube1[1]/2,0]) {
                cylinder(r=tube_or, h=cube1[2], $fn=100);
            }
        }
        translate([(cube2[0]-cube3[0])/2,(cube2[1]-cube3[1])/2,0]) {
            cube(cube3);
        }
        translate([cube1[0],cube1[1]/2,0]) {
            cylinder(r=tube_ir, h=cube1[2], $fn=100);
        }
        setscrewhole();
    }
}

klamreape();
// setscrewhole();