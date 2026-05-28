// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

height=10;
d_inner = 4.5;
d_outer = 15.8;

render(convexity=10) {
    difference() {
        cylinder(d=d_outer, h=height);
        cylinder(d=d_inner, h=height);
    }
}
