ssize=30;
height=0.4; // single layer

linear_extrude(height) {
    translate([-ssize/2,-ssize/2]) square([ssize,ssize]);
    translate([ssize*1.5,ssize*1.5]) square([ssize,ssize]);
    translate([-ssize*2.5,ssize*1.5]) square([ssize,ssize]);
    translate([-ssize*2.5,-ssize*2.5]) square([ssize,ssize]);
    translate([ssize*1.5,-ssize*2.5]) square([ssize,ssize]);
}