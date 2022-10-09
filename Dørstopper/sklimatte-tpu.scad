$fn = $preview ? 16 : 64;

z = 3;
x = 144;
y = 72;
ball = z;

difference() {
    union() {
        hull() {
//            cube([x,y,z/2]);
            translate([ball/2,ball/2,ball/2]) {
                sphere(d=ball);
            }
            translate([x-ball/2,ball/2,ball/2]) {
                sphere(d=z);
            }
            translate([ball/2,y-ball/2,ball/2]) {
                sphere(d=z);
            }
            translate([x-ball/2,y-ball/2,ball/2]) {
                sphere(d=z);
            }
        }

        for (g=[10:10:x]) {
            translate([g, 0, z]) {
                cube([1, y, .5]);
            }
        }
    }
    union() {
        for (g=[10:10:x]) {
            translate([g, 0, 0]) {
                cube([1, y, .5]);
            }
        }
    }
}