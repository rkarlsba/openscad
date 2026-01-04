// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Ferdigskrivi
include <ymse.scad>

// Integrere med usb-micro-breakout-box.scad
use </Users/roysk/src/git/rkarlsba/openscad/USB/micro/breakout/usb-micro-breakout-box.scad>

// Render settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Variables
airhole_r = 12.5;
bryter = [10.7, 5.8];
thickness = 2.5;
lip_width  = 2;
lip_thickness = .6;

debug = false;

// Debug output
if (debug) {
    echo(str("ext_top_size is ", ext_top_size()));
    echo(str("ext_bottom_size is ", ext_bottom_size()));
    echo(str("ext_size is ", ext_size()));
}

// Plugg
// FIXME hardkoda -.25?
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

// USB Micro plug (female)
module usbmicromodule(tolerance = 0) {
    render(convexity=4) {
        tol = str(tolerance);
        linear_extrude(lip_thickness+thickness) {
            square([ext_size()[1]+tolerance, ext_size()[2]+tolerance]);
            if (debug) {
                translate([8-len(tol)*1.4,-6.5,0]) {
                    text(text=tol, font="Stardos Stencil", size=5);
                }
            }
        }
    }
}

// Hovedkoden
module main() {
    render(convexity=4) {
        difference() {
            plug();
            translate(-[ext_size()[1], ext_size()[2]]/2) {
                usbmicromodule(0.15);
            }
        }
    }
}

// Køyr!
main();
