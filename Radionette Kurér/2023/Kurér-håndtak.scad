l_tot=225;
l_holes=163;
w=25;
hol=3.4;
tupp=12.5;

module tupp() {
    circle(d=tupp);
}

module stor(d=w, hol=hol) {
    difference() {
        circle(d=w, $fn=64);
    }
}

linear_extrude(height=4) {
    difference() {
        hull() {
            tupp();
            translate([w,0,0]) {
                stor();
                translate([l_holes,0]) {
                    stor();
                    translate([w,0,0]) {
                        tupp();
                    }
                }
            }
        }
        hull() {
            translate([w-2,0,0]) circle(d=hol, $fn=64);
            translate([w+2,0,0]) circle(d=hol, $fn=64);
        }
        hull() {
            translate([l_holes+w-2,0]) circle(d=hol, $fn=64);
            translate([l_holes+w+2,0]) circle(d=hol, $fn=64);
        }
    }
}