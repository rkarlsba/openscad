original = false;

module bottom2() {
    translate([-44.7,-17.05,285]) {
        import("/Users/roy/Downloads/Voronoi_Lamp/files/bottom2.stl");
    }
}

if (original) {
    bottom2();
} else {
    
    difference() {
        bottom2();
        translate([-1,-1,25]) {
            cube([82,82,45]);
        }
    }
    translate([0,0,8]) {
        difference() {
            bottom2();

            translate([-1,-1,-1]) {
                cube([82,82,18]);
            }
        }
    }
}

/*
difference() {
    bottom2();

    translate([-1,-1,-1]) {
        cube([82,82,20]);
    }

    translate([-1,-1,28]) {
        cube([82,82,20]);
    }
}
*/