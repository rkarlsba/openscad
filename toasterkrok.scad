/* Copyleft Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2019
 * Dings for å ersatatte drit fra Plantasjen
 *
 * Lisens  CC BY-NC https://creativecommons.org/licenses/by-nc/4.0/legalcode.no
 * License CC BY-NC https://creativecommons.org/licenses/by-nc/4.0/legalcode
 */

$fn=64;

/*
 * Arguments accepted
 *
 * 'radius'      Inner radius
 * 'diameter'    Not accepted - use radius
 * 'thickness'   Thickness of ring - outer radius = radius+thickness
 * 'height'      Height or width depending on view - height before rotating
 * 'angle'       Angle of arc to draw, 360 being a full circle
 *
 */
module skalk(radius, thickness, height, angle=360) {
    rotate_extrude(convexity = 10, angle=angle)
        translate([radius, 0, 0])
        square([thickness,height]);
}

tykkelse=2.2;
radius=4.7;
radius2=4.3;
//lengde=21.4-radius-radius2;
//lengde=21.7-radius-radius2;
//lengde=22-radius-radius2;
lengde=23.5-radius-radius2;
hoyde=30;

translate([radius,0,0]) {
    rotate([0,0,90])
        skalk(radius=radius, height=hoyde, thickness=tykkelse, angle=180);
    translate([0,radius,0]) {
        cube([lengde,tykkelse,hoyde]);
    }
    translate([lengde,radius-radius2,0])
        rotate([0,0,310])
            skalk(radius=radius2, height=hoyde, thickness=tykkelse, angle=140);
    translate([lengde+radius2,0,0]) {
        cube([tykkelse,tykkelse+10,hoyde]);
        translate([-radius2,tykkelse+10,0])
            skalk(radius=radius2, height=hoyde, thickness=tykkelse, angle=120);
    }
}