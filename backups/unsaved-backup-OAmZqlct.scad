dia = 301;
dia_skrue = 6;
skrue_rim_dist = 11;
h = 5;
text_h = 1.5;
bugdrit = $preview ? .1 : 0;

echo(str("bugdrit = ", bugdrit));

/*
module circular_text(text_string, radius = 50, inward = true) {
    angle_step = 360 / len(text_string);
    for (i = [0 : len(text_string) - 1]) {
        char = text_string[i];
        angle = i * angle_step;
        rotate([0, 0, angle])
            translate([radius, 0, 0])
                rotate([0, 0, inward ? -90 : 90])
                    text(char, size = 5, valign = "center", halign = "center");
    }
}
*/

module circular_text(text_string, radius = 50, inward = true, arc_degrees = 360) {
    char_count = len(text_string);
    angle_step = arc_degrees / (char_count - 1); // Spread characters evenly across arc
    start_angle = -arc_degrees / 2; // Center the arc

    for (i = [0 : char_count - 1]) {
        char = text_string[i];
        angle = start_angle + i * angle_step;
        rotate([0, 0, angle])
            translate([radius, 0, 0])
                rotate([0, 0, inward ? -90 : 90])
                    text(char, size = 5, valign = "center", halign = "center");
    }
}

module hovedskive() {
    difference() {
        cylinder(h=h, d=dia, $fn = 100);
        for (theta = [ 0 : 45 : 315 ]) {
            echo(str("Rotér ", theta, " grader og lag et høl"));
            rotate([0,0,theta]) {
                translate([0,dia/2-skrue_rim_dist,-bugdrit]) {
                    cylinder(h=h+bugdrit*2, d=dia_skrue, $fn = 32);
                }
            }
        }
    }
}

module logo() {
//    translate([0, 0, h-text_h]) 
    rotate([0,0,90]) {
        linear_extrude(height=h) {
//        circular_text("pinnedyr.no", radius = dia/2-20, inward = true);
            circular_text("pinnedyr.no", radius = dia/2-20, inward = true, arc_degrees = 60);
        }
    }
}

//logo();
hovedskive();