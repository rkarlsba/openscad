$fn=50;

module miniround(size, radius) {
    x = size[0]-radius/2;
    y = size[1]-radius/2;

    minkowski()
    {
        cube(size=[x,y,size[2]]);
        cylinder(r=radius);
        // Using a sphere is possible, but will kill performance
        //sphere(r=radius);
    }
}

//cube([76.2,55.8,1.6]);
height=1.6;
//width=76.2;
width=138.3;
//depth=55.8;
depth=55.9;

//projection(cut = true) {
    difference() {
        //miniround([width,depth],height);
        cube([width,depth,height]);
        translate([3.5,3.5,0]) {
            cylinder(h=height*2,d=3);
        }
        translate([width-3.5,depth-3.5]) {
            cylinder(h=height*2,d=3);
        }
        translate([3.5,depth-3.5]) {
            cylinder(h=height*2,d=3);
        }
        translate([width-3.5,3.5]) {
            cylinder(h=height*2,d=3);
        }
    }
//}