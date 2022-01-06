line_width = 0.4;
line_height = 0.4;

/*
linear_extrude(line_height) {
    for (y=[-60:15:60]) {
        translate([-60,y]) {
            square([120+line_width,line_width]);
        }
    }
    for (y=[-45:30:60]) {
        translate([60,y]) {
            square([line_width,15]);
        }
    }

    for (y=[-60:30:45]) {
        translate([-60,y]) {
            square([line_width,15]);
        }
    }
}
*/

for(xy = [40:-10:10]) {
    linear_extrude(line_height) {
        difference() {
            square([xy,xy], center=true);
            square([xy-line_width,xy-line_width], center=true);
        }
    }
}

