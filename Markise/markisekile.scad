module rettvinklet_trekant(base=25, height=17.5) {
    polygon(points=[ [0,0], [base,0], [0,height] ]);
}

linear_extrude(10) {
    rettvinklet_trekant();
}

translate([0,-20]) {
    linear_extrude(7.5) rettvinklet_trekant();
}

