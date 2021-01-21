include <honeycomb/honeycomb.scad>

jall = $preview ? .5 : 0;
x=90;
y=39;
z=20;
walls=1.5;

kabelsprekk=[y/2,walls,5];

difference() {
    cube([x,y,z]);
    translate([walls*2,walls,walls]) {
        cube([x-walls*4,y-walls*2,z-walls+jall]);
    }
    translate([walls,-jall/2,z-walls*2]) {
        cube([x-walls*2,walls+jall,walls*2+jall]);
    }
    translate([walls,walls,z-walls*2]) {
        hull() {
            translate([walls*2,0,0]) {
                cube([x-walls*4,y-walls*2+jall,walls/4*5+jall]);
            }
            cube([x-walls*4,y-walls*2+jall,walls+jall]);
        }
    }
    translate([walls*5,y-walls,z/2-walls]) {
        cube(kabelsprekk);
    }
}

    translate([10,y/2-kabelsprekk[1]/2,-jall/2]) {
//        cube(kabelsprekk);
    }

translate([x-53-walls*4,0,0]) {
    rotate([90,0,90])
        linear_extrude(walls)
            honeycomb(y, z-walls*2, 8, walls);
}
