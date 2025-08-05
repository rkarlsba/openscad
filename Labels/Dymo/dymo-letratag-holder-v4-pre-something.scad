/******************************************************************************
 * vim:ts=4:sw=4:sts=4:et:ai:tw=80:fdm=marker
 *
 * Dymo LetraTag Holder
 * Version 1 - 19.09.2020 
 * CC-BY-NC-SA 2020 by oli@huf.org (ohuf@Thingiverse)
 *
 * https://www.thingiverse.com/thing:4601782 und
 * https://www.printables.com/model/44316-customizable-dymo-letratag-holder
 * 
 * (Deutscher Text: Siehe unten...)
 * 
 * This is a customizable holder for DYMO's LetraTag label cartridges
 * 
 * Enjoy, have fun remixing and let me know when you've made one, and what for!
 * 
 * ----------------------------------------------------------------------------
 * [DE:]
 * 
 * Ein "Customizable" Halter für DYMO's LetraTag label-Kassetten.
 * 
 * Wenn du einen hergestellt hast, lass es mich über "I Made One" wissen!
 * 
 * Konstruiert in OpenSCAD: viel Spaß beim Remixen!
 * 
 * License: CC-BY-NC-SA : oli@huf.org
 * 
 * Read all about it here: http://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 * The following in English only (entschuldigung):
 * 
 * Version 2.0 - 2025-08-05 by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 * - Code cleanup.
 * - Removed commented out code.
 * - Added a small bugfix to make previews look better.
 * - Notch offset was hardcoded to 20mm, moved it to notch_x_off, set to 21mm.
 * - Just a tunable, but I extended the length by a couple of millimetres to
 *   allow for chinese copies that turned out to be longer.
 * - Just a tunable, but I changed the wall thickness (mat) from 1.2 to 2, since
 *   1.2 made it very flimsy and brittle with ABS and I can only dream (in some
 *   rather bad nightmares) how that'll be in PLA.
 * - Added rounded_notch (as an option), since the original flat bottom welcomed
 *   cracks too much. See FIXME for a diry hack in that code.
 * - Changed notch_x_off to notch_x_off_btm and notch_x_off_top, depending on
 *   which model it's for.
 * - Hinges added, but not well tested (yet). The hinges require a center pin,
 *   so I used a short piece of 1,75mm PETG. 
 * - This now uses the BOLS2 library for hinges and some string handling, so
 *   head over to https://github.com/BelfrySCAD/BOSL2/wiki/ for installation
 *   instrucions.
 * - This is also available from my github, so see
 *   https://github.com/rkarlsba/openscad/tree/master/Labels/Dymo for the latest
 *   code if I update something and forget (or ignore) to update printables.
 *
 * FIXME:
 * - That *15 down at the rounded notch code is a really ugly hack, but I
 *   coulnd't find out how to fix it the proper way. If someone else could fix
 *   that, thanks!
 * 
 *****************************************************************************/

include <BOSL2/std.scad>
include <BOSL2/strings.scad>
include <BOSL2/hinges.scad>

$fn = 250;
bugfix = $preview ? .1 : 0;

// Hinges?
hinges = true;

dt1 = 0.01;
dt2 = dt1 * 2;
prt_delta = 0.4;

b_x = 57;               // orig: 15mm
b_y = 16.3;             // orig: 17mm
b_z_btm = 23;           // orig: 23mm
b_z_top = 33;

notch_x = 10;           // orig: 10mm
notch_z_btm = 8;        // orig: 9mm
notch_z_top = 26;
notch_x_off_btm = 20.5; // orig: 20mm
notch_x_off_top = 4.5;  // orig: 20mm
rounded_notch = true;

notch_dy_top = 2.5;
notch_dy_btm = 2;
notch_dz = 3;
mat = 2;                // orig: 1.2mm

hinge_seg = 3.6;        // Hinge segment length
hinge_height = 7;       // Hinge height
hinge_offset = 3;
hinge_arm_height = 1;
hinge_pin_dia = 2.05;
hinge_clearance = 0.2;

// How many slots do we need?
anzahl=1;

// Choose between "top", "btm" and "both"
which_part = "top";

// Internals - KEEP OFF
_notch_z_top = rounded_notch ? notch_z_top+notch_dy_top : notch_z_top;
_notch_z_btm = rounded_notch ? notch_z_btm+notch_dy_btm : notch_z_btm;
_which_part = downcase(which_part);

// assert(hinges && anzahl < 3, 

