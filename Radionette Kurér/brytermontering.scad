// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Trenger jeg denne?
use <ymse.scad>
use </Users/roysk/src/git/rkarlsba/openscad/USB/micro/breakout/usb-micro-breakout-box.scad>

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Fuckup
bug = $preview ? .1 : 0;

// Variables
airhole_r = 12.80;
bryter = [10.8, 5.8];
thickness = 2.5;
lip_width  = 2;
lip_thickness = .6;
tolerance = .5;

// ext_top_size()
// ext_bottom_size()
// ext_size()

// Plugg
module plug() {
    linear_extrude(lip_thickness) {
        circle(d=(airhole_r*2)-tolerance+lip_width);
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
            translate(-bryter/2)  {
                switch();
            }
            translate([6,7,0]) {
                linear_extrude(.4) {
                    mirror([1,0,0]) {
                        text(text=str(bryter), size=2);
                        translate([2,-3,0]) {
                            text(text=str("t = ", tolerance), size=2);
                        }
                    }
                }
            }
        }
    }
}

// Køyr!
main();
