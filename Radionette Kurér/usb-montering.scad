include <ymse.scad>

w=73;
h=32;
t=4;
tb=1;
kt=1.5;
br=2;
r=1.5;
uw=8;
uh=3;
ur=0.35;
ufw=16;
ufd=11.5;
brem=3;

difference() {
    linear_extrude(t) {
        difference() {
            roundedsquare([w,h], r, $fn=64);
            translate([w/2-uw/2, h/2-uh/2]) {
                roundedsquare([uw, uh], ur, $fn=64);
            }
        }
    }
    translate([w/2-ufw/2, h/2-uh, t-uh/2]) {
        cube([ufw, uh/2, uh/2]);
    }
}

translate([w/2-ufw/2, h/2-uh*1.5, t]) {
    cube([ufw, uh/2, ufd]);
    translate([0,-uh/2,0]) {
        cube([ufw, uh, uh/2]);
    }
}
