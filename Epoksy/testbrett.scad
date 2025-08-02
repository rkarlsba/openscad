// Parameters
bottom_thickness = 2;
wall_thickness = 1;
height = 8;
top_size = 40;
bottom_size = 35.7;

// Derived parameter
wall_height = height - bottom_thickness;

// Outer shell with absolute coordinates (origin at bottom corner)
module trapezoid_shell(top_len, bottom_len, wall_height) {
    hull() {
        // Bottom square at z = bottom_thickness (starting just above bottom plate)
        translate([0, 0, bottom_thickness])
            linear_extrude(0.1)
                square([bottom_len, bottom_len]);
        // Top square at z = height, properly aligned over bottom
        translate([(bottom_len - top_len)/2, (bottom_len - top_len)/2, height])
            linear_extrude(0.1)
                square([top_len, top_len]);
    }
}

// Inner void to subtract (create hollow)
module inner_void(inner_top, inner_bottom) {
    hull() {
        translate([wall_thickness, wall_thickness, bottom_thickness + wall_thickness])
            linear_extrude(0.1)
                square([inner_bottom, inner_bottom]);
        translate([(inner_bottom - inner_top)/2 + wall_thickness, (inner_bottom - inner_top)/2 + wall_thickness, height])
            linear_extrude(0.1)
                square([inner_top, inner_top]);
    }
}

// Final shape
difference() {
    union() {
        // Bottom plate at z = 0 (no centering, absolute coordinate)
        cube([bottom_size, bottom_size, bottom_thickness]);
        // Outer angled wall shell starting directly above bottom plate (no gap)
        trapezoid_shell(top_size, bottom_size, wall_height);
    }

    // Inner hollow (subtracted)
    inner_top = top_size - 2 * wall_thickness;
    inner_bottom = bottom_size - 2 * wall_thickness;
    inner_void(inner_top, inner_bottom);
}
