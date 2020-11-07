// vim:ts=4:sw=4:sts=4:et:ai:tw=80
//
// Box with hinged lid
// Type-R 3D Printing (www.typer-3Dprinting.nl)
// Maarten van Maanen
// 10.02.2017
// Print in any material
// Further development by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2020-02-27
// and on

// Originally based on http://www.thingiverse.com/thing:2104654, that is, the hinged box and
// https://www.thingiverse.com/thing:1563872, the nozzle inserts. I took a wee bit from each
// of them and combined it.

// I would recommend a 0,4mm nozzle to print this at 0,2mm height, at least the lid, to keep
// the letters from bleeding, which they did for me on PETG. If you have PETG working better
// than I have, no worries. As for the lid hinge, use a piece of filament, preferably PETG,
// since it's rather tough and won't get brittle. PLA will probably work, but I guess it'll
// need to get replaced after a while (after it breaks).



// Nozzle fit

// Nozzle box modifications

// [Nozzle Settings]

// Height of the threaded part of the nozzle [mm]
nozzleBaseHeight = 9;

// Height of the tip part of the nozzle [mm]
nozzleTipHeight = 4;

// Diameter of the threaded part of the nozzle [mm]
nozzleBaseDia = 6;

// Quantity of nozzles in X-direction
width_number = 8;//[2:10]

// Quantity of nozzles in Y-direction (see lblText if changed)
length_number = 4;//[2:10]

// Distance between and at the edges of the nozzleholes in X-direction [mm]
widthDistance = 5;

// Distance between and at the edges of the nozzleholes in Y-direction [mm]
lengthDistance = 5;

// General inaccuracy for the nozzleholes. Reduce to get a tighter fit [mm]
inaccuracy = 0.3;

nozzleBaseDia_ina = nozzleBaseDia + inaccuracy;

// [Dimensions]

// Case interior fillet radius [mm]
interiorFillet = 2.0;

// Vertical wall (side) thickness [mm]
sidewallWidth = 1.2; 

// Amount the lid protrudes into the case (larger value allows the case to close more securely) [mm]
lidInsetHeight = 1.2;

// Width of the case in mm (interior dimension)
interiorWidth = width_number * nozzleBaseDia_ina + (width_number+1) * widthDistance + sidewallWidth;

// Length of the case in mm (interior dimension)
interiorLength = length_number * nozzleBaseDia_ina + (length_number+1) * lengthDistance + sidewallWidth;

// Height of the case in mm (interior dimension)
interiorHeight = nozzleBaseHeight + nozzleTipHeight + 0.6;

/*[Details]*/

// Distance the top and bottom surfaces extend beyond the sides of the case (makes the case easier to open) [mm]
rimInset = 0.6; 

// Length of the opening tab on the lid of the case (optional - set to 0 to remove)
tabSize = 1; 

// Fillet radius used for hinge and tab
hingeFillet = 3;

/*[Label Settings]*/ // To change the text you have to open this file in OpenSCAD
// Toggle text, 1 is on
lblToggle = 1; //[1:True, 0:False]

// Size of the labels
lblSize = 3;

// Height of the labels [mm]
lblHeight = 1.0;

// Add it up
baseLength = interiorLength + sidewallWidth*2;
baseWidth = interiorWidth + sidewallWidth*2;
baseRadius = interiorFillet + sidewallWidth;

caseLength = baseLength + rimInset*2;
caseWidth = baseWidth + rimInset*2;
caseRadius = baseRadius + rimInset;

// debug mode enable echo statements to show variables during development.
// 1 to enable, 0 to disable.
debug=1;

lblText = [
    "0.2mm",
    "0.3mm",
    "0.4mm",
    "0.5mm",
    "0.6mm",
    "0.8mm",
    "1.0mm",
];

// Select which locations have which texts
// text idx, start row, end row, start col, end col
lblLocations = [
    [0, 0, 0, 0, 3], // .2
    [1, 0, 0, 4, 7], // .3
    [2, 1, 1, 0, 7], // .4
    [3, 2, 2, 0, 3], // .5
    [4, 2, 2, 4, 7], // .6
    [5, 3, 3, 0, 3], // .8
    [6, 3, 3, 4, 7]  // 1.0
];

