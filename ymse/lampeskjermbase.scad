module base(diameter) {
    for (i = [0:10:360]) {
        rotate(i) {
            translate([0, diameter / 2]) {
                resize([2,1,1])
                    circle(d = 1, $fn=64);
            }
        }
    }
}

translate([-10/2,-20/2,0])
    linear_extrude(height=60,twist=50,slices=50)
        base(50);
translate([-10/2,-20/2,0])
    linear_extrude(height=60,twist=-60)
        base(50);