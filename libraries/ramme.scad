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

linear_extrude(1) {
    difference() {
        roundedsquare([w+brem*2,h+brem*2], r, $fn=64);
        translate([brem*2,brem*2])
            roundedsquare([w-brem*2,h-brem*2], r, $fn=64);
    }
}
