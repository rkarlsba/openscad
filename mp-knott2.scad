$fn = 64;

font = "Helvetica:style=Regular";
font_size=3.5;

/* Mulig bug eller mulig jeg ikke forstår noe her.
 * minkowski() tar høyden til cube() og cylinder() og legger dem sammen,
 * så der må det endres høyde til en minkowski-høyde.
 */
module miniround(size, radius) {
    $fn=64;
    x = size[0]-radius*2;
    y = size[1]-radius*2;
    mh = size[2]/2;

    translate([radius,radius,0]) {
        minkowski() {
            cube([x,y,mh]);
            cylinder(r=radius, h=mh);
        }
    }
}

module inniknott(height, width, length) {
    translate([-(length-width)/2,0,0])
        hull() {
            cylinder(h=height,d=width);
            translate([length-width,0,0])
                cylinder(h=height,d=width);
        }
}

module mpknott(x, y, radius, bunnh, topph, indreb, indreh, vegg) {
    miniround([x,y,bunnh], radius);
    translate([x/2,y/2,bunnh]) {
        difference() {
            inniknott(height=topph, width=indreb+vegg, length=indreh+vegg);
            inniknott(height=topph, width=indreb, length=indreh);
        }
    }
    tekst=(str("b:", indreb, " h:", indreh, " v:", vegg));
    translate ([2,2,bunnh]) {
        linear_extrude(height = 1.2) {
            text(tekst, font = font, size = font_size);
        }
    }
}


mpknott(40, 30, 2, 2, 15, 9, 13, 3);

