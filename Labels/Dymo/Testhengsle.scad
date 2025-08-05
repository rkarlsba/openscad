// vim:ts=4:sw=4:sts=4:et:ai:si:tw=80:fdm=marker
//

include <BOSL2/std.scad>
include <BOSL2/hinges.scad>

$fn = 64;
test = false;
pin_dia = 2.05;
clearance = 0.2;
arm_height = 1;
offset = 3;
height = 7;
width = 40;
thickness = .6;
length = 35;    // Must be calculated
segs = 9;       // Must be calculated

union() {
    cuboid([thickness,width,height], anchor=BOTTOM+LEFT+BACK) {
        position(TOP+LEFT) {
            orient(anchor=LEFT) {
                knuckle_hinge(length=length, segs=segs, offset=offset,
                    arm_height=arm_height, pin_diam=pin_dia, clearance=clearance);
            }
        }
    }
    if (test) {
        cube([thickness,5,height]);
    }
}

translate([20,0,height]) {
    mirror([0,0,1]) {
        union() {
            cuboid([thickness,width,height], anchor=BOTTOM+LEFT+BACK) {
                position(TOP+LEFT) {
                    orient(anchor=LEFT) {
                        knuckle_hinge(length=length, segs=segs, offset=offset,
                            arm_height=arm_height, inner=true, pin_diam=pin_dia,
                            clearance=clearance);
                    }
                }
            }
            if (test) {
                cube([thickness,5,height]);
            }
        }
    }
}
