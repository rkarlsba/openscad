$fn = 64;

font = "Herculanum:style=Regular";
font_size = 20;
tykkelse = 1;
fres = .3;

//surface(file = "Hammer_and_sickle-l1.png", convexity = 1);
//import(file = "Hammer_and_sickle.dxf", convexity = 4);
difference() {
    
    cylinder(r=40,h=tykkelse);
    cylinder(r=
/*
    linear_extrude(height = 5, center = true, convexity = 10) {
        surface(file = "Hammer_and_sickle-l1.png", convexity = 1);
//        import(file = "Hammer_and_sickle.png", layer = "plate");
    }
/*    translate ([-40,-22,tykkelse-fres]) {
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
    linear_extrude(height = 4) {
        // import("luna-bw.png");
        surface(file = "luna-bw-640.png", convexity = 5);
    }
    */
}


/*
cylinder(r=40,h=1);
translate ([-40,-22,1]) {
    linear_extrude(height = 1) {
        text("L", font = font, size = 50);
    }
}
translate ([-25,-14,1]) {
    linear_extrude(height = 1) {
        text("una", font = font, size = 20);
    }
}

translate ([-3,22,1]) {
    difference() {
        cylinder(r=17,h=1);
        translate ([3,3,0]) {
            cylinder(r=17,h=1);
        }
    }
}
*/