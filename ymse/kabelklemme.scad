// Kabelklemme

radius = 20;
angles = [45, 290];
width = 2;
fn = 180;

module sector(radius, angles, fn = fn) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 361]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = fn) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

module klemme() {
    linear_extrude(1) {
        arc(radius, angles, width);
    }
}

klemme();
