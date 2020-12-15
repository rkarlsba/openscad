//CUSTOMIZER VARIABLES
prefixcheat = $preview ? 0.1 : 0;

// Name or Text
Text = "Helga";

// Adjust spacing between letters
Degrees = 18; //  [13,14,15,16,17]

//Font = "Trattatello";
//Font = "Trattatello:style=Bold";
//Font = "Apple Chancery:style=筆寫斜體";
Font = "Herculanum:style=Regular";

// Set Torus = true if you want the ring to be a torus, without the
// sharp edges.
Torus = 0;
Torus_r = 3;

//CUSTOMIZER VARIABLES END

module L_0(char = "A", Degrees = 15, i = 0) {
    rotate([0,0,-Degrees*i])
    translate([0,24,0])
    linear_extrude(height = 6)
//    text(size = 12, text = char, font = "Chewy:style=bold", halign = "center", valign= "bottom", $fn = 32);
    text(size = 12, text = char, font = Font, halign = "center", $fn = 32);
}

union() {
    if (Torus) {
        translate([0,0,Torus_r/2]) {
            rotate_extrude(angle=360, convexity = 2) {
                translate([25, 0])
                    circle(r=Torus_r);
            }
        }
    } else {
        difference() {
            cylinder(h = 5, r = 25, $fn = 64);
            translate([0,0,-prefixcheat])
                cylinder(h = 5+prefixcheat*2, r = 20, $fn = 64);
        }
    }
    
    union() {
        for (i = [0:len(Text)-1]) {
            L_0(Text[i], Degrees, i);
        }
    }
}
