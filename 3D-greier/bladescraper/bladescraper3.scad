/*
Retracting razor blade scraper v3
by Alex Matulich
October 2024

On Printables: https://www.printables.com/model/129116
On Thingiverse: https://www.thingiverse.com/thing:4555029

V3: Made blade stick out 1 mm more, reduced thickness of handle to facilitate shallower scraping angle.

This is a retracting-blade scraper tool for a standard double-edge shaving razor blade. The tool can be used to scrape burnt matter from a ceramic stovetop, or remove tree sap deposits from automobile windshields. It could be used as an aquarium scraper too, although the handle is short.

The two halves of the tool slide against each other and snap into three positions:

* Sliding the top half all the way back exposes the blade for use.

* The middle position retracts the blade under the top half. In this position the hole on the handle end aligns in each half so the tool can be stored by hanging on a nail or peg.

* Sliding the top half all the way forward allows the two halves to separate, for changing the blade.

To use this script: Adjust the customizable settings as desired, set the "display" parameter to "lower" or "upper" to display each part, and save each part to a separate STL file.

Printing advice:

Both halves may be printed without supports, at 0.20mm layer thickness, standard 0.4mm nozzle.

PrusaSlicer / Slic3r print settings:
* Layers and perimeters:
    * Perimeters = 3
    * Detect bridging permimeters = true
* Infill:
    * Fill density = 25%
    * Top fill pattern = Rectilinear
    * Bottom fill pattern = Octagram Spiral (it looks nice)
    * Fill angle = 90 (this should fill along length of top surface)
    * Bridging angle = 180 (needed to correct bridge direction in grips)
* Advanced:
    * Elephant foot compensation = 0

It is a good idea to sand or file off any burrs left on the top layer of each part, or else the parts won't slide. Sliding operation may be rough at first but smooths out with use.
*/

// ---------- customizable settings ----------

// what to display: assembly=all parts together, lower=lower half, upper=upper half
display = "printall"; //[printall, assembly, lower, upper, animate]
// for "animate" you must select View > Animate from the menu.

// if display=="assembly", which step to display (0=exploded, 1=unexploded, 2=blade retracted, 3=blade exposed
assemblystep = 0; //[0,1,2,3]

// degrees from horizontal for overhang angle of front edge; if less than 45, your slicer must be set to detect overhangs.
front_angle = 38; // We can violate the 45-degree rule a little

// handle width (should be at least 20mm)
handlewid = 24; // width of handle (recommended 20-25)

// handle length from back of blade holder part to the ring for hanging hole
handlelen = 70; // recommend at least 60

// amount of blade in mm to expose (3-5)
exposed_edge = 5;

// blade overlap of cover when blade retracted
blade_overlap = 2;

// thickness of each part (recommended 3-6)
thickness = 3.5;

// ---------- end of customizable settings ----------

module dummy() {} // force end of customizer

// razor blade dimensions

blen = 43;      // overall blade length
bwid = 22;      // overall blade width
binwid = 13;    // blade inner width at longest length
elen = 37;      // length of sharpened edge
holepos = 12.7; // hole distance from center of blade
holedia = 5;    // blade hole diameter
bthick = 0.1;   // blade thickness
hblen = blen/2; // half blade length
helen = elen/2; // half edge length

// snap lock mechanism

snapstyle = 1;   // 0=no snap mechanism, 1=version 1
lockpegdia = 6;  // snapstyle=1 diagonal diameter of square locking pin
minarmthick = 2; // snapstyle=1 minimum snap lock arm thickness

// misc

dclear = 0.2;   // multiples of this clearance are used for holes and slots
bbevel = front_angle; // blade holder bevel angle at edge
cutoverhang = 40;
gripdepth = 0.6; // depth of grip grooves

// calculated parameters

