$fn = 256;

x = 51;
y = 51;
holepos = [x/2,43];
holerad = 5;
height = 3.5;

linear_extrude(height) {
    difference() {
        square([51,51]);
        translate(holepos) {
            circle(r=holerad);
        }
    }
}
