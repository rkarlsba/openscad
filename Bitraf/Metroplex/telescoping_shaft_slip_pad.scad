$fn = $preview ? 16 : 64;

// Variables
x = 14;
y = 7;
z = .4;
flap = z*2;
tube_thickness = .5;
hole_size = 3;

module xor() {
    difference() {
        for(i = [0 : $children - 1]) {
            children(i);
        }
        intersection_for (i = [0: $children -1]) {
            children(i);
        }
    }                          
} 

module pad() {
    difference() {
        union() {
            cube([x+flap,y,z]);
        }
        union() {
            translate([x,y,0]) {
                rotate([90,0,0]) {
                    linear_extrude(y) {
                        polygon(
                            points = [[0, z], [flap, z], [flap, 0]],
                            paths = [[0,1,2]],
                            convexity = 10
                        );
                    }
                }
            }
        }
    }
    translate([hole_size/2,y/2,z]) {
        cylinder(h=tube_thickness, d=hole_size);
    }
}

sleeve_inner = 
module sleeve() {
    
}
/*
pad();

translate([0,0,0]) {
    rotate([270,0,0]) {
        mirror([0,0,1]) {
            pad();
        }
    }
    translate([0,y,0]) {
        rotate([270,0,0]) {
            mirror([0,0,0]) {
                pad();
            }
        }
    }
    translate([0,y,-y]) {
        rotate([0,180,180]) {
            pad();
        }
    }
}
*/