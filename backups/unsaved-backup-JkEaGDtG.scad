use <ymse.scad>

sign_size = [200.475,141.75];
corner_r = 5;
border_w = 3;
sign_size_net = sign_size-[border_w*2,border_w*2];
sign_thickness = 2;
border_thickness = sign_thickness/2;
text_thickness = border_thickness;

// Background
linear_extrude(sign_thickness) {
    roundedsquare(sign_size, corner_r, $fn=64);
}
translate([0,0,sign_thickness]) {
    // Border
    color("Red") {
        linear_extrude(border_thickness) {
            difference() {
                roundedsquare(sign_size, corner_r, $fn=64);
                translate([border_w,border_w]) {
                    roundedsquare(sign_size_net, corner_r, $fn=64);
                }
            }
        }
    }
    color("Black") {
        linear_extrude(text_thickness) {
            import("bitraf-2d-skriver-skilt.svg");
        }
    }
}
