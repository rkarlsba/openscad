// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

radius = 20;

module stjerne(r, h=0) {
    for (i = [0:180:180]) {
        rotate([0,0,i]) {
            circle(r=r, $fn=3);
        }
    }
}

stjerne(radius);
