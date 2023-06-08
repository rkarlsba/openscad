length=100;
width=100;
height=15;
hole_depth = 10;
hole_diameter = 5;
holes=[8,8];
frame=10;

difference() {
    cube([length,width,height]);
    for (x = [0:holes[0]-1]) {
        translate([frame+holes[0]*x,frame,height-hole_depth]) {
            cylinder(h=hole_depth, d=hole_diameter);
        }
    }
}
