$fn = $preview ? 20 : 64;

// eggefat
// Roy Sigurd Karlsbakk <roy@karlsbakk.net>
// License: GPLv3 https://www.gnu.org/licenses/gpl-3.0.en.html

// not yet finished

// globals
fatradius=50;
num=8;

// modules
module egg(radius = 20) {
    rotate([0,-20,0]) {
        scale([1.5,1.1]) {
            sphere(radius);
        }
    }
}

module ring() {
    for (i=[1:num])  {
        translate([fatradius*cos(i*(360/num)),-fatradius*sin(i*(360/num)),0]) {
            rotate(-i*45) {
                egg(20);
            }
        }
    }
}

// main code
ring();
rotate(22.5) {
    scale([.7,.7,.7]) {
        translate([0,0,-10]) {
            ring();
        }
    }
}