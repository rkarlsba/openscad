/*
module roundedRect(size, radius) {
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z) {
        hull() {
            // place 4 circles in the corners, with the given radius
            translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0]) {
                circle(r=radius);
            }

            translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0]) {
                circle(r=radius);
            }

            translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0]) {
                circle(r=radius);
            }

            translate([(x/2)-(radius/2), (y/2)-(radius/2), 0]) {
                circle(r=radius);
            }
        }
    }
}
*/
module miniround(size, radius) {
//    $fn=50;
    x = size[0]-radius/2;
    y = size[1]-radius/2;

    minkowski() {
        cube(size=[x,y,size[2]]);
        //cylinder(r=radius);
        // Using a sphere is possible, but will kill performance
        sphere(r=radius);
    }

}

module halfbowl(x,y,z,r) {
    difference() {
        translate([r,r,r]) {
            miniround([x,y,z], r, $fn=64);
        }
        translate([0,0,z+r]) {
            cube([x+r*2,y+r*2,r]);
        }
    }
}


module bowl(x,y,z,r,th) {
    difference() {
        halfbowl(x,y,z,r);
        translate([th,th,th]) {
            halfbowl(x-th*2,y-th*2,z-th,r,th);
        }
    }
}

//roundedRect([15,20,30], 2, $fn=64);
r=15;
x=200;
y=170;
z=50;
th=3;

bowl(x,y,z,r,th);
/*
difference() {
    bowl(x,y,z,r,th);
    translate([th,th,th]) {
        bowl(x-th*2,y-th*2,z-th,r,th);
    }
}
*/  
/*
difference() {
    translate([r,r,r]) {
        miniround([x,y,z], r, $fn=64);
    }
    translate([0,0,z+r]) {
        cube([x+r*2,y+r*2,r]);
    }
}
*/