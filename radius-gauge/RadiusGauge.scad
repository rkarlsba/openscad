// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// edited to improve parameter access
// and to allow (somewhat) improved configurability without breaking things
// improved box clearance/thickness parameterization
// improved text scaling approach
// fixed gage generation so that the parts are actually the specified length
// added basic rendering controls
// parts are crudely tiled in 2D, which might help arranging them in the slicer

// part size progression (fixed 1mm increment)
minsize = 38;
maxsize = 46;
step = 2;

// part size
thickness = 1.6;
minlength = 55; // actual gage length will be no shorter than 2*radius

// text params
textscale = 2.5;
textpow = 0.5;
textmaxheight = 10;
textdepth = 1;
texttype = "emboss"; // emboss or deboss

// box params
boxHeight = 35;
clearth = 0.15; // clearance on thickness (per side)
clearw = 0.3; // clearance on width (per side)
wtinner = 0.8; // thickness of dividers
wtouter = 1.2; // outer wall thickness

// rendering controls
tesswidth = 170; // controls how many parts are in a row
drawgages = true;
drawbox = false;
section = false; // for box troubleshooting

$fn = 0;
$fs = 0.5;
$fa = 3;

// Reality check

assert(texttype == "emboss" || texttype == "deboss", str("texttype \"", texttype, "\" is not supported."));

// ////////////////////////////////////////////////////////////////////

module createGauge(radius) {
	length = max(minlength,2*radius);
	textheight = min(textscale*pow(radius,textpow),textmaxheight);
	difference() {
		hull() {
			translate([-length/2+radius, 0, 0]) 
				cylinder(h=thickness, r=radius);
			translate([length/2-1, -radius, 0]) 
				cube([1, radius*2, thickness]);
		}
		translate([length/2, radius/2, -1]) 
			cylinder(h=thickness+2, r=radius);
		translate([length/2-radius, radius/2, -1]) 
			cube([radius, radius, thickness+2]);
        
		// text if debossed
        if (texttype == "deboss") {
            translate([-length/2+5, -textheight/2, thickness-textdepth])  {
                linear_extrude(height=thickness)  {
                    text(str(radius), size=textheight);
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

module createBox() {
	difference() {
		hull() {
			translate([0, wtouter, boxHeight/2]) 
				cube([minsize*2+2*clearw+2*wtouter, thickness+2*clearth+2*wtouter, boxHeight], center=true);
			translate([0, wtouter+(ngages-1)*(thickness+wtinner+2*clearth), boxHeight/2]) 
				cube([maxsize*2+2*clearw+2*wtouter, thickness+2*clearth+2*wtouter, boxHeight], center=true);
		}

		for (i=[0:ngages-1]) {
			translate([0, wtouter+i*(thickness+wtinner+2*clearth), 50+wtouter]) 
				cube([(minsize + i)*2+2*clearw, thickness+2*clearth, 100], center=true);
		}
	}
}

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
    rotate([0,0,180])
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
