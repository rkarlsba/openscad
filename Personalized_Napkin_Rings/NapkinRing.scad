//CUSTOMIZER VARIABLES
prefixcheat = $preview ? 0.1 : 0;
$fn = $preview ? 16 : 64;

// Name or Text
Text = "Michael";

// Adjust spacing between letters
Degrees = 18; //  [13,14,15,16,17]

Font = "Prime Minister of Canada:style=Regular";
RingThickness = 5;
RingDepth = 10;
TextDepth = RingThickness;
TextLift = 1;
RingRadius = 20;

// Set Torus = true if you want the ring to be a torus, without the
// sharp edges.
Torus = 0;
Torus_r = RingThickness/2;

// Rounded edges
Rounded = 1;
Rounded_r = 1.2;

//CUSTOMIZER VARIABLES END

module roundedsquare(size, radius) {
    hull() {
        translate([radius,radius]) circle(r=radius);
        translate([size[0]-radius, radius]) circle(r=radius);
        translate([radius, size[1]-radius]) circle(r=radius);
        translate([size[0]-radius, size[1]-radius]) circle(r=radius);
    }
}

module L_0(char = "A", Degrees = 15, i = 0) {
    rotate([0,0,-Degrees*i]) {
        translate([0,24,0])  {
            linear_extrude(height = RingDepth+TextLift) {
                text(size = 12, text = char, font = Font, halign = "center", $fn = 32);
            }
        }
    }
}

union() {
    if (Torus) {
        if (RingThickness != RingDepth) {
            echo("NOTE: RingDepth is ignored with Torus as of now");
            RingDepth=RingThickness;
        }
        translate([0,0,Torus_r]) {
            rotate_extrude(angle=360, convexity = 2) {
                translate([RingRadius+RingThickness/2, 0])
                    circle(r=Torus_r);
            }
        }
    } else if (Rounded) {
        rotate_extrude(angle = 360, convexity = 2)
            translate([RingRadius,0,0])
                roundedsquare([RingThickness,RingDepth], Rounded_r);
    } else {
        difference() {
            cylinder(h = RingThickness, r = 25, $fn = 64);
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
