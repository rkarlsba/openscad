/* Vim modline {{{
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=80
 * }}} */

include <BOSL2/std.scad>;

// ===== Parametre =====
size = 150;
pitch = 20;
angle = 45;
wall = 2;
height = 20;
inner_margin = 20;   // <-- viktig!

// ===== Rail-profil =====
rail = [
    [0, 0],
    [20, 0],
    [10, 10]
];

neg_rail = [
    [10, 5],
    [10, 10],
    [10, 5]
];

fixed_rail = rail * PI/2;
fixed_neg_rail = neg_rail * PI/2;

echo(fixed_rail);
echo(fixed_neg_rail);

// ===== Path =====
square_path = [
    [0, 0, 0],
    [size, 0, 0],
    [size, size, 0],
    [0, size, 0]
];

// ===== Ramme =====
module frame() {
    path_sweep(fixed_rail, square_path, closed=true);
}

// ===== Gitterlinjer =====
module grid_lines(size, pitch, angle) {
    dx = cos(angle);
    dy = sin(angle);

    n = ceil(size / pitch) * 2;

    for (i = [-n:n]) {
        offset = i * pitch;

        xoff = -dy * offset;
        yoff =  dx * offset;

        path = [
            [xoff - dx*size, yoff - dy*size, 0],
            [xoff + dx*size, yoff + dy*size, 0]
        ];

        path_sweep(
            [[0,0],[wall,0],[wall,wall],[0,wall]],
            path
        );
    }
}

// ===== Kryssgitter =====
module grid() {
    union() {
        grid_lines(size, pitch, angle);
        grid_lines(size, pitch, angle + 90);
    }
}

// ===== Indre klippevolum (REN 2D-basert) =====
module inner_volume() {
    linear_extrude(height=height)
        offset(delta=-inner_margin)
            square([size, size]);
}

// ===== Ferdig =====
difference() {
    union() {

        frame();

        intersection() {
            inner_volume();

            translate([size/2, size/2, 0])
                grid();
        }
    }
    translate([0, 0, -7.5]) {
        frame();
    }
}
// translate([200,0,0])
    // path_sweep(fixed_neg_rail, square_path, closed=true);
