in=25.4;

difference() {
    cube([10,10,in/10*2*1.1]);
    translate([2,2,in/10*1.1]) {
        cube([8,8,in/10*1.1]);
    }
    translate([4,4,0]) {
        cube([6,6,in/10*1.1]);
    }
}