// Main Variables (all measurements in mm)
lang    = caseLength;       // Box length
brd1    = caseWidth;        // Width box at top
brd2    = brd1;             // Width box at bottom
hoek    = 2.0;              // Diameter corners
diep    = 4.5;              // Height edge
wall1   = 1.5;              // General wall thickness
hoog1   = interiorHeight+10;// Height box (minimum 20mm because of hinge)
hoog2   = 3.0;              // Height lid
hinge1  = 4.0;              // Diameter hinge
hinge2  = caseWidth/4;      // Width of hinge
hinge3  = hinge2/2;         // Distance to hinge from edge
hole1   = 2.1;              // Diameter hole hinge pin
hole2   = 2.0;              // Diameter hole in edges (to secure)

if (debug) {
    echo("Debug statements are enabled");
    echo("caseLength is ", caseLength);
    echo("caseWidth is ", caseWidth); 
    echo("Hinge width is ", hinge2);
    echo("Distance from hinge to edge is ", hinge3);
    echo("interiorHeight is ", interiorHeight);
    echo("nozzleBaseDia_ina is ", nozzleBaseDia_ina);
    echo("Box height is ", hoog1);
    echo("Lid height is ", hoog2);
}

// Variables for text
//fontb="Old Stamper:style=Regular"; // Font for text front of box
fontb="Copperplate:style=Regular";
tekstb  = "Dysedåse";       // Text to print front of box
letterb = 9;                // Height of text front of box
fontd = fontb;              // Font voor text on lid
tekstd  = tekstb;           // Negative text to print on lid
letterd = 13;               // Height of text on lid
letterdth = 0.1;            // Thickness of text on lid
rotated = 270;              // Rotate text on lid (180 for side-lid/270 for rear-lid)
textimageb = "";            // Instead of tekstd
textimaged = textimageb;    // Instead of tekstb

// Variables to enable/disable choices
rounded = "N";              // Yes/No for rounded top of box
oor1    = "N";              // Yes/No for edge on lid
oor2    = "N";              // Yes/No for hole in edge
tekst1  = "N";              // Yes/No for text/image front of box
tekst2  = "Y";              // Yes/No for text/image top of lid
image1  = "N";              // Yes/No for image in front of box, overriding the text
image2  = "N";              // Yes/No for image on top of lid, overriding the text

// Drawing variables
hoek2   = hoek/2;           // Radius of corners
edge    = 1.6;              // Width edge before rim
rim1    = 1.6;              // Width raised rim (min. 1.2mm)
rim2    = 0.9*rim1;         // Width raised edge for lid
margin  = 0.15;             // Margin hinge/hinge opening
vert    = hinge1-hoek;      // Height vertical hinge opening

// Make box or lid or both?
make_box = 0;
make_lid = 1;
make_text = 1;
//separate_text = 1;

// if 

// Detail level
$fn = $preview ? 16 : 64;   // Could be adjusted from 64 to 32 or even 128 or something
                            // if either rendering time is too high or you want higher
                            // level of details

eps = 0.1;

// Box body
if (make_box) {
    union() {
        difference() {
            B1();
            W1();
        }
        // og dysene, da
        translate([baseLength-nozzleBaseDia/4,0,wall1]) {
            rotate([0,0,90]) {
                nozzleinsert();
            }
        }
    }
}
// Lid
// Enable Translate below to put lid on box
// translate([0*lang+0,1.0*brd1,hoog1+hoog2]) rotate([180,0,0])
if (make_lid) {
    translate([1.2*lang,0,0]) { // Disable to put lid on box
        difference() {
            B2();
            W2();
        }
    }
}

// Print the lid text positively, separately, so it can be glued onto the lid
// or blended in with some multi-material-unit.
if (make_text) {
    translate([lang,lang*2.1,0]) {
        linear_extrude(height=1) {
            text(tekstd,font=fontd,size=letterd,valign="center",halign="center");
        }
    }
}