pegdia = holedia-dclear; // peg diameter
pegr = pegdia/2;        // peg radius
pegx = bwid/2-exposed_edge; // x position of blade peg
pegslotdepth = 1.3;     // depth of slots carved into sliding pegs on blade holder
hpegdia = pegdia+3;     // handle peg diameter
hpegslotdepth = 1.8;    // depth of slots carved into sliding peg on handle
slidelen = 2*(exposed_edge+blade_overlap); // sliding distance

// blade holder (not handle) values

bhlen = blen+4;             // long dimension
bhwid = bwid+exposed_edge;  // short dimension

// other handle values

hpegx = bhwid+handlelen-1; // x position of handle peg
rshoulder = 0.5*(bhlen-pegdia-handlewid); // shoulder radius cutout for handle
lockdist = slidelen/2; // distance between lock points
gripwid = min(handlewid, 2*holepos-pegdia)-4; // width of handle grip grooves
snapx = (hpegx-slidelen + bwid+rshoulder)*0.53; // x position of center of snap assembly
// snap lock
lpr = 0.5*lockpegdia; // locking pin diagonal radius
deflection = min(1.2, max(1,0.5*lpr)); // allowable deflection for snap arm
snaparmlen = 10*deflection; // length of snap arm
maxarmthick = 1.9*minarmthick; // approx thickness at snap arm root

// ---------- display the parts or assembly ----------

if (display == "animate") {
    step = floor($t*9+0.5);
    zxp = 30; // explode distance
    zup = step<=1 || step>=8 ? zxp : 0;
    upperxpos = [-2*lockdist, -2*lockdist, -2*lockdist, -lockdist, 0,0, -lockdist, -2*lockdist, -2*lockdist];
    xup = upperxpos[step];
    lowerbladeholder();
    translate([0,0,step>0?0:zxp/2]) blade();
    translate([xup,0,zup]) rotate([180,0,0]) upperbladeholder();

} else if (display == "printall") {
    translate([-(handlelen+bhlen)/2,0.5*blen,thickness]) lowerbladeholder();
    translate([(handlelen+bhlen)/2,-0.5*blen,thickness]) rotate([0,0,180]) upperbladeholder();

} else if (display == "assembly") {
    zxp = 30; // explode distance
    zup = assemblystep == 0 ? zxp : 0;
    upperxpos = [-2*lockdist, -2*lockdist, -lockdist, 0, -lockdist, -2*lockdist];
    xup = upperxpos[assemblystep];
    lowerbladeholder();
    translate([0,0,assemblystep>0?0:zxp/2]) blade();
    translate([xup,0,zup]) rotate([180,0,0]) upperbladeholder();
    
} else if (display == "lower") {
    translate([0,0,thickness]) lowerbladeholder();

} else if (display == "upper") {
    translate([0,0,thickness]) upperbladeholder();

} else if (display == "snaptest") { // test print of snap fitting
    translate([-lpr-maxarmthick-8,0,0]) union() {
        translate([0,0,thickness/2]) difference() {
            cube([2*(snaparmlen+lpr)+2, 2*(lpr+maxarmthick)+4, thickness], center=true);
            cube([2*(snaparmlen+lpr)-1, 2*(lpr+maxarmthick)+1, thickness+2], center=true);
        }
        translate([0,0,thickness]) snaparm();
    }
    translate([lpr+maxarmthick+8,0,0]) union() {
        difference() {
            translate([0,0,0.3]) cube([2*(snaparmlen+lpr), 2*(lpr+maxarmthick)+6, 0.6], center=true);
            translate([lpr,lpr,-1]) cube([snaparmlen*0.8, maxarmthick+1, 2]);
            mirror([1,0,0]) translate([lpr,lpr,-1]) cube([snaparmlen*0.8, maxarmthick+1, 2]);
            mirror([0,1,0]) translate([lpr,lpr,-1]) cube([snaparmlen*0.8, maxarmthick+1, 2]);
            mirror([1,0,0]) mirror([0,1,0]) translate([lpr,lpr,-1]) cube([snaparmlen*0.8, maxarmthick+1, 2]);
        }
        translate([0,0,1]) lockpeg(lockpegdia);
        translate([-snaparmlen-lpr,lpr+maxarmthick+2+dclear,0]) cube([2*(snaparmlen+lpr), 0.8, thickness/2]);
        translate([-snaparmlen-lpr,-lpr-maxarmthick-2.8-dclear,0]) cube([2*(snaparmlen+lpr), 0.8, thickness/2]);
        }
}

