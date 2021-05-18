// Søknad

//use <ymse.scad>


$fn = $preview ? 8 : 64;

xsize = 210;
ysize = 150;
corner_rounding = 6;
line = 1;
hole_radius = 0;
text_height = 1;
fontsize=8.5;
fonttype="Apple Chancery:style=筆寫斜體";
//fonttype="Liberation Sans";
fontspacing=1;
bugaddition = $preview ? 0.1 : 0;

module roundedsquare(size, radius) {
    hull() {
        translate([radius, radius]) circle(r=radius);
        translate([size[0]-radius, radius]) circle(r=radius);
        translate([radius, size[1]-radius]) circle(r=radius);
        translate([size[0]-radius, size[1]-radius]) circle(r=radius);
    }
}

module ramme(size, border=1) {
    difference() {
        square(size);
        translate([border,border])
            square([size[0]-border*2,size[1]-border*2]);
    }
}

difference() {
    hull() {
        linear_extrude(text_height/3)
            roundedsquare([xsize,ysize], corner_rounding);
        translate([text_height,text_height,text_height/3])
            linear_extrude(text_height/3*5)
                roundedsquare([xsize-text_height*2,ysize-text_height*2], corner_rounding);
    }
    translate([text_height+line,text_height+line,text_height])
        linear_extrude(text_height+bugaddition)
            roundedsquare([xsize-text_height*2-line*2,ysize-text_height*2-line*2], corner_rounding);
    if (hole_radius > 0) {
        translate([corner_rounding*1.5,ysize-corner_rounding*1.5,-bugaddition]) {
            cylinder(r=hole_radius,h=text_height+bugaddition*2);
        }
    }
}

translate([8,130,text_height]) {
    linear_extrude(text_height) {
        text("Navn", size=fontsize-1, font=fonttype);
    }
}
translate([40,128,text_height]) {
    linear_extrude(text_height) {
        ramme([80,12]);
    }
}
translate([130,130,text_height]) {
    linear_extrude(text_height) {
        text("F.nr", size=fontsize-1, font=fonttype);
    }
}
translate([8,115,text_height]) {
    linear_extrude(text_height) {
        text("Adresse", size=fontsize-1, font=fonttype);
    }
}
translate([8,85,text_height]) {
    linear_extrude(text_height) {
        text("Postnr", size=fontsize-1, font=fonttype);
    }
}
translate([75,85,text_height]) {
    linear_extrude(text_height) {
        text("Sted", size=fontsize-1, font=fonttype);
    }
}
translate([8,65,text_height]) {
    linear_extrude(text_height) {
        text("Tlf privat", size=fontsize-1, font=fonttype);
    }
}
translate([90,65,text_height]) {
    linear_extrude(text_height) {
        text("Mobil", size=fontsize-1, font=fonttype);
    }
}
