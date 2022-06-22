// Ymse
pi =  3.1415927;

module roundedsquare(size, radius) {
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([radius, radius]) circle(r=radius);
            translate([size[0]-radius, radius]) circle(r=radius);
            translate([radius, size[1]-radius]) circle(r=radius);
            translate([size[0]-radius, size[1]-radius]) circle(r=radius);
        }
    }
}

module roundedcube(size, radius) {
    if (radius == 0) {
        cube(size);
    } else {
        translate([radius,radius,radius]) {
            hull() {
                for (z = [0, size[2]-radius*2]) {
                    translate([0, 0, z]) sphere(r=radius);
                    translate([size[0]-radius*2, 0, z]) sphere(r=radius);
                    translate([0, size[1]-radius*2, z]) sphere(r=radius);
                    translate([size[0]-radius*2, size[1]-radius*2, z]) sphere(r=radius);
                }
            }
        }
    }
}

// r[adius], h[eight], [rou]n[d]
// roundedcylinder(r=10,h=30,n=.5,$fn=200);
module roundedcylinder(r,h,n) {
    rotate_extrude(convexity=1) {
        offset(r=n) {
            offset(delta=-n) {
                square([r,h]);
            }
        }
        square([n,h]);
    }
}


module flat_heart(size) {
    intsize = size/pi*2;
    rotate([0,0,45]) {
        square(intsize);
        translate([intsize/2, intsize, 0])
            circle(intsize/2, $fn=32);

        translate([intsize, intsize/2, 0])
            circle(intsize/2, $fn=32);
    }
}

module ramme(size, border=1) {
    difference() {
        square(size);
        translate([border,border])
            square([size[0]-border*2,size[1]-border*2]);
    }
}

module skruehull(diameter, lengde, innsenkning = 0) {
    cylinder(d = diameter, h = lengde);
    if (innsenkning != 0) {
        translate([0, 0, lengde-innsenkning]) {
            cylinder(h=innsenkning, d1=diameter, d2=diameter+innsenkning);
        }
    }
}

// Warn users including this with 'include' without knowing better
echo("Don't 'include' this if you just want to use its modules etc. Better 'use' it.");

//roundedcube([40,40,10], 2, $fn=16);
/*
// lalalatest
linear_extrude(height = 13)
    flat_heart(27);
*/

//flat_heart(10);