module nozzleinsert() {
    difference() {
        translate([nozzleBaseDia/4,0,0])
            cube([baseWidth-nozzleBaseDia/2,baseLength-nozzleBaseDia/2,nozzleBaseHeight]);
        translate([baseWidth/2,baseLength/2+nozzleBaseDia/4,0]) {
            nozzle();
            if (lblToggle == 1) {
                maketext();
            }
        }
    }
}
//
// Modules
//
// Module for main body box
module B1() {
    // Box has with rounded edged and corners
    // Rear is curved to enable the lid to actually rotate
    hull() {
        // Four corners bottom
        translate([hoek2,hoek2+(brd1-brd2)/2,hoek2])
            Corner1(hoek);
        translate([lang-hoek2,hoek2+(brd1-brd2)/2,hoek2])
            Corner1(hoek);
        translate([hoek2,brd2+(brd1-brd2)/2-hoek2,hoek2])
            Corner1(hoek);
        translate([lang-hoek2,brd2+(brd1-brd2)/2-hoek2,hoek2])
            Corner1(hoek);

        // For esthetics, the top of the box is rectangular for the
        // height of the hinge
        // Front corners top
        translate([hoek2,hoek2,hoog1-vert])
            Corner1(hoek);
        translate([hoek2,brd1-hoek2,hoog1-vert])
            Corner1(hoek);
        // Rear corners top (lower corners of rectangular part)
        // Top corners rounded or straight
        if (rounded=="Y") {// Front corners
            translate([hoek2,hoek2,hoog1-hoek2])
                Corner1(hoek);
            translate([hoek2,brd1-hoek2,hoog1-hoek2])
                Corner1(hoek);
            // Rear corners just below the curve
            translate([lang-hoek2,hoek2,hoog1-vert])
                Corner1(hoek);
            translate([lang-hoek2,brd1-hoek2,hoog1-vert])
                Corner1(hoek);
        } else {
            translate([hoek2,hoek2,hoog1-hoek2])
                cylinder(h=hoek2,d=hoek);
            translate([hoek2,brd1-hoek2,hoog1-hoek2])
                cylinder(h=hoek2,d=hoek);
        }
        // Rear of box is curved for rotating lid
        RearCurve();
        }
    // Brim for opening if chosen
    if (oor1=="Y") {
        translate([hoek2,0.5*brd2+(brd1-brd2)/2,0])
            resize([8,0.3*(brd1+brd2)/2,wall1])
                cylinder(h=wall1,d=brd2);
    }
}
module W1() {
    // Hollow out box body
    // Main part
    hull() {
        translate([wall1,(brd1-brd2)/2+wall1,wall1])
            cube([lang-2*wall1-hinge1,brd2-2*wall1,1]);
        translate([edge+rim1,edge+rim1,hoog1+1])
            cube([lang-edge-rim1-wall1-hinge1,brd1-2*edge-2*rim1,1]);
    }
    // Triangular hollow out below hinge to maximize space
    hull() {
        translate([wall1,(brd1-brd2)/2+wall1,wall1])
            cube([lang-4.5*wall1,(brd2-2*wall1),1]);
        translate([edge+rim1,edge+rim1,hoog1+1])
            cube([lang-2.5*hinge1,brd1-2*edge-2*rim1,0.5]);
    };
    // Edges
    translate([edge,edge,hoog1-diep-0.2])
        cube([lang-2.5*edge-hinge1,brd1-2*edge,diep+1]);
    // Hinge openings
    translate([lang-1*hinge1-0.5,hinge3,hoog1-1.5*hinge1-0.5])
        Hinge1();
    translate([lang-1*hinge1-0.5,brd1-hinge2-hinge3,hoog1-1.5*hinge1-0.5])
        Hinge1();
    // Hole for hinge pin
    translate([lang-0.5*hinge1,1.25*brd1,hoog1-hinge1])
        rotate([90,0,0])
            cylinder(h=1.5*brd1,d=hole1);
    // Hole to enable securing box
    if (oor2=="Y") {
        translate([-0.5*hole2,0.5*brd2+(brd1-brd2)/2,-0.1])
            cylinder(h=2*wall1,d=hole2); 
    }
    // Text on front of box
    if (tekst1=="Y") {
        translate([0.7,0.5*brd1,0.5*hoog1]) {
            rotate([90,0,270]) {
                if (image1 == "Y") {
                    scale([1, 1, 0.1])
                        surface(file = textimageb, center = true);
                } else {
                    linear_extrude(height=letterdth) {
                        text(tekstb,font=fontb,size=letterb,valign="center",halign="center");
                    }
                }
            }
        }
    }
}
// Module for main body lid
module B2() {
    // Lid
    hull() {
        // Corners bottom
        translate([hoek2,hoek2,hoek2])
            Corner1(hoek);
        translate([lang-hoek2,hoek2,hoek2])
            Corner1(hoek);
        translate([hoek2,brd1-hoek2,hoek2])
            Corner1(hoek);
        translate([lang-hoek2,brd1-hoek2,hoek2])
            Corner1(hoek);
        // Corners top
        translate([hoek2,hoek2,hoog2-hoek2])
            cylinder(h=hoek2,d=hoek);
        translate([lang-hoek2,hoek2,hoog2-hoek2])
            cylinder(h=hoek2,d=hoek);
        translate([hoek2,brd1-hoek2,hoog2-hoek2])
            cylinder(h=hoek2,d=hoek);
        translate([lang-hoek2,brd1-hoek2,hoog2-hoek2])
            cylinder(h=hoek2,d=hoek);
    }
    // The rims have rounded edges in front for easier closing/opening
    // Rims have a small marging from edge for better fit
    hull() {
        translate([edge+margin+0.5*rim2,edge+margin+0.5*rim2,hoog2])
            cylinder(h=0.8*diep,d=rim2);
        translate([edge+margin+0.5*rim2,brd1-edge-margin-0.5*rim2,hoog2])
            cylinder(h=0.8*diep,d=rim2);   
        translate([lang-4.5*edge-hinge1,edge+margin,hoog2])
            cube([rim2,brd1-2*edge-2*margin,0.8*diep]);
    }
    // Hinges
    translate([lang-hinge1,hinge3+1*margin,0])
        Hinge2();
    translate([lang-hinge1,brd1-hinge2-hinge3+1*margin,0])
        Hinge2();
    // Brim for lid if chosen
    if (oor1=="Y") {
        translate([hoek2,0.5*brd1,0])
            resize([8,0.3*(brd1+brd2)/2,wall1])
                cylinder(h=wall1,d=brd1);
    }
}
module W2() {
    // Hollow out lid
    translate([edge+margin+rim2,edge+margin+rim2,wall1])
        cube([lang-edge-margin-rim2-hinge1,brd1-2*edge-2*margin-2*rim2,hoog2+5]);
    // Hinge pin hole
    translate([lang-0.5*hinge1,brd1,hoog2+1.0*hinge1])
        rotate([90,0,0])
            cylinder(h=brd1,d=hole1);
    // Hole to enable securing box
    if (oor2=="Y") {
        translate([-0.5*hole2,0.5*brd2+(brd1-brd2)/2,-0.1])
            cylinder(h=2*wall1,d=hole2); 
    }
    // Text on lid if chosen
    if (tekst2=="Y") {
        translate([0.5*lang,0.5*brd1,0.6]) { 
            rotate([0,180,rotated]){ 
                if (image2 == "Y") {
                    scale([0.15, 0.15, 0.1])
                        surface(file = textimaged, center = true);
                } else {
                    linear_extrude(height=1) {
                        text(tekstd,font=fontd,size=letterd,valign="center",halign="center");
                    }
                }
            }
        }
    }
}
// Module for round rear of box to enable to lid to rotate
module RearCurve() {
    // Curved piece
    if (rounded=="N") {
        translate([lang-0.5*vert,brd1,hoog1-0.5*vert])
            rotate([90,0,0])
                cylinder(h=brd1,d=vert);
    } else { // Cylinder with rounded ends for rounded top
        // front
        translate([lang-0.5*vert,hoek2,hoog1-0.5*vert])
            rotate([90,0,0])
                rotate_extrude(convexity = 1)
                    translate([0.5*(vert-hoek),0,0])
                        circle(r=hoek2);
        // rear
        translate([lang-0.5*vert,brd1-hoek2,hoog1-0.5*vert])
            rotate([90,0,0])
                rotate_extrude(convexity = 1)
                    translate([0.5*(vert-hoek),0,0])
                        circle(r=hoek2);
    }
}
// module for hinge opening
module Hinge1() {
    hull() {
        cube([1,hinge2,2.0*hinge1]);
        translate([10,0,-1])
            cube([1,hinge2,2.0*hinge1]);
    }
}
// module for hinge
module Hinge2() {
    hull() {
        translate([0,0,hoek])
            cube([hinge1,hinge2-2*margin,hinge1-hoek]);
        translate([0.5*hinge1,hinge2-2*margin,hoog2+1.0*hinge1])
            rotate([90,0,0])
                cylinder(h=hinge2-2*margin,d=hinge1);
    }
}
// module for spheres in corners for rounded look
module Corner1(diam) {
    sphere(d=diam);
}

