$fn = 256;

include <kim-merke.scad>;

luna_font = "Herculanum:style=Regular";
content_b = "β";
content_t = "τ";
bt_font = "Palatino";
bt_font_size = 35;
//herjan_content = "ᚺᛖᚱᛃᚨᚾ";
herjan_content = "herjan";
herjan_font = "Elder Futhark:style=Bold";
herjan_font_size = 11.5;

// Luna
resize([40,0,0], auto=true) {
    difference() {
        circle(r=40);
        translate ([-40,-22]) {
            text("L", font = luna_font, size = 50);
        }
        translate ([-25,-14]) {
            text("una", font = luna_font, size = 20);
        }
        translate ([-3,22]) {
            difference() {
                circle(r=17);
                translate ([3,3]) {
                    circle(r=17);
                }
            }
        }
    }
}

// Sara
resize([40,0,0], auto=true) {
    translate([95,-95,0]) {
        difference() {
            circle(r=40);
            translate ([-35,-11]) {
                text("Sara", font = "Marker Felt", size = 25);
            }
        }
    }
}

// BT
resize([40,0,0], auto=true) {
    translate([0,-95,0]) {
        difference() {
            circle(r=40);
            translate ([-19.5,-11]) {
                text(content_b, font = bt_font, size = bt_font_size*1.3);
            }
            translate ([-10,-33]) {
                text(content_t, font = bt_font, size = bt_font_size/1.15);
            }
        }
    }
}

module herjan() {
    scale([1.16,1.3]) {
        text("h", font = herjan_font, size = herjan_font_size, spacing=0.61);
        translate([12,0,0]) {
            text("e", font = herjan_font, size = herjan_font_size, spacing=0.61);
            translate([10,0,0]) {
                text("r", font = herjan_font, size = herjan_font_size, spacing=0.61);
                translate([9,-1,0]) {
                    text("j", font = herjan_font, size = herjan_font_size+1, spacing=0.61);
                    translate([10,1,0]) {
                        text("a", font = herjan_font, size = herjan_font_size, spacing=0.61);
                        translate([8.5,0,0]) {
                            text("n", font = herjan_font, size = herjan_font_size, spacing=0.61);
                        }
                    }
                }
            }
        }
    }
}    
// Herjan
resize([40,0,0], auto=true) {
    translate([95,0,0]) {
        difference() {
            circle(r=40);
            translate ([-38,-15]) {
                herjan();
            }
        }
    }
}

translate([0,-95,0]) {
scale(.9,0,0) {
    difference() {
            circle(r=22);
            translate([-20,-20,0]) {
                kim_merke(tode = 1);
            }
        }
    }
}