// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Trenger jeg denne?
include <ymse.scad>

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Fuckup
bug = $preview ? .1 : 0;

// Variables
airhole_r = 12.5;
bryter = [10.7, 5.8];
thickness = 2.5;
lip_width  = 2;
lip_thickness = .6;

// Plugg
module plug() {
    linear_extrude(lip_thickness) {
        circle(airhole_r-.25+lip_width);
    }
    translate([0, 0, lip_thickness]) {
        linear_extrude(thickness) {
            circle(airhole_r-.25);
        }
    }
}

// Bryter
module switch() {
    linear_extrude(lip_thickness+thickness) {
        square(bryter);
    }
}

// Hovedkoden
module main() {
    render(convexity=4) {
        difference() {
            plug();
            translate(-bryter/2) 
            switch();
        }
    }
}

// Køyr!
main();
