// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// File: spatula-55mm.stl

$fn = 100;

module spatula() {
    bugfix = $preview ? .1 : 0;

    font_face = "Keania One:style=Regular"; 
    font_size = 6;
    font_spacing = 1.1;

    height = 1.5;
    spatula_blade_width = 20;
    spatula_shaft_width = 10;
    spatula_shaft_length = 35;
    spatula_shaft_padding = 5;
    spatula_blade_macick1 = 4;
    spatula_blade_macick2 = 43.6;
    spatula_length = 55;
    spatula_blade_length = 20;
    spatula_cut_angle = -5.1;
    spatula_text_y = 9.5;
    spatula_text_x = 12.4;

    // Choose between "cut", "emboss" or "deboss"
    //text_type = "cut";
    text_type = "emboss";
    //text_type = "deboss";

    // Emboss or deboss by this amount. 
    boss_by = .4;

    // Main code
    assert(text_type == "cut" || text_type == "emboss" || text_type == "deboss",
        "We don't support that. RTFS!");

    _boss_by = (text_type == "cut") ? height : boss_by;

    difference() {
        union() {
            translate([spatula_blade_width/2,spatula_shaft_width/2,0]) {
                cylinder(d=spatula_shaft_width, h=height);
            }
            translate([spatula_shaft_width/2,spatula_shaft_width/2,0]) {
                cube([spatula_shaft_width,spatula_shaft_length+spatula_shaft_padding,height]);
            }
            difference() {
                translate([0,spatula_shaft_length,0]) {
                    cube([spatula_blade_width,spatula_blade_macick1,height]);
                }
                translate([0,spatula_shaft_length,-bugfix]) {
                    cylinder(r=spatula_shaft_width/2, h=height+bugfix*2);
                }
                translate([spatula_blade_width,spatula_shaft_length,-bugfix]) {
                    cylinder(r=spatula_shaft_width/2, h=height+bugfix*2);
                }
            }
            translate([spatula_shaft_width/2,spatula_blade_macick2,0]) {
                cylinder(d=spatula_shaft_width, h=height);
            }
            translate([spatula_shaft_width+spatula_shaft_width/2,spatula_blade_macick2,0]) {
                cylinder(d=spatula_shaft_width, h=height);
            }
            translate([0,spatula_shaft_length+spatula_blade_macick1*2,0]) {
                cube([spatula_blade_width,spatula_length-spatula_blade_macick2+1,height]);
            }
        }
        translate([spatula_blade_width/2,spatula_shaft_width/2,-bugfix]) {
            cylinder(d=spatula_shaft_width/2,h=height+bugfix*2);
        }
        translate([0,spatula_shaft_length+spatula_blade_macick1*2,height]) {
            rotate([spatula_cut_angle,0,0]) {
                cube([spatula_blade_width,spatula_blade_length,height]);
            }
        }
        if (text_type == "cut" || text_type == "deboss") {
            translate([spatula_text_x,spatula_text_y,-bugfix+(height-_boss_by)]) {
                echo(str("text_type = \"", text_type, "\", height = ", height, ", boss_by = ", boss_by, " and _boss_by = ", _boss_by));
                linear_extrude(_boss_by+bugfix*2) {
                    rotate([0,0,90]) {
                        text("Epoxy", font=font_face, size=font_size);
                    }
                }
            }
        }
    }
    if (text_type == "emboss") {
        translate([spatula_text_x,spatula_text_y,height]) {
            echo(str("text_type = \"", text_type, "\", height = ", height, ", boss_by = ", boss_by, " and _boss_by = ", _boss_by));
            linear_extrude(_boss_by) {
                rotate([0,0,90]) {
                    text("Epoxy", font=font_face, size=font_size, spacing=font_spacing);
                }
            }
        }
    }
}
spatula();
