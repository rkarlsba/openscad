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
 *
 * TODO:
 * - Top cover coming (2025-08-04), but not finished.
 * - Hinges coming (2025-08-04), but
 *   https://github.com/BelfrySCAD/BOSL2/wiki/hinges.scad looks promising
 * 
 *****************************************************************************/

$fn = 250;
bugfix = $preview ? .1 : 0;

dt1 = 0.01;
dt2 = dt1*2;
prt_delta = 0.4;

b_x = 57;           // orig: 15mm
b_y = 17;           // orig: 17mm
b_z = 23;           // orig: 23mm

notch_x = 10;
notch_z = 9;
notch_x_off = 21;   // orig: 20mm

notch_dy = 2;
notch_dz = 3;
mat = 2;            // orig: 1.2mm

// How many do we need?
anzahl=2;

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
        translate([0, i*(b_y+mat), 0])
        difference() {
            union() {
                difference() {
                    cube([b_x+mat*2, b_y+mat*2, b_z+mat]);
                    union() {
                        translate([mat, mat, mat+dt1]) {
                            cube([b_x, b_y, b_z+bugfix]);
                        }
                        translate([-dt1, -dt1, -dt1]) {
                            cube([20+dt2, b_y+2*mat+dt2, 20+dt2]);
                        }
//                      translate([notch_x, -dt1, notch_z])
//                          color("red")
//                          cube([20, notch_dy+mat, notch_dz]);
//                      // Vertical notch:
//                      translate([20, -dt1, notch_z])
//                          color("red")
//                          cube([notch_dy+mat, notch_dz,20 ]);
                    }
                }
                slope();
            }
            union() {
                // Vertical notch:
                translate([notch_x_off, -dt1, notch_z]) {
                    color("red") {
                        cube([notch_dy+mat, b_y+2*mat+dt2, 20 ]);
                    }
                }
                // Horizontal notch?
//              translate([notch_x, -dt1, notch_z])
//                  color("red")
//                  cube([20, notch_dy+mat, notch_dz]);
            }
        }
    }
}

module upper_part() {
    for(i = [0:anzahl-1]) {
        translate([0, i*(b_y+mat), 0])
        difference() {
            union() {
                difference() {
                    cube([b_x+mat*2, b_y+mat*2, b_z+mat]);
                    union() {
                        translate([mat, mat, mat+dt1]) {
                            cube([b_x, b_y, b_z+bugfix]);
                        }
                        translate([-dt1, -dt1, -dt1]) {
                            cube([20+dt2, b_y+2*mat+dt2, 20+dt2]);
                        }
// What's this?                    
//                      translate([notch_x, -dt1, notch_z]) {
//                          color("red") {
//                              cube([20, notch_dy+mat, notch_dz]);
//                          }
//                      }
//                      // Vertical notch:
//                      translate([20, -dt1, notch_z]) {
//                          color("red") {
//                              cube([notch_dy+mat, notch_dz,20 ]);
//                          }
//                      }
                    }
                }
                slope();
            }
            union() {
                //vertical notch:
                translate([21, -dt1, notch_z]) {
                    color("red") {
                        cube([notch_dy+mat, b_y+2*mat+dt2, 20 ]);
                    }
                }
                // Horizontal notch?
//              translate([notch_x, -dt1, notch_z]) {
//                  color("red") {
//                      cube([20, notch_dy+mat, notch_dz]);
//                  }
//              }
            }
        }
    }
}

lower_part();
