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
 * This is a customizable holder for DYMO's LetraTag label  cartridges
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
 * Edited by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 * - Code cleanup
 * - Added a small bugfix to make previews look better.
 * - Notch offset was hardcoded to 20mm, moved it to notch_x_off, set to 21mm.
 * - Just a tunable, but I extended the length by a couple of millimetres to
 *   allow for chinese copies that turned out to be longer.
 * - Just a tunable, but I changed the wall thickness (mat) from 1.2 to 2, since
 *   1.2 made it very flimsy and brittle with ABS and I can only dream (in some
 *   rather bad nightmares) how that'll be in PLA.
 * - Added rounded_notch (as an option), since the original flat bottom welcomed
 *   cracks too much. See under TODO for a diry hack in that code.
 * - Changed notch_x_off to notch_x_off_btm and notch_x_off_top, depending on
 *   which model it's for.
 *
 * TODO:
 * - That *15 down at the rounded notch code is a really ugly hack, but I
 *   coulnd't find out how to fix it the proper way. Sorry!
 * - Top cover coming (2025-08-04), but not finished.
 * - Hinges coming (2025-08-04), but
 *   https://github.com/BelfrySCAD/BOSL2/wiki/hinges.scad looks promising
 * 
 *****************************************************************************/

$fn = 250;
bugfix = $preview ? .1 : 0;

dt1 = 0.01;
dt2 = dt1 * 2;
prt_delta = 0.4;

b_x = 57;               // orig: 15mm
b_y = 16;               // orig: 17mm
b_z_btm = 23;           // orig: 23mm
b_z_top = 31;

notch_x = 10;           // orig: 10mm
notch_z_btm = 8;        // orig: 9mm
notch_z_top = 25;
notch_x_off_btm = 20.5; // orig: 20mm
notch_x_off_top = 4.5;   // orig: 20mm
rounded_notch = true;

notch_dy_top = 2.5;
notch_dy_btm = 2;
notch_dz = 3;
mat = 2;                // orig: 1.2mm

// How many do we need?
anzahl=1;

// Internals - KEEP OFF
_notch_z_top = rounded_notch ? notch_z_top+notch_dy_top : notch_z_top;
_notch_z_btm = rounded_notch ? notch_z_btm+notch_dy_btm : notch_z_btm;

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
//                          translate([notch_x, -dt1, notch_z])
//                              color("red")
//                              cube([20, notch_dy_btm+mat, notch_dz]);
//                          // Vertical notch:
//                          translate([20, -dt1, notch_z])
//                              color("red")
//                              cube([notch_dy_btm+mat, notch_dz,20 ]);
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
                    // Horizontal notch?
//                  translate([notch_x, -dt1, notch_z])
//                      color("red")
//                      cube([20, notch_dy_btm+mat, notch_dz]);
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
}

lower_part();
// translate([0,30,0]) {
//     upper_part();
// }

translate([b_x+mat*2, 30, b_z_top+mat]) {
    rotate([0,180,0]) {
        upper_part();
    }
}
