include <ymse.scad>

w=87;
h=73;
t=2;
r=1.5;

linear_extrude(t) {
    roundedsquare([w,h], r, $fn=64);
}
