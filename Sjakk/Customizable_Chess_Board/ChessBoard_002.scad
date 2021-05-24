/*
 * Based on https://www.thingiverse.com/thing:1732292
 *
 * Rewritten for better readability and added a variable to allow for variable
 * connector heights. Renamed some variables/modules to make things more consistent.
 *
 * Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 *
 */

side=30;
//thickness of the board
thickness=2.2;
edge_thickness=3;
connector_height=thickness;
//coefficient of the thickness of the board
edge_height_coef=1.5;//[1:0.1:3]

// printer tolerance (only affect "color 02" parts)
tolerance=0.3;//[0:0.05:0.7]
// definition (only affect corners)
$fn=60;
// [Corner color 01,Corner color 02,Edge color 01,Edge color 02,Center color 01,Center color 02,Test part]
render="Edge color 1";

////////
module slot() {
    translate([-side/2,0,-thickness/2-0.2]) {
        rotate([0,0,180]) {
            translate([0.2,0,0]) {
                hull() {
                    for(i=[-1,1]) {
                        translate([-0.5-2*tolerance/1.75,i*(0.866+2*tolerance),0]) {
                            cylinder(d=8,h=connector_height+0.5,$fn=3);
                        }
                    }
                }
            }
        }
    }
}
module color1(a) {
    cube([side,side,thickness],center=true);
    for(i=[0,90]) {
        rotate([0,0,i]) {
            translate([-side/2,0,-thickness/2]) {
                cylinder(d=10,h=connector_height,$fn=3);
            }
        }
    }
    if (a==2) {
        for(i=[0,-90]) {
            rotate([0,0,i]) {
                translate([-side/2,side/2,-thickness/2]) {
                    cube([side,edge_thickness,edge_height_coef*thickness]);
                }
            }
        }
        difference() {
            translate([side/2,side/2,-thickness/2]) {
                cylinder(r=edge_thickness,h=edge_height_coef*thickness);
            }
            cube([side,side,2*edge_height_coef*thickness],center=true);
        }
    }
    if (a==3) {
        rotate([0,0,180]) {
            translate([-side/2,0,-thickness/2]) {
                cylinder(d=10,h=connector_height,$fn=3);
            }
        }
        translate([-side/2,side/2,-thickness/2]) {
            cube([side,edge_thickness,edge_height_coef*thickness]);
        }
    } else if (a==4) {
        for(i=[180,-90]) {
            rotate([0,0,i]) {
                translate([-side/2,0,-thickness/2]) {
                    cylinder(d=10,h=connector_height,$fn=3);
                }
            }
        }
    }
    else {};
}

module color2(a) {
    difference() {
        cube([side,side,thickness],center=true);
        for(i=[0,90]) {
            rotate([0,0,i]) {
                slot();
            }
        }
        if (a==3) {
            rotate([0,0,180]) {
                 slot();
            }
        }
        else if (a==4) {
            for(i=[180,-90]) {
                rotate([0,0,i]) {
                    slot();
                }
            }
        }
        else {};
    }
    if (a==2) {
        for(i=[0,-90]) {
            rotate([0,0,i]) {
                translate([-side/2,side/2,-thickness/2]) {
                    cube([side,edge_thickness,edge_height_coef*thickness]);
                }
            }
        }
        difference() {
            translate([side/2,side/2,-thickness/2]) {
                cylinder(r=edge_thickness,h=edge_height_coef*thickness);
            }
            cube([side,side,2*edge_height_coef*thickness],center=true);
        }
    }
    if (a==3) {
        translate([-side/2,side/2,-thickness/2]) {
            cube([side,edge_thickness,edge_height_coef*thickness]);
        }
    }
}

if (render=="Corner color 1") {
    color1(2);
}
else if (render=="Corner color 2") {
    color2(2);
}
else if (render=="Edge color 1") {
    color1(3);
}
else if (render=="Edge color 2") {
    color2(3);
}
else if (render=="Center color 1") {
    color1(4);
}
else if (render=="Center color 2") {
    color2(4);
}
else if (render=="Test part") {
    rotate([0,0,180]) translate([-1.5,0,0]) difference() {
        translate([-7.5,0,0]) {
            cube([15,15,thickness],center=true);
            translate([-30/2,0,-thickness/2-0.2]) {
                rotate([0,0,180]) {
                    translate([0.2,0,0]) hull() {
                        for(i=[-1,1]) {
                            translate([-0.5-2*tolerance/1.75,i*(0.866+2*tolerance),0]) {
                                cylinder(d=8,h=thickness/2+0.5,$fn=3);}
                            }
                        }
                    }
                }
            }
        }
        translate([-1.5,0,0]) {
            union() {
                translate([-7.5,0,0]) {
                    cube([15,15,thickness],center=true);
                }
                translate([-30/2,0,-thickness/2]) {
                    cylinder(d=10,h=thickness/2,$fn=3);
                }
            }
    }
}
