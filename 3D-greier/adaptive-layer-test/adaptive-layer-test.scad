d=50;

difference() {
    sphere(d=d, $fn=128);
    translate([-d/2,-d/2,-d/2]) {
        cube([d,d,d/2]);
    }
}