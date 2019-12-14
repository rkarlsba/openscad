// Skilt
$fn = 64;

width = 95;
height = 70;
thickness = 4;
letter_thickness = 2;
//font = "Liberation Sans";
border = 1;

font1 = ".SF Compact Text:style=Light";
font2 = ".SF Compact Text:style=Heavy Italic";

difference() {
    cube([width, height, thickness]);
    translate([border,border,border]) {
        cube([width-border*2, height-border*2, thickness]);
    }
}
translate([0, 0, thickness]) {
    translate([7,47,0]) {
        linear_extrude(height = letter_thickness) {
            text("Her bor", size = 14, font = font1);
        }
        translate([12,-35,0]) {
            linear_extrude(height = letter_thickness) {
                text("Roy", size = 26, font = font2);
            }
        }
    }
}