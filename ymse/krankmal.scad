difference() {
    circle(d=160);
    for (d = [0 : 72 : 288]) { // Rotér 72 grader hver gang, dvs 360/5
        rotate(d) {
            echo(d);
            translate([0,60]) {
                circle(d=10);
            }
        }
    }
}
