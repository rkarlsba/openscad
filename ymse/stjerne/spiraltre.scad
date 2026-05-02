// Resolution
$fn = 0;
$fs = 0.5;
$fa = 3;

radius = 20;
height = 80;     // total høyde på "treet"
steps = 80;      // antall lag
twist = 360;     // total twist i grader

module stjerne(r) {
    for (i = [0:180:180]) {
        rotate([0,0,i]) circle(r=r, $fn=3);
    }
}

module stjerne3d(r, h=1) {
    linear_extrude(height=h)
        stjerne(r);
}

module spiraltre(r_start, h, n, twist_deg) {
    for (i = [0:n]) {
        frac = i / n;
        r = r_start * (1 - frac);
        z = h * frac;
        rot = twist_deg * frac;

        translate([0,0,z])
        rotate([0,0,rot])
            stjerne3d(r, 1);   // høyde = 1 mm plate
    }
}

// kall modulen
spiraltre(radius, height, steps, twist);

