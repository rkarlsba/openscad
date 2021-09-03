/*
 * Spare part for staple remover
 */
/*
small();   // for narrower end
translate([40,0,0]) {
    big();   // for wider end
}
*/
small();

// Her trenger du nok ikke to separate polyhedron-er. Det hadde vært lettere med én vinge og mirror().
module wings () {
    points1 = [
        [-7,1,0],
        [-19,6,0],
        [-19,6,12],
        [-7,1,19],
        [-7,6,0],
        [-19,9,0],
        [-19,9,12],
        [-7,6,19]
    ];
    faces1 = [
        [0,4,5,1],
        [0,1,2,3],
        [4,7,6,5],
        [1,5,6,2],
        [2,6,7,3],
        [0,3,7,4]
    ];
    
    points2 = [
        [7,1,0],
        [19,6,0],
        [19,6,12],
        [7,1,19],
        [7,6,0],
        [19,9,0],
        [19,9,12],
        [7,6,19]
    ];
    faces2 = [
        [0,4,5,1],
        [0,1,2,3],
        [4,7,6,5],
        [1,5,6,2],
        [2,6,7,3],
        [0,3,7,4]
    ];

    polyhedron(points = points1, faces = faces1);
    polyhedron(points = points2, faces = faces2);
}

module block () {
    wings();
    translate ([-7,0,0]){
        cube([14,6,19]);
    }
}

module small () {
    translate ([0,3.5,11]){
        sphere (d=2, $fn=25);
    }
    difference () {
        block ();
        translate ([-3.25,0,0]) {
            cube ([6.5,3,19]);
        }
        translate ([-5.1,1.9,7]) {
            cube ([10.2,1.1,12]);
        }
    }
}

module big () {
    translate ([0,3.5,11]) {
        sphere (d=2, $fn=25);
    }
    difference () {
        block();
        translate ([-4.25,0,0]) {
            cube ([8.5,3,19]);
        }
        translate ([-6.5,1.9,7]) {
            cube ([13,1.1,12]);
        }
    }
}

