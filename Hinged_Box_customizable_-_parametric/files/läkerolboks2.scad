// vim:ts=4:sw=4:sts=4:et:ai:tw=80
//
// Box with hinged lid
// Type-R 3D Printing (www.typer-3Dprinting.nl)
// Maarten van Maanen
// 10.02.2017
// Print in any material
// Further development by Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2020-02-27
// and on

// Main Variables (all measurements in mm)
lang    = 30.0;             // Box length
brd1    = 50.0;             // Width box at top
brd2    = 50.0;             // Width box at bottom
hoek    = 2.0;              // Diameter corners
diep    = 4.5;              // Height edge
wall1   = 1.5;              // General wall thickness
hoog1   = 55.0;             // Height box (minimum 20mm because of hinge)
hoog2   = 3.0;              // Height lid
hinge1  = 4.0;              // Diameter hinge
hinge2  = 15.0;             // Width of hinge
hinge3  = 8.0;              // Distance to hinge from edge
hole1   = 2.1;              // Diameter hole hinge pin
hole2   = 2.0;              // Diameter hole in edges (to secure)

// Variables for text
fontb="Old Stamper:style=Regular"; // Font for text front of box
tekstb  = "Läkerol";        // Text to print front of box
letterb = 9;                // Height of text front of box
fontd = fontb;              // Font voor text on lid
tekstd  = tekstb;           // Negative text to print on lid
letterd = 8;                // Height of text on lid
rotated = 270;              // Rotate text on lid (180 for side-lid/270 for rear-lid)
textimageb = "läkerol_logo_liten.png"; // Instead of tekstd
textimaged = textimageb;    // Instead of tekstb

// Variables to enable/disable choices
rounded = "N";              // Yes/No for rounded top of box
oor1    = "N";              // Yes/No for edge on lid
oor2    = "N";              // Yes/No for hole in edge
tekst1  = "N";              // Yes/No for text/image front of box
tekst2  = "Y";              // Yes/No for text/image top of lid
image1  = "N";              // Yes/No for image in front of box, overriding the text
image2  = "Y";              // Yes/No for image on top of lid, overriding the text

// Drawing variables
hoek2   = hoek/2;           // Radius of corners
edge    = 1.6;              // Width edge before rim
rim1    = 1.6;              // Width raised rim (min. 1.2mm)
rim2    = 0.9*rim1;         // Width raised edge for lid
margin  = 0.15;             // Margin hinge/hinge opening
vert    = hinge1-hoek;      // Height vertical hinge opening
$fn     = 60;               // Variabele for cirkels

// Box body
difference() {
    B1();
    W1();
}
// Lid
// Enable Translate below to put lid on box
// translate([0*lang+0,1.0*brd1,hoog1+hoog2]) rotate([180,0,0])
translate([1.2*lang,0,0]) { // Disable to put lid on box
    difference() {
        B2();
        W2();
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
                    linear_extrude(height=1) {
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

