// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
//
// Epoxy (or something) spatula for use with the epoxy organizer at
// https://www.printables.com/model/1373207-epoxy-organizer. I found that the
// original I used, was too fancy with the handle being thicker, gradually
// thinning towards the front. This is all well, but if you try to stack such
// things, it all becomes a sad tower.
//
// Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net> in August 2025.
//
// Licensed under Creative Commons BY-NC-SA v4.0 or later. Please see
// https://creativecommons.org/licenses/by-nc-sa/4.0/ for details.

$fn = 100;

module spatula() {
    bugfix = $preview ? .1 : 0;

    font_face = "Keania One:style=Regular"; 
    font_size = 6;
    font_spacing = 1.1;

    spatula_thickness = 3.9;
    spatula_tip_thickness = 0.4;    // Two layers should do
    spatula_blade_width = 20;
    spatula_blade_length = 12.4;
    spatula_shaft_width = 10;
    spatula_shaft_length = 35;
    spatula_shaft_padding = 5;
    spatula_blade_macick1 = 4;
    spatula_blade_macick2 = 43.6;
    spatula_length = 55;
    spatula_taper_angle = -atan((spatula_thickness - spatula_tip_thickness) / spatula_blade_length);
    spatula_logo_y = 9.5;
    spatula_logo_x = 12.4;

    logo_enabled = true;            // Draw logo?
    logo_type = "emboss";           // Choose between "cut", "emboss" or "deboss"
    logo_boss_by = 0.4;             // Emboss or deboss by this amount. 

    module tapered_blade() {
        // Create a block of full spatula_thickness at base
        translate([0, 0, 0]) {
            rotate([270,0,270]) {
                linear_extrude(height=spatula_blade_width) {
                    polygon(points=[
                        [0, -4],
                        [spatula_blade_width, -4],
                        [spatula_blade_width, spatula_tip_thickness],
                        [0, spatula_thickness]
                    ]);
                }
            }
        }

        // Use a scale or hull to taper thickness towards tip
    }

    // Internals
    assert(logo_enabled && (logo_type == "cut" || logo_type == "emboss" || logo_type == "deboss"),
        "We don't support that. RTFS!");
    _logo_boss_by = (logo_type == "cut") ? spatula_thickness : logo_boss_by;

    // Debug
    echo(str("spatula_taper_angle = ", spatula_taper_angle));

    // Main code
    difference() {
        union() {
            translate([spatula_blade_width/2,spatula_shaft_width/2,0]) {
                cylinder(d=spatula_shaft_width, h=spatula_thickness);
            }
            translate([spatula_shaft_width/2,spatula_shaft_width/2,0]) {
                cube([spatula_shaft_width,spatula_shaft_length+spatula_shaft_padding,spatula_thickness]);
            }
            difference() {
                translate([0,spatula_shaft_length,0]) {
                    cube([spatula_blade_width,spatula_blade_macick1,spatula_thickness]);
                }
                translate([0,spatula_shaft_length,-bugfix]) {
                    cylinder(r=spatula_shaft_width/2, h=spatula_thickness+bugfix*2);
                }
                translate([spatula_blade_width,spatula_shaft_length,-bugfix]) {
                    cylinder(r=spatula_shaft_width/2, h=spatula_thickness+bugfix*2);
                }
            }
            translate([spatula_shaft_width/2,spatula_blade_macick2,0]) {
                cylinder(d=spatula_shaft_width, h=spatula_thickness);
            }
            translate([spatula_shaft_width+spatula_shaft_width/2,spatula_blade_macick2,0]) {
                cylinder(d=spatula_shaft_width, h=spatula_thickness);
            }
            translate([0,spatula_shaft_length+spatula_blade_macick1*2,0]) {
                cube([spatula_blade_width,spatula_length-spatula_blade_macick2+1,spatula_thickness]);
            }
        }
        translate([spatula_blade_width/2,spatula_shaft_width/2,-bugfix]) {
            cylinder(d=spatula_shaft_width/2,h=spatula_thickness+bugfix*2);
        }
        translate([0,spatula_shaft_length+spatula_blade_macick1*2,spatula_thickness]) {
            rotate([spatula_taper_angle,0,0]) {
                cube([spatula_blade_width,spatula_blade_length*2,spatula_thickness*10]);
            }
        }
        if (logo_enabled && (logo_type == "cut" || logo_type == "deboss")) {
            translate([spatula_logo_x,spatula_logo_y,-bugfix+(spatula_thickness-_logo_boss_by)]) {
                echo(str("logo_type = \"", logo_type, "\", spatula_thickness = ", spatula_thickness, ", logo_boss_by = ", logo_boss_by,
                    " and _logo_boss_by = ", _logo_boss_by));
                    linear_extrude(_logo_boss_by+bugfix*2) {
                    rotate([0,0,90]) {
                        text("Epoxy", font=font_face, size=font_size);
                    }
                }
            }
        }
    }
    if (logo_enabled && logo_type == "emboss") {
        translate([spatula_logo_x,spatula_logo_y,spatula_thickness]) {
            echo(str("logo_type = \"", logo_type, "\", spatula_thickness = ", spatula_thickness, ", logo_boss_by = ", logo_boss_by,
                " and _logo_boss_by = ", _logo_boss_by));
            linear_extrude(_logo_boss_by) {
                rotate([0,0,90]) {
                    text("Epoxy", font=font_face, size=font_size, spacing=font_spacing);
                }
            }
        }
    }
}

spatula();
