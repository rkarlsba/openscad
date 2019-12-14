$fn = 64;

font = "Herculanum:style=Regular";
font_size = 20;
tykkelse = 1;
fres = .3;

difference() {
    cylinder(r=40,h=tykkelse);
    translate ([-40,-22,tykkelse-fres]) {
        linear_extrude(height = fres) {
            text("L", font = font, size = 50);
        }
    }
    translate ([-25,-14,tykkelse-fres]) {
        linear_extrude(height = fres) {
            text("una", font = font, size = 20);
        }
    }
    translate ([-3,22,tykkelse-fres]) {
        difference() {
            cylinder(r=17,h=fres);
            translate ([3,3,0]) {
                cylinder(r=17,h=fres);
            }
        }
    }
}


translate([90,0,0]) {
    cylinder(r=40,h=tykkelse-fres);
    translate ([-40,-22,0]) {
        linear_extrude(height = tykkelse) {
            text("L", font = font, size = 50);
        }
    }
    translate ([-25,-14,0]) {
        linear_extrude(height = tykkelse) {
            text("una", font = font, size = 20);
        }
    }

    translate ([-3,22,tykkelse-fres]) {
        difference() {
            cylinder(r=17,h=tykkelse-fres);
            translate ([3,3,0]) {
                cylinder(r=17,h=tykkelse-fres);
            }
        }
    }
}

content_b = "β";
content_t = "τ";
bt_font = "Palatino";
bt_font_size = 35;

translate([0,-90,0]) {
    cylinder(r=40,h=tykkelse-fres);
    translate ([-19.5,-11,0]) {
        linear_extrude(height = tykkelse) {
            text(content_b, font = bt_font, size = bt_font_size*1.3);
        }
    }
    translate ([-10,-33,0]) {
        linear_extrude(height = tykkelse) {
            text(content_t, font = bt_font, size = bt_font_size/1.15);
        }
    }
}