$fn = 64;

// The module torus() takes two parameters, r for radius, measuring the *inner*
// radius, and h for height, for relative height compared to thickness.

module torus(d,t,h=1) {
    center_d = (d/2 + t/2);
    scale([1,1,h]) {
        rotate_extrude(convexity = 10, $fn = 144) { 
            translate([center_d, 0, 0]) {
                circle(d = t);
            }
        }
    }
}

torus(d=12,t=1,h=1.9);
