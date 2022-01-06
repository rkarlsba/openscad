font_size=11;
font_face="Octin Prison:style=Regular";
text="Parkeringsbevis";

cube([133,20,2]);
translate([4,4,2]) {
    linear_extrude(2) {
        text(text, size=font_size, font=font_face);
    }
}