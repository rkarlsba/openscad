// Pakkelapp

use <ymse.scad>
//use <NoiseLib.scad>

$fn = $preview ? 12 : 64;

corner_rounding = 3;
line = 1;
hole_radius = 0;
label_thickness = 1;
text_thickness = 2;
fontsize=10;
//fonttype="Apple Chancery:style=筆寫斜體";
//fonttype="Liberation Sans";
fonttype="Prime Minister of Canada:style=Regular";
fontspacing=1.13;
bugaddition = $preview ? 0.1 : 0;

module ramme(xsize,ysize) {
    difference() {
        hull() {
            linear_extrude(label_thickness/3)
                roundedsquare([xsize,ysize], corner_rounding);
            translate([label_thickness,label_thickness,label_thickness/3])
                linear_extrude(label_thickness/3*5)
                    roundedsquare([xsize-label_thickness*2,ysize-label_thickness*2], corner_rounding);
        }
        translate([label_thickness+line,label_thickness+line,label_thickness])
            linear_extrude(label_thickness+bugaddition)
                roundedsquare([xsize-label_thickness*2-line*2,ysize-label_thickness*2-line*2], corner_rounding);
        if (hole_radius > 0) {
            translate([corner_rounding*1.5,ysize-corner_rounding*1.5,-bugaddition]) {
                cylinder(r=hole_radius,h=label_thickness+bugaddition*2);
            }
        }
    }
}

module tekst(tekst, storrelse, font=fonttype, spacing=fontspacing, position=[0,0,0]) {
    base_position = [6,7.5,label_thickness];
    translate(base_position+position) {
        linear_extrude(text_thickness) {
            text(tekst, size=storrelse, font=font, spacing=spacing);
        }
    }
}

ramme(144,50);
tekst("Nei takk", fontsize+6.5, font=fonttype, spacing=fontspacing, position=[3,18,0]);
tekst("til", fontsize, font=fonttype, spacing=fontspacing, position=[110,16,0]);
tekst("uadressert reklame", fontsize-1.3, font=fonttype, spacing=fontspacing, position=[0,0,0]);
;
a=[1,2,3];
b=[10,20,0];
c=a+b;
echo(c);