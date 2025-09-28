$fn = 512;
// font = ".Helvetica LT MM:style=Regular";
// font = "Avenir:style=Light";
font = "Avenir Next Condensed:style=Regular";
tekst = "4%";
height = 2;
underline = 1;

translate([0,underline,0]) {
    text(tekst, font=font, spacing=.7);
}
square([20,underline]);