// ---------- modules ----------

// razor blade mock-up
module blade() {
    translate([pegx,0,-0.1]) color("silver") difference() {
        union() {
            cube([bwid,elen,bthick], center=true);
            cube([binwid,blen,bthick], center=true);
        }
        cylinder(1, d=5, center=true, $fn=16);
        translate([0,holepos,0]) cylinder(1, d=holedia, center=true, $fn=16);
        translate([0,-holepos,0]) cylinder(1, d=holedia, center=true, $fn=16);
        cube([2,37,1], center=true);
    }
}

// blank half of the tool, without the pegs and grooves and other details
module bladeholderblank(upper=true) {
    bhpolygon = [ // cross section of blade holder
        [0,0], [bhwid-pegr,0], [bhwid-pegr,-thickness], [(thickness-0.8)/tan(bbevel),-thickness], [0,-0.8]
    ];
    difference() {
        union() {
            //blade part
            translate([0,bhlen/2,0]) rotate([90,0,0]) linear_extrude(bhlen) polygon(points=bhpolygon);
            bladeholderback();
            //handle with hanging hole
            difference() {
                hull() {
                    translate([bhwid+0.1, -handlewid/2, -thickness]) cube([rshoulder, handlewid, thickness]);
                    translate([upper?lockdist:0,0,0]) handle_hole_ext();
                }
                translate([upper?lockdist:0,0,0]) handle_hole();
            }
            // transition between main blade holder and handle
            difference() {
                translate([bhwid-0.001,-(bhlen-pegdia)/2, -thickness]) cube([rshoulder, bhlen-pegdia, thickness]);
                translate([bhwid+rshoulder, (bhlen-pegdia)/2, -1-thickness]) cylinder(thickness+2, r=rshoulder, $fn=48);
                translate([bhwid+rshoulder, -(bhlen-pegdia)/2, -1-thickness]) cylinder(thickness+2, r=rshoulder, $fn=48);
            }
        }
        // carve grip grooves into the part
        gw = gripwid/2-gripdepth;
        for (x=[pegx:5:40]) {
            //translate([x, -0.5*gripwid, -thickness-gripdepth]) cube([3,gripwid,1]);
            hull() {
                translate([x,-gw,-thickness]) rotate([0,90,0]) cylinder(3, r=gripdepth, $fn=8);
                translate([x,gw,-thickness]) rotate([0,90,0]) cylinder(3, r=gripdepth, $fn=8);
            }
        }
    }
}

// lower half of tool with all the details
module lowerbladeholder() {
    difference() {
        union() {
            difference() {
                bladeholderblank(false);
                translate([pegx,0,0.5-0.2]) cube([bwid+2*dclear, blen+2*dclear, 1], center=true); // blade impression
                translate([hpegx-slidelen,0,0]) upperslot(hpegdia); // handle slot
                if (snapstyle == 1) {
                    translate([snapx,0,-(thickness+2)/2+1]) cube([2*(snaparmlen+lpr)-1, 2*(lpr+maxarmthick)+1, thickness+2], center=true); // snap mechanism hole
                } if (snapstyle == 2) {
                }
            }
            // blade holder pegs
            translate([pegx,holepos,0]) peg();
            translate([pegx,0,0]) peg(sdepth=0, ht=thickness*0.4);
            translate([pegx,-holepos,0]) peg();
            // handle slot rails
            translate([hpegx-slidelen,0,0]) rotate([180,0,0]) pegslotrails(hpegslotdepth-dclear,hpegdia);
            // snap fitting
            if (snapstyle == 1) {
                translate([snapx,0,0]) snaparm();
            } else if (snapstyle == 2) {
            }
        }
        translate([hpegx-slidelen,0,-thickness-1]) cylinder(thickness+2, d=hpegdia+4*dclear, $fn=32);        
    }
}

