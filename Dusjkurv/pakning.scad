echo($fn);
$fn = $preview ? 8 : 64;
linear_extrude(20) {
    difference() {
        circle(d=22.5);
        circle(d=18);
        translate([-4,0]) {
            square([8,15]);
        }
    }
}