use <ymse.scad>

sign_size = [200.475,141.750];
text_size = [178.209,111.578];
text_pos = (sign_size-text_size);
text_pos2 = text_pos / 2;
corner_r = 5;
border_w = 3;
sign_size_net = sign_size-[border_w*2,border_w*2];
sign_thickness = 2;
border_thickness = sign_thickness;
text_thickness = sign_thickness;
//skilttekst = "bitraf-2d-skriver-skilt.svg";
//skilttekst = "test124.svg";
skilttekst = "bitraf-2d-skriver-path.svg";

echo(sign_size);
echo(text_size);
echo(text_pos);
echo(text_pos2);

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
//
    translate([text_pos2[0],text_pos2[1]/2]) {
        color("Black") {
            linear_extrude(text_thickness) {
                import(skilttekst);
            }
        }
    }
}