// upper half of tool with all the details
module upperbladeholder() {
    difference() {
        union() {
            difference() {
                bladeholderblank();
                translate([pegx,holepos,0]) upperslot(pegdia);
                translate([pegx,0,0]) upperslot(pegdia+dclear, depth=0.5*thickness);
                translate([pegx,-holepos,0]) upperslot(pegdia);
            }
            // handle peg
            translate([hpegx,0,0]) peg(hpegdia,hpegslotdepth);
            // blade holder slot rails
            translate([pegx,holepos,0]) rotate([180,0,0]) pegslotrails(pegslotdepth-dclear);
            //translate([pegx,0,0]) rotate([180,0,0]) pegslotrails(pegslotdepth-dclear);
            translate([pegx,-holepos,0]) rotate([180,0,0]) pegslotrails(pegslotdepth-dclear);
            // snap peg
            if (snapstyle == 1) {
                translate([snapx+lockdist,0,0]) lockpeg(lockpegdia);
            } else if (snapstyle == 2) {
            }
        }
        // slot entrance holes
        translate([pegx+slidelen,holepos,-thickness-1]) cylinder(thickness+2, d=pegdia+4*dclear, $fn=32);        
        translate([pegx+slidelen,-holepos,-thickness-1]) cylinder(thickness+2, d=pegdia+4*dclear, $fn=32);        
    }
}

// slot shape cutout is an oval to accommodate pegs
module upperslot(dia=pegdia, depth=thickness+1) {
    hull() {
        translate([0,0,-depth]) cylinder(depth+1, d=dia+dclear, $fn=32);
        translate([slidelen,0,-depth]) cylinder(depth+1, d=dia+dclear, $fn=32);
    }
}

// rounded back corners of blade holder section
module bladeholderback() {
    hull() {
        translate([bhwid-pegr,(bhlen-pegdia)/2,-thickness]) cylinder(thickness, d=pegdia, $fn=32);
        translate([bhwid-pegr,-(bhlen-pegdia)/2,-thickness]) cylinder(thickness, d=pegdia, $fn=32);
    }
}

// razor blade retaining / sliding pegs
module peg(dia=pegdia,sdepth=pegslotdepth, ht=thickness) {
    slotw = dia - 2.6; // width of slot between slot rails
    difference() {
        union() {
            translate([0,0,-1]) cylinder(ht+0.4, d=dia, $fn=32);
            translate([0,0,ht+0.4-1.001]) cylinder(0.6, d1=dia, d2=dia-1.2, $fn=32);
        }
        if (sdepth>0) pegslotrails(sdepth, dia);
    }
}

// rails on which pegs slide; also used as cutouts for pegs
module pegslotrails(sdepth, dia=pegdia) {
    r = dia/2;
    y = (thickness-1)/2/tan(cutoverhang);
    pts1 = [ [1.8,0], [2,0], [thickness-0.2,y], [thickness-0.2,y+1], [0,y+1], [0,y] ];
    pts2 = [ [1.8,0], [2,0], [thickness-0.2,-y], [thickness-0.2,-y-1], [0,-y-1], [0,-y] ];
    union() {
        translate([slidelen+r,dia/2-sdepth,0]) rotate([0,-90,0]) linear_extrude(slidelen+dia, convexity=4) polygon(points=pts1);
        translate([slidelen+r,sdepth-dia/2,0]) rotate([0,-90,0]) linear_extrude(slidelen+dia, convexity=4) polygon(points=pts2);
    }
}

/*
// experimental extension for 5mm rod to make aquarium scraper
module handle_ext() {
    translate([bhwid+handlelen+0.499, 0, -thickness]) {
        difference() {
            hull() {
                translate([0,-handlewid/2,0]) cube([1, handlewid, 2*thickness]);
                translate([10,0,5]) rotate([0,90,0]) rotate([0,0,22.5]) cylinder(20, d=10, $fn=8);
            }
            translate([7,0,5]) rotate([0,90,0]) cylinder(25, d=5, $fn=48);
        }
    }
}
*/