module slope() {
    translate([0,b_y+2*mat, 0]) {
        rotate([90,0,0]) {
            translate([20+mat, 20+mat, 0]) {
                difference() {
                    cylinder(r=20+mat, h=b_y+2*mat);
                    union() {
                        translate([0, 0, mat]) {
                            cylinder(r=20, h=b_y);
                        }
                        translate([-20-mat, 0, -dt1]) {
                            cube([50, 50, b_y+2*mat+dt2]);
                        }
                        translate([0, -20-mat, -dt1]) {
                            cube([50, 50, b_y+2*mat+dt2]);
                        }
                    }
                }
            }
        }
    }
}

module lower_part() {
    for(i = [0:anzahl-1]) {
        translate([0, i*(b_y+mat), 0]) {
            difference() {
                union() {
                    difference() {
                        cube([b_x+mat*2, b_y+mat*2, b_z_btm+mat]);
                        union() {
                            translate([mat, mat, mat+dt1]) {
                                cube([b_x, b_y, b_z_btm+bugfix]);
                            }
                            translate([-dt1, -dt1, -dt1]) {
                                cube([20+dt2, b_y+2*mat+dt2, 20+dt2]);
                            }
                        }
                    }
                    slope();
                }
                union() {
                    // Vertical notch:
                    translate([notch_x_off_btm, -dt1, _notch_z_btm]) {
                        color("red") {
                            cube([notch_dy_btm+mat, b_y+2*mat+dt2, 20 ]);
                            if (rounded_notch) {
                                translate([(notch_dy_btm+mat)/2,0,0]) {
                                    rotate([-90,0,0]) {
                                        cylinder(h=(mat+dt1*2)*15, r=notch_dy_btm);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (hinges) {
        // Hinges
        case_width = (b_y+mat)*anzahl+mat;
        hinge_width = case_width - 5;
        segs = floor(hinge_width/hinge_seg);
        echo(str("[1] segs = ", segs));
        _segs = (segs % 2) ? segs : segs - 1;
        echo(str("[2] _segs = ", _segs));
        translate([mat/2,case_width,b_z_btm-hinge_height+2]) {
            cuboid([mat/2,case_width,hinge_height], anchor=BOTTOM+LEFT+BACK) {
                position(TOP+LEFT) {
                    orient(anchor=LEFT) {
                        knuckle_hinge(length=hinge_width, segs=_segs, offset=hinge_offset,
                            arm_height=hinge_arm_height, pin_diam=hinge_pin_dia, clearance=hinge_clearance);
                    }
                }
            }
        }
    }
}

module upper_part() {
    for(i = [0:anzahl-1]) {
        translate([0, i*(b_y+mat), 0]) {
            difference() {
                union() {
                    difference() {
                        cube([b_x+mat*2, b_y+mat*2, b_z_top+mat]);
                        union() {
                            translate([mat, mat, mat+dt1]) {
                                cube([b_x, b_y, b_z_top+bugfix]);
                            }
                            translate([-dt1, -dt1, -dt1]) {
                                cube([20+dt2, b_y+2*mat+dt2, 20+dt2]);
                            }
                        }
                    }
                    slope();
                }
                union() {
                    // Vertical notch:
                    translate([notch_x_off_top, -dt1, _notch_z_top]) {
                        color("red") {
                            cube([notch_dy_top+mat, b_y+2*mat+dt2, 20 ]);
                            if (rounded_notch) {
                                translate([(notch_dy_top+mat)/2,0,0]) {
                                    rotate([-90,0,0]) {
                                        cylinder(h=(mat+dt1*2)*15, d=notch_dy_top+mat);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (hinges) {
        // Hinges
        case_width = (b_y+mat)*anzahl+mat;
        hinge_width = case_width - 5;
        segs = floor(hinge_width/hinge_seg);
        echo(str("[1] segs = ", segs));
        _segs = (segs % 2) ? segs : segs - 1;
        echo(str("[2] _segs = ", _segs));
        translate([mat/2,case_width,b_z_top-hinge_height+2]) {
            cuboid([mat/2,case_width,hinge_height], anchor=BOTTOM+LEFT+BACK) {
                position(TOP+LEFT) {
                    orient(anchor=LEFT) {
                        knuckle_hinge(length=hinge_width, segs=_segs, offset=hinge_offset,
                            arm_height=hinge_arm_height, pin_diam=hinge_pin_dia, inner=true, clearance=hinge_clearance);
                    }
                }
            }
        }
    }
}

if (_which_part == "btm" || _which_part == "bottom") {
    lower_part();
} else if (_which_part == "top") {
    upper_part();
} else if (_which_part == "both" || _which_part == "all") {
    lower_part();
    //translate([b_x+mat*2, 30, b_z_top+mat]) {
    //translate([(b_x+mat*2)*2+10, 0, b_z_top+mat]) {
    translate([70, 0, 0]) {
        rotate([0,0,0]) {
            upper_part();
        }
    }
} else {
    assert(false, "Set 'which_part' to on of \"top\", \"btm\" or \"both\"");

}
