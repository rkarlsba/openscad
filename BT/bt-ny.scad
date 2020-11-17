$fn = 64;

font = "Palatino";
font_size = 35;
tykkelse = 1;
fres = .3;
content_b = "β";
content_t = "τ";

//translate([0,-90,0]) {
    cylinder(r=40,h=tykkelse-fres);
    translate ([-19.5,-11,0]) {
        linear_extrude(height = tykkelse*3) {
            text(content_b, font = font, size = font_size*1.3);
        }
    }
    translate ([-10,-33,0]) {
        linear_extrude(height = tykkelse*3) {
            text(content_t, font = font, size = font_size/1.15);
        }
    }
//}