// handle extension to accommodate hanger hole; this is basically a toroid stuck onto the end of the handle, all toe be wrapped with a convex hull
module handle_hole_ext() {
    octdadj = 1/cos(180/8);
    translate([bhwid+handlelen+handlewid/2,0,0]) {
        difference() {
            rotate([0,0,-90]) rotate_extrude(angle=180, convexity=4, $fn=32) translate([handlewid/2-thickness,0,0]) rotate([0,0,22.5]) circle(r=thickness*octdadj, $fn=8);
            translate([0,0,thickness+1]) cube([handlewid+2,handlewid+2,2*(thickness+1)], center=true);
        }
    }
}

// object to subtract from handle to form a beveled hole
module handle_hole() {
    r = thickness/sin(90-cutoverhang);
    handleholerad = 4;
    pts = [
        [0,r],
        for(a=[170:5:260]) [handleholerad+r+r*cos(a),r*sin(a)],
        [0,-r]
    ];
    translate([bhwid+handlelen+handlewid/2,0,0]) {
        rotate_extrude(angle=360, convexity=8, $fn=32) polygon(points=pts);
    }
}

// snap arm assembly
module snaparm() {
    snaparmpts = [ // complicated polygon for snap arm and enclosure
        [0,0], [0,-lpr], [snaparmlen,-lpr], [snaparmlen,0],
        [lockdist+1,0], [lockdist+1, lpr+1+deflection+2*dclear], [lpr/2,minarmthick+lpr+deflection+2*dclear], [-snaparmlen-lpr, lpr+maxarmthick+0.5], [-snaparmlen-lpr,lpr+maxarmthick+1], [snaparmlen+lpr,lpr+maxarmthick+1],
        [snaparmlen+lpr,-lpr-maxarmthick], [-lpr/2,-lpr-minarmthick],
        [-lockdist/2, -lpr-1], [-lockdist,-lpr-1],
        [-lockdist,-lpr-dclear], [-lockdist,0]
    ];
    color("yellow") translate([0,0,-thickness]) difference() {
        union() {
            linear_extrude(thickness, convexity=6) polygon(points=snaparmpts);
            rotate([0,0,180]) linear_extrude(thickness, convexity=6) polygon(points=snaparmpts);
        }
        lockpeg(lockpegdia+dclear/2,thickness+1);
        translate([-lockdist,0,0]) lockpeg(lockpegdia+3*dclear,thickness+1,1.6);
        translate([lockdist,0,0]) lockpeg(lockpegdia,thickness+1);
        translate([snaparmlen,-lpr/2,-1]) cylinder(thickness+2, r=lpr/2, $fn=24);
        translate([-snaparmlen,lpr/2,-1]) cylinder(thickness+2, r=lpr/2, $fn=24);
        translate([-lockdist,-lpr+deflection,-1]) cube([2*lockdist,2*(lpr-deflection),thickness+2]);
    }
}

// locking pin
module lockpeg(d1,ht=thickness, hscale=1.0) {
    d = 0.382*d1;
    a = 0.5*(d1-d);
    b = a-0.4;
    hull() {
        translate([a*hscale,0,-1]) cylinder(ht+0.6, d=d, $fn=16);
        translate([0,a,-1]) cylinder(ht+0.6, d=d, $fn=16);
        translate([-a*hscale,0,-1]) cylinder(ht+0.6, d=d, $fn=16);
        translate([0,-a,-1]) cylinder(ht+0.6, d=d, $fn=16);
        translate([b,0,0]) cylinder(ht, d=d, $fn=16);
        translate([0,b,0]) cylinder(ht, d=d, $fn=16);
        translate([-b,0,0]) cylinder(ht, d=d, $fn=16);
        translate([0,-b,0]) cylinder(ht, d=d, $fn=16);
    }    
}