ytterkant = [
    [0, 0], [60, 0], 
    [60, 41.4], [58, 41.4],
    [57.3, 40], [56.6, 41.4],
    [45, 41.4], [17.3, 13.5],
    [0, 13.5], 
];

innerkant = [
    [0, 0], [14, 0],
    [14, 15.25]
];

bottom=1;

module trekant() {
    translate([0,60,0]) {
        linear_extrude(2) {
            rotate([0,0,270]) {
                difference() {
                    polygon(ytterkant);
                    translate([31,13.5]) {
                        polygon(innerkant);
                    }
                }
            }
        }
    }
}

if (bottom) {
    difference() {
        union() {
            trekant();
            mirror([0,1,0]) {
                trekant();
            }
        }
        // 10mm index Marks
        for (i=[0:10:41]) {
            translate([i-.2,0,0.9]) {
                cube([0.4, 4, 1.1]);
            }
        }
        // 10mm text    
        for (i=[10:10:40]) {
            translate([i-.8,8,0.9]) {
                linear_extrude(1.1) {
                    rotate([0,0,270])
                    text(str(i), size=2);
                }
            }
        }
        // 1mm index marks
        for (i=[0:1:41]) {
            translate([i-.1,0,0.9]) {
                cube([0.2, 2, 1.1]);
            }
        }
    }
} else {
    // 10mm index Marks
    for (i=[0:10:41]) {
        translate([i-.2,0,0.9]) {
            cube([0.4, 4, 1.1]);
        }
    }
    // 10mm text    
    for (i=[10:10:40]) {
        translate([i-.8,8,0.9]) {
            linear_extrude(1.1) {
                rotate([0,0,270])
                text(str(i), size=2);
            }
        }
    }
    // 1mm index marks
    for (i=[0:1:41]) {
        translate([i-.1,0,0.9]) {
            cube([0.2, 2, 1.1]);
        }
    }
}