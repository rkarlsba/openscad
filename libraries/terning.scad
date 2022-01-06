$fn = $preview ? 32 : 128;

module roundedcube(size, radius) {
    translate([radius,radius,radius]) {
        hull() {
            for (z = [0, size[2]-radius*2]) {
                translate([0, 0, z]) {
                    sphere(r=radius);
                }
                translate([size[0]-radius*2, 0, z]) {
                    sphere(r=radius);
                }
                translate([0, size[1]-radius*2, z]) {
                    sphere(r=radius);
                }
                translate([size[0]-radius*2, size[1]-radius*2, z]) {
                    sphere(r=radius);
                }
            }
        }
    }
}

side=15;
avrunding=1;

roundedcube([side,side,side], avrunding);