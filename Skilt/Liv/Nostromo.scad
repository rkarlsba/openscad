use <ymse.scad>;

$fn = $preview ? 10 : 64;

name = "Nostromo";
//font = "Academy Engraved LET:style=Plain";
font = "Helvetica:style=Bold";
textheight = 1;
base = [160,30,2];
textsize = base[1]*.8;
rounding = 1.5;

// Base
linear_extrude(base[2]) {
    roundedsquare([base[0], base[1]], rounding);
}

translate([base[0]/40, base[1]/10, base[2]]) {
    linear_extrude(textheight) {
        text(font=font, text=name, size=textsize);
    }
}