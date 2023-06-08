include <box.scad>
width = 100;
depth = 100;
height = 300;
thickness = 3.6;
inner = true; // Alle verdier er indre verdier
open = true; // ikke lukka boks
extra = thickness + 2;

assemble = false;
labels = true;

want_lid = true;
want_simple_lid = true;

if (assemble) {
    draw_box();
    if (want_lid) {
        translate([-extra, -extra, height - 4 * thickness]) {
            draw_lid();
        }
    }
} else {
    draw_box();
    if (want_lid) {
        translate([0,height+depth+thickness]) {
            draw_lid();
        }
    }
    if (want_simple_lid) {
        translate([width*1.14,height+depth+thickness+width*.3]) {
            draw_simple_lid();
        }
    }
}

module draw_box() {
    box(
        width = width,
        height = height,
        depth = depth,
        thickness = thickness,
        open = true,
        inset = 2 * thickness,
        assemble = assemble
    );
}

module draw_lid() {
    box(
        width = width + 2 * extra,
        height = 6 * thickness,
        depth = depth + 2 * extra,
        thickness = thickness,
        open = true,
        inset = 4 * thickness,
        assemble = assemble
    );
}

module draw_simple_lid() {
    square([width+thickness*2,depth+thickness*2]);
}
