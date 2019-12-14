$fn = 128;

difference() {
    cube(5,5,5, center=true);

    union() {
//        cube([2,2,10], center = true);
//        rotate(a=45) {
  //          cube([2,2,10], center = true);
    //    }
        cylinder(r=1,h=10);
    }
}


/*
 triangle_points =[[0,0],[100,0],[0,100],[10,10],[80,10],[10,80]];
 triangle_paths =[[0,1,2],[3,4,5]];
 polygon(triangle_points,triangle_paths,10);
 */