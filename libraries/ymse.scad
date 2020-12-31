// Ymse
pi =  3.1415927;

module roundedsquare(size, radius) {
    hull() {
        translate([radius, radius]) circle(r=radius);
        translate([size[0]-radius, radius]) circle(r=radius);
        translate([radius, size[1]-radius]) circle(r=radius);
        translate([size[0]-radius, size[1]-radius]) circle(r=radius);
    }
}

module roundedcube(size, radius) {
    hull() {
        translate([radius, radius, radius]) sphere(r=radius);
        translate([size[0]-radius, radius, radius]) sphere(r=radius);
        translate([radius, size[1]-radius, radius]) sphere(r=radius);
        translate([size[0]-radius, size[1]-radius, radius]) sphere(r=radius);
    
        translate([radius, radius, size[2]-radius]) sphere(r=radius);
        translate([size[0]-radius, radius, size[2]-radius]) sphere(r=radius);
        translate([radius, size[1]-radius, size[2]-radius]) sphere(r=radius);
        translate([size[0]-radius, size[1]-radius, size[2]-radius]) sphere(r=radius);
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

// Warn users including this with 'include' without knowing better
echo("Don't 'include' this if you just want to use its modules etc. Better 'use' it.");

roundedcube([40,40,10], 2, $fn=16);
/*
// lalalatest
linear_extrude(height = 13)
    flat_heart(27);
*/