include <BOSL2/std.scad>;

// ===== parametre =====
size   = 150;
pitch  = 20;
angle  = 30;
wall   = 2;

// korrekt kompensasjon
scale_fix = sqrt(2);

// ===== profiler =====
rail = [
    [0, 0],
    [10, 5],
    [20, 0],
    [10, 10]
];

// enkel, litt mindre versjon (innside)
neg_rail = [
    [2, 2],
    [10, 6],
    [18, 2],
    [10, 8]
];

fixed_rail     = rail * scale_fix;
fixed_neg_rail = neg_rail * scale_fix;

// ===== path (SENTRERT!) =====
square_path = [
    [-size/2, -size/2, 0],
    [ size/2, -size/2, 0],
    [ size/2,  size/2, 0],
    [-size/2,  size/2, 0]
];

// ===== ramme =====
module frame() {
    difference() {
        path_sweep(fixed_rail, square_path, closed=true);
        path_sweep(fixed_neg_rail, square_path, closed=true);
    }
}

// ===== gitterlinjer =====
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

// ===== kryssgitter =====
module grid() {
    union() {
        grid_lines(size, pitch, angle);
        grid_lines(size, pitch, angle + 90);
    }
}

// ===== ferdig modell =====
union() {

    // ramme
    frame();

    // gitter – KUN klippet mot innsida
    intersection() {
        path_sweep(fixed_neg_rail, square_path, closed=true);
        grid();
    }
}
