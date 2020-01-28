
module ballbearing(inner,outer,d,gap=0.2,fn=30) {
    difference() {
        union() {
            difference() {
                cylinder(d=outer,h=d,$fn=fn);
                cylinder(d=(outer+inner+d)/2,h=d,$fn=fn);
            }
            difference() {
                cylinder(d=(outer+inner-d)/2,h=d,$fn=fn);
                cylinder(d=inner,h=d,$fn=fn);
            }
        }
        translate([0,0,d/2]) rotate_extrude() translate([(inner+outer)/4, 0, 0]) circle(d = (d+2*gap), $fn=fn/2);
    }
    a = 2 * asin(d/((inner+outer)/2));
    b = round(360 / a);
    c = 360 / b;
    for (e = [0:c:360]) {
        rotate([0,0,e]) translate([(inner+outer)/4,0,d/2]) sphere(d=d,$fn=fn);
    }
}

ballbearing(inner=35,outer=80,d=12,gap=0.3,fn=64);