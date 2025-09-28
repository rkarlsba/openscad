// List of different battery size https://en.wikipedia.org/wiki/List_of_battery_sizes


// Release Notes:
//
// - Version 1.2 by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
//   - Allow for rounded slots 
//
// - Version 1.1
//   - Allow to make hole on the bottom to be able to eject the button cell with a paper clip if gets stuck
//   - Allow multi column build
//   - Spacer is now calculted based on the button cell diameter.
//     The idea is to have more space for the finger when the cell is small

// - Version 1.0
//   - Initial version

// Rounded slots?
rounded_slots = true;

// CR2032: 20 mm diameter, 3.2 mm height
//battery_diameter_mm = 20;
//battery_height_mm = 3.2;

// Text to display on front
//front_text="CR2032";
// Text to display on side
//side_text="CR2032";

// AG13/LR44: 11.6 mm diameter, 5.4 mm height
// On smaller cell, you may need bigger diameter to remove the cell more easily
battery_diameter_mm = 11.8;
battery_height_mm = 5.4;
front_text="LR44";
side_text="AG13/LR44";

// AG10/LR54: 11.6mm diameter, 3.1 height
// On smaller cell, you may need bigger diameter to remove the cell more easily
//battery_diameter_mm = 11.8;
//battery_height_mm = 3.1;
//front_text="LR54";
//side_text="AG10/LR54";

// Nb of battery to hold
slots = 2;

// Nb column
nb_column = 1;

// Whether or not to make hole on bottom. Can help to remove the button cell with a papier clip if your print is to small and the cell stuck
make_hole=1;     // [ 0:No, 1:Yes ]


// Space between battery
spacer = max(1.5,30/battery_diameter_mm);

thickness = battery_height_mm+0.3;
external_length = ((thickness + spacer) * slots) + spacer;
column_width = battery_diameter_mm+5;
external_height = (battery_diameter_mm/2)*1.4;


lateral_font_size = min(external_length/8, 2*external_height/3);
front_font_size = min(column_width/6, external_height/3);

difference() {
    for(i=[0:(nb_column-1)]) {
        translate([i*(column_width-2.5),0,0]) {
            make_column();
        }
    }

    translate([nb_column*(column_width-2.5)+2.1,external_length/2,external_height/2]) {
        rotate([90,0,90]) {
            linear_extrude(height = 1)  {
                text(side_text,size=lateral_font_size,halign="center", valign="center");
            }
        }
    }
}

module make_column() {

    difference() {
        cube([column_width,external_length,external_height]);

        for(i=[0:(slots-1)]) { 
            translate([2.5,spacer+(i*(thickness + spacer)),1]) {
                if (rounded_slots) {
                    translate([battery_diameter_mm/2,0,battery_diameter_mm/2])
                    rotate([270,0,0]) {
                        cylinder(h=thickness, d=battery_diameter_mm, $fn=90);
                    }
                } else {
                    cube([battery_diameter_mm,thickness,battery_diameter_mm]);
                }
            }

            if (make_hole) {
                translate([column_width/2,thickness/2+spacer+i*(spacer+thickness),0]) {
                    cylinder(h=2,r=1,$fn = 60);
                }
            }
        }

        // Translate -1 on Y axis and make a cylinder of +2 on Y Axis, this is only to have a clean preview in OpenScad without having to render
        translate([(column_width)/2, -1, external_height]) {
            rotate([-90,0,0]) {
                cylinder(h=external_length+2, r=(battery_diameter_mm/2)-2, $fn = 90);
            }
        }


        translate([column_width/2,0.4,external_height/4]) {
            rotate([90,0,0]) {
                linear_extrude(height = 1) {
                    text(front_text,size=front_font_size,halign="center", valign="center");
                }
            }
        }
    }

    translate([2.25,0,external_height-0.55]) {
        rotate([-90,0,0]) {
            cylinder(h=external_length,r=0.5,$fn = 30);
        }
    }

}
