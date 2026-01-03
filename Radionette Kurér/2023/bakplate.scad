include <ymse.scad>

w=87;
h=73;
t=2;
r=1.5;
R=2.5;

linear_extrude(t) {
    difference() {
        roundedsquare([w,h], r, $fn=64);
        for (y=[8:11.5:73]) {
            for (x=[8:12:80]) {
                translate([x,y]) {
                    circle(r=R, $fn=64);
                }
            }
        }
    }
}
