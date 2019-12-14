/* I found this on the net somewhere and rewrote it to
 * use absolute positioning (the old one used center=yes,
 * which is ugly). This one also adds a stick to help keep
 * the ball stuck to the frame during printing, and boolean
 * varaiables to help configuring the thing.
 *
 * BUGS
 *
 * 'wall' was originally radius / 2 hardcoded all over, but is
 * now now separated as a variable. Still, it's wrong somehow, since
 * if this is changed, the outer dimensions aren't changed. I need
 * to work with this.
 * 
 * Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 *
 * Licensed under GPL v3 https://www.gnu.org/licenses/gpl-3.0.en.html
 */

/* Configuration */
radius = 20; // En bordtennisball er 40mm i diameter
draw_ball = 1;
use_stick = 1; // Won't work without the ball
wall = radius / 2;
height = radius*4;

/* Internals */
stick_height = radius/4;
stick_width = radius/5;

/* Code */
echo(radius = radius, height = height, wall = wall, use_stick = use_stick, draw_ball = draw_ball);
cube([radius*2+wall,radius*2+wall,wall]);

translate([0, 0, wall]) {
    cube([radius/2,radius/2, height]);
}
translate([0, radius*2, wall]) {
    cube([wall,wall,height]);
}
translate([radius*2, 0, wall]) {
    cube([wall,wall,height]);
}
translate([radius*2, radius*2, wall]) {
    cube([wall,wall,height]);
}

translate([0, 0, height+wall]) {
    cube([radius*2+wall,radius*2+wall,wall]);
}

if (draw_ball) {
    $fn=256;
    if (use_stick) {
        translate([radius*1.25,radius*1.25,wall]) {
            cylinder(h=stick_height,d=stick_width);
        }
    }
    translate([radius*1.25,radius*1.25,radius*1.5]) {
        sphere(r=radius);
    }
}