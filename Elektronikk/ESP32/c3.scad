// Copyright 2025, Jeroen van Grondelle
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

// Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// Changes by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in 2026-01:
//
// - Added resolution ($fn etc)
// - Added render() to avoid the openscad bug that shows fuzzy edges in case difference() is exact
// - Added new thickcable_case
// - Added "headers" argument to cases to add space in case haders are soldered on. Headers are given in their height, typially 1.8mm
// - Perhaps presets should be made for different boards, like these?
//    c3_mini_size = [18, 23.2, 18.5]
//    c6_mini_size = [18, 28.3, 18.5]
//

include <BOSL2/std.scad>;
include <BOSL2/rounding.scad>
use <hex-grid.scad>

// Resolution
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// corner definition
cut = 1.5;
k=.7;

delta=.15;

module case(width, length, height, headers) {
    difference() {
        linear_extrude(height=height+headers) {
            polygon(round_corners(rect([width+4,length+4]),  method="smooth", k=k, cut=cut, $fn=96));
        }

        up(1) cuboid([width+delta,length+delta,height+headers], anchor=BOTTOM);
        up(2+headers) fwd(length/2) cuboid($fn=20,[9.5, 20, 3.9], rounding=2*k, anchor=BOTTOM); // Usb-c
        up(height-1.5+headers) prismoid(size2=[width+delta,length+delta], size1=[width+delta +.5,length+delta+.5], h=1.5, anchor=BOTTOM);
        up(height-1+headers) fwd(-1* length/2) cuboid([4,4, 4], anchor=BOTTOM); // Nook
    }
    if (headers > 0) up(1) cuboid([width-5+delta,length+delta,headers], anchor=BOTTOM, rounding=k);
}

module lid(width, length) { 
    union() {
         linear_extrude(height=1.5) {
            polygon(round_corners(rect([width+4,length+4]),  method="smooth", k=k, cut=cut, $fn=96));
         }
         
         up(1.4) cuboid([width,length,1.6], anchor=BOTTOM);
         up(1.5) prismoid(size1=[width/1.5,length], size2=[width/1.5,length+.7], h=1.5, anchor=BOTTOM);
         up(1.5) prismoid(size1=[width,length/1.5], size2=[width+.7,length/1.5], h=1.5, anchor=BOTTOM);
    }
}

module lid_hex(width, length) {
    difference() {
        lid(width, length);
        down(3) cuboid($fn=30, [width-2,length-2,10], anchor=BOTTOM);
    }
    intersection() {
        up(0.5) rotate([0,0, 20]) create_grid(size=[2*width,2.1*length,1],SW=4,wall=.8);
        down(3) cuboid($fn=30, [width-2+delta, length-2+delta, 10], rounding=k, anchor=BOTTOM);
    }
}

module cable_case(width, length, height)
{
    difference() {
        case(width, length, height);
        up(height-5.5) fwd(-.5*length-1) cuboid([1.5, 14, 5], rounding=k, anchor=BOTTOM);
    }
}

module thickcable_case(width, length, height, headers=0)
{
    difference() {
        case(width, length, height, headers);
        up(height-7.5) fwd(-.5*length-1) cuboid([6, 14, 8.5+headers], rounding=k, anchor=BOTTOM);
    }
}


// EXAMPLES
//
module examples() {
    // Add render() here to avoid the openscad bug that showing the top fuzzy in preview
    render(convexity=4) {
        left(125) thickcable_case(18, 28.3, 18.5, headers=1.8); // C6 with headers soldered on it
        left(100) thickcable_case(18, 28.3, 18.5); // C6
        left(75) case(18, 23.2, 18.5);
        left(50) cable_case(18, 23.2, 13.5);
        left(25) case(18, 23.2, 8.5);
        cable_case(18, 23.2, 8.5);

        right(25) lid(18, 23.2);
        right(50) lid_hex(18, 23.2);
    }
}

// My parts
render(convexity=4) {
    thickcable_case(18, 28.3, 35, headers=1.8); // C6
    right(25) lid_hex(18, 28.3);
}

