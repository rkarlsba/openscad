textsize=8;
textheight=3;
textspacing=1.2;
textlift=3;
textfont="Big Caslon:style=中黑";

linear_extrude(textheight) {
    translate([0, textlift]) {
        translate([0,textheight*8]) {
            text("ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ", size=textsize, font=textfont, spacing=textspacing);
        }
        translate([0,textheight*4]) {
            text("abcdefghijklmnopqrstuvwxyzæøå", size=textsize, font=textfont, spacing=textspacing);
        }
        translate([0,textheight*0]) {
            text("!@#$%^&*()-?€£°", size=textsize, font=textfont, spacing=textspacing);
        }
    }
}