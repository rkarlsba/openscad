$fn=32;

cyl=4;

// lang X
cube([34+cyl,5,2]);
// nedoverstart 
translate([0,0,-5])
    cube([2,5,5]);
// nedoverslutt
translate([34,0,-8]) {
    cube([cyl,5,8]);
    rotate([0,90,0]) {
        translate([4,2.5,0]) {
            difference() {
                cylinder(d=12,h=cyl);
                cylinder(d=8,h=cyl);
                translate([-4,-6,-0]) {
                    cube([10,6,cyl]);
                }
                translate([3.5,-5,0]) {
                    cube([6,11,cyl]);
                }
            }
        }
    }
}
// venstre
translate([18,-20.5,0]) {
    cube([5,20.5,2]);
    //nedovervenstre
    translate([0,0,-5]) {
        cube([5,2,5]);
    }
}
