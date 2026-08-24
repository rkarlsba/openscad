use <ymse.scad>

$fn = $preview ? 8 : 32;

dirk = [45,3.5,1.5];
handtak = 10;
tykkelse=.8;

linear_extrude(height=tykkelse) {
    difference() {
        union() {
            translate([0,-dirk[1]/2,0]) {
                roundedsquare(dirk, 1.5);
            }
            translate([handtak/2,0,0]) {
                scale([1, .5, 0]) {
                    circle(10);
                }
            }
        }
        for (x = [18:4.5:48]) {
            translate([x,dirk[1]/2]) {
                scale([1,.7]) {
                    circle(2.5);
                }
            }
        }
        circle(2);
    }
}