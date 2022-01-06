module ramme(xy, bredde) {
    difference() {
        cube([xy,xy,1], center=true);
        cube([xy-bredde,xy-bredde,1], center=true);
    }
}

ramme(280, 10);
ramme(240, 10);
ramme(180, 10);
ramme(130, 10);
ramme(80, 10);
ramme(30, 10);