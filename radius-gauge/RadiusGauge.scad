// vim:ts=4:sw=4:sts=4:et:ai:si:tw=100:fdm=marker
// 
// This file uses vim folds. If you're in vim and don't see it all and don't know what to do, press
// zR (in or type ':help folds' (enter) for more info.
//
// Changelog {{{
//
// Edited to improve parameter access
// And to allow (somewhat) improved configurability without breaking things
// Improved box clearance/thickness parameterization
// Improved text scaling approach
// Fixed gage generation so that the parts are actually the specified length
// Added basic rendering controls
// Parts are crudely tiled in 2D, which might help arranging them in the slicer
//
// Extended a bit by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2026-01-04
//  - Added a vim modeline header (because!)
//  - Added step for port size progression, in case you only want, say, 2, 4, 6 etc
//  - Added texttypes emboss and holey in addition to deboss. I prefer holey, so that the text is
//    visible from both sides (albeit mirrored on one, but nothing to do with that.
//  - Added a sanity check in case people try to do something stupid.
//  - Added a bash script (with some good AI help) to create a bunch of gauges as separate files in
//    case that's wanted (I want that!).
//  - FIXME: I messed around with the placement of the box, it wasn't good on larger gauges. There
//    needs to be some sort of math to find a good place to put it.
//
// }}}
// Variables {{{

// Rendering settings
$fn = 0;
$fs = 0.5;
$fa = 3;

// Part size progression (fixed 1mm increment)
minsize = 38;
maxsize = 46;
step = 2;

// Part size
thickness = 1.6;
minlength = 55;                         // actual gage length will be no shorter than 2*radius

// Text params
textscale = 2.5;
textpow = 0.5;
textmaxheight = 10;
textdepth = 1;
texttype = "holey";                     // emboss, deboss or holey
fontfaceholey = "Stardos Stencil";

// box params
boxHeight = 35;
clearth = 0.15;                         // clearance on thickness (per side)
clearw = 0.3;                           // clearance on width (per side)
wtinner = 0.8;                          // thickness of dividers
wtouter = 1.2;                          // outer wall thickness

// rendering controls
tesswidth = 170;                        // controls how many parts are in a row
drawgages = true;
drawbox = false;
section = false;                        // for box troubleshooting

// }}}
// Sanity check {{{

assert(texttype == "emboss" || texttype == "deboss" || texttype == "holey",
    str("texttype \"", texttype, "\" is not supported."));

// }}}
// module createGauge(radius) {{{

module createGauge(radius) {
	length = max(minlength,2*radius);
	textheight = min(textscale*pow(radius,textpow),textmaxheight);
    render(convexity=4) {
        difference() {
            hull() {
                translate([-length/2+radius, 0, 0]) {
                    cylinder(h=thickness, r=radius);
                }
                translate([length/2-1, -radius, 0]) {
                    cube([1, radius*2, thickness]);
                }
            }
            translate([length/2, radius/2, -1]) {
                cylinder(h=thickness+2, r=radius);
            }
            translate([length/2-radius, radius/2, -1]) {
                cube([radius, radius, thickness+2]);
            }
            
            // text if debossed
            if (texttype == "deboss") {
                translate([-length/2+5, -textheight/2, thickness-textdepth])  {
                    linear_extrude(height=thickness)  {
                        text(str(radius), size=textheight);
                    }
                }
            } else if (texttype == "holey") {
                translate([-length/2+5, -textheight/2, 0])  {
                    linear_extrude(height=thickness)  {
                        text(str(radius), size=textheight, font=fontfaceholey);
                    }
                }
            }
        }
    }
    if (texttype == "emboss") {
        translate([-length/2+5, -textheight/2, thickness])  {
            linear_extrude(height=thickness/2)  {
                text(str(radius), size=textheight);
            }
        }
    }
}

// }}}
// module createBox() {{{

module createBox() {
	difference() {
		hull() {
			translate([0, wtouter, boxHeight/2]) {
				cube([minsize*2+2*clearw+2*wtouter, thickness+2*clearth+2*wtouter, boxHeight], center=true);
            }
			translate([0, wtouter+(ngages-1)*(thickness+wtinner+2*clearth), boxHeight/2]) {
				cube([maxsize*2+2*clearw+2*wtouter, thickness+2*clearth+2*wtouter, boxHeight], center=true);
            }
		}

		for (i=[0:ngages-1]) {
			translate([0, wtouter+i*(thickness+wtinner+2*clearth), 50+wtouter]) {
				cube([(minsize + i)*2+2*clearw, thickness+2*clearth, 100], center=true);
            }
		}
	}
}

// }}}
// Main code {{{

// derived
length = max(minlength,2*maxsize);
ngages = 1 + (maxsize-minsize);

if (drawgages) {
	// place gages in a printable pattern
	// it's not perfect, but at least it's better
	for (r = [minsize:step:maxsize]) {
		yraw = r + r*r - minsize*minsize;
		x = floor(yraw/tesswidth);
		y = yraw - tesswidth*x;
		translate([x*(length+3), y, 0]) {
			createGauge(r);
        }
	}
}

if (drawbox) {
	translate([-65, 20, 0]) {
        rotate([0,0,180]) {
            if (section) {
                difference() {
                    createBox();
                    translate([0,-250,-250])
                        cube([500,500,500]);
                }
            } else {
                createBox();
            }
        }
    }
}

// }}}