module nozzle()
{
    translate([nozzleBaseDia_ina/2 - (width_number/2)*nozzleBaseDia_ina - ((width_number-1)/2)*widthDistance, nozzleBaseDia_ina/2 - (length_number/2)*nozzleBaseDia_ina - ((length_number-1)/2)*lengthDistance, 0])
    {
        for(n = [0 : width_number - 1])
        {
            for(m = [0 : length_number - 1])
            {
                translate([n * (nozzleBaseDia_ina + widthDistance), m * (nozzleBaseDia_ina + lengthDistance),0])
                {
                    //echo("translate([", n * (nozzleBaseDia_ina + widthDistance), ", ", m * (nozzleBaseDia_ina + lengthDistance), ", 0]");

                    cylinder(d = nozzleBaseDia_ina, h = nozzleBaseHeight+.01);
                }
            }    
        }
    }
}

module maketext()
{
    for (l = lblLocations) {
        _txt = lblText[l[0]];
        _num = l[4] - l[3] + 1;
        
        // x start
        _totw = (width_number * nozzleBaseDia_ina + (width_number+1) * widthDistance);
        _w = _num * nozzleBaseDia_ina + (_num+1) * widthDistance - 10;
        _start_w = l[3] * (nozzleBaseDia_ina + widthDistance) + 5;
        
        for (n = [l[1] : l[2]]) {
            translate([(_totw/2 - _start_w  - _w/2), // TODO
                       (n + 1)*lengthDistance + n*nozzleBaseDia_ina - caseLength/2,
                       nozzleBaseHeight-lblHeight]) {
                linear_extrude(height=lblHeight+.1) {
                    rotate([0,0,180])
                    text(_txt, size=lblSize, valign="center", halign="center", spacing = 1.2);
                }

                // left lines
                translate([8,0,0])
                    cube([_w / 2 - widthDistance-1,0.6,lblHeight+.1]);
                translate([_w / 2 - widthDistance+2+4.4,0, 0])
                    cube([0.6,nozzleBaseDia/2,lblHeight+.1]);
                
                // right lines
                mirror([1,0,0]) {
                    translate([8,0,0])
                        cube([_w / 2 - widthDistance-1,0.6,lblHeight+.1]);
                    translate([_w / 2 - widthDistance+2+4.4,0, 0])
                        cube([0.6,nozzleBaseDia/2,lblHeight+.1]);
                }
            }
        }
    }
}

module rrect(h, w, l, r) {
    r = min(r, min(w/2, l/2));
    w = max(w, eps);
    l = max(l, eps);
    h = max(h, eps);
    if (r <= 0) {
        translate([-w/2, -l/2,0]) {
            cube([w,l,h]);
        }
    } else {
        hull() {
            for (y = [-l/2+r, l/2-r]) {
                for (x = [-w/2+r, w/2-r]) {
                    translate([x,y,0]) {
                        cylinder(h=h, r=r, center=false);
                    }
                }
            }
        }
    }
}

