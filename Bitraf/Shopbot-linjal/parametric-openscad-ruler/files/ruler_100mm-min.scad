// 100mm Ruler
// By Chris Leaver 2014

// Import it into your OpenSCAD project and call it with 
// use <ruler_100mm.scad>
// then...
// ruler_mm();
// Offset, duplicate and rotate it as required



module ruler_mm(mark10mm = 1, mark1mm = 1) {
    // main block
    color("gray") {
        cube([100,5,1]);
    }

    // 10mm Index Marks
    if (mark10mm) {
        for (i=[0:10:100]) {
            color("black") {
                translate([i,0,0.01]) {
                    cube([0.4, 4, 1.1]);
                }
            }
        }
    }
    
    // 1mm index marks
    if (mark1mm) {
        for (i=[0:1:100]) {
            color("lightgray") {
                translate([i,0,0.01]) {
                    cube([0.2, 2, 1.08]);
                }
            }
        }
    }
}

ruler_mm(1, 1);