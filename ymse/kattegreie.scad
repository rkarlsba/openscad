use <ymse.scad>

$fn = $preview ? 16 : 64;

x = 150;
y = x;
z = 40;
hjorne = 15;
tykkelse = 4;

difference() {
    linear_extrude(z) {
        roundedsquare([x,y], hjorne);
    }
    
    translate([tykkelse,tykkelse,tykkelse]) {
        linear_extrude(z-tykkelse) {
            roundedsquare([x-tykkelse*2,y-tykkelse*2], hjorne);
        }
    }
}