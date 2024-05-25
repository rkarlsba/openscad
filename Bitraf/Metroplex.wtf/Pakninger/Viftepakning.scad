/*
 * Viftepakning - skrives ut i TPU i 92A eller noe
 */

$fn = $preview ? 32 : 128;

hjorne_d = 8;
vifte_x = 40;
vifte_y = vifte_x;
viftesirkel_kant = 1.25;
viftesirkel_d = (vifte_x < vifte_y) ? 
    vifte_x-viftesirkel_kant*2 : vifte_y-viftesirkel_kant*2;
skruehull_d = 4;
tykkelse = 1.5;

module roundedsquare(size, radius) {
    if (radius == 0) {
        square(size);
    } else {
        hull() {
            translate([radius, radius]) circle(r=radius);
            translate([size[0]-radius, radius]) circle(r=radius);
            translate([radius, size[1]-radius]) circle(r=radius);
            translate([size[0]-radius, size[1]-radius]) circle(r=radius);
        }
    }
}

linear_extrude(height = tykkelse) {
    difference() {
        union() {
            roundedsquare([vifte_x,vifte_y], hjorne_d/2);
        }
        union() {
            translate([hjorne_d/2,hjorne_d/2]) {
                circle(d=skruehull_d);
            }
            translate([vifte_x-hjorne_d/2,hjorne_d/2]) {
                circle(d=skruehull_d);
            }
            translate([hjorne_d/2,vifte_y-hjorne_d/2]) {
                circle(d=skruehull_d);
            }
            translate([vifte_x-hjorne_d/2,vifte_y-hjorne_d/2]) {
                circle(d=skruehull_d);
            }
            translate([vifte_x/2,vifte_y/2]) {
                circle(d=viftesirkel_d);
            }
        }
    }
}