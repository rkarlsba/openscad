// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker:si
//
// Button Generator
// KrisWillCode
// 19 Jan 2022
//
// 2024-03-06:
// Roy Sigurd Karlsbakk <roy@karlsbakk.net> 
// Added scaling and beautified the code a bit by
// 

// VARIABLES - for most users

// Diameter of button [mm]
button_diameter = 20.0;  
// Button scale [x,y,z] - keep z to one (1) for normal stuff
button_scale = [1.6,1,1];
// Height of button (without lip or center) [mm]
button_height = 2.0; // [0.1:0.1:10.0]
// Button bottom chamfer [mm]
bottom_chamfer = 0.4; // [0.0:0.1:1.0]
// Outer lip width [mm]
lip_width = 3.0; // [0.0:0.1:50.0]
// Outer lip height [mm]
lip_height = 1.0; // [0.0:0.1:10.0]
// Raised center
center_rounded = "F"; // [F:Flat, R:Round]
// Raised center width [mm]
center_width = 14.0; // [0.0:0.1:100.0]
// Raised center height [mm]
center_height = 1.0; // [0.0:0.1:10.0]
// Number of button holes [#]
hole_count = 2; // [0:1:12]
// Diameter of button holes [mm]
hole_diameter = 2; // [0.0:0.1:10.0]
// Button hole center offset [mm]
hole_offset = 3; // [0.0:0.1:50.0]

// MAIN CODE - for hackers and the likes

// Quality (+ 0 to hide from customizer)
$fa=4 + 0;
$fs=0.2 + 0;

// Derived
$but_rad = button_diameter / 2;
$lip_rad = min(lip_width / 2, button_diameter / 4);
$cen_rad = min(center_rounded == "R" ? (center_width / 2) : center_height, $but_rad); 
$cen_pts = [ for($a = [0:1:90]) [$cen_rad * cos($a), center_height * sin($a)] ];
$lip_pts = [ for($a = [0:1:180]) [$lip_rad * cos($a), lip_height * sin($a)] ];
$bot_pts = [ for($a = [270:1:360]) [bottom_chamfer * cos($a), bottom_chamfer * sin($a)] ];

difference() {
    scale(button_scale) {
        rotate_extrude() {
            // Draw center of button
            if (button_height - bottom_chamfer > 0) {
                translate([0, bottom_chamfer, 0]) {
                    square([$but_rad, button_height - bottom_chamfer]);
                }
            }
      
            // Draw bottom of button
            square([$but_rad - bottom_chamfer, bottom_chamfer]);
          
            // Draw bottom chamfer of button
            translate([$but_rad - bottom_chamfer, bottom_chamfer, 0]) {
                polygon(concat([[0, 0]], $bot_pts));
            }
          
            // Draw raised center of button
            if (center_rounded == "R") {
                translate([0, button_height, 0]) {
                    polygon(concat([[0, 0]], $cen_pts));
                }
            } else {
                if ($cen_rad > 0) {
                    translate([0, button_height, 0]) {
                        square([center_width / 2 - $cen_rad, $cen_rad]);
                    }
                }
              
                translate([center_width / 2 - $cen_rad, button_height, 0])
                    polygon(concat([[0, 0]], $cen_pts));
            }
          
            // Draw lip of button
            translate([$but_rad - $lip_rad, button_height, 0]) {
                polygon(concat([[0, 0]], $lip_pts));
            }
        }
    }
  
    // Subtract button holes
    for($a = [0:(360 / hole_count):360]) {
        translate([hole_offset * cos($a), hole_offset * sin($a), 0]) {
            cylinder(h=button_height + max(center_height, lip_height), d=hole_diameter);
        }
    }
}
