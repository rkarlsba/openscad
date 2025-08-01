dia = 301;
dia_skrue = 6;
skrue_rim_dist = 12;
h = 5;
bugdrit = $preview ? .1 : 0;

echo(str("bugdrit = ", bugdrit));
difference() {
    cylinder(h=h, d=dia, $fn = 100);
    for (theta = [ 0 : 45 : 315 ]) {
        echo(str("Rotér ", theta, " grader og lag et høl"));
        rotate([0,0,theta]) {
            translate([0,dia/2-skrue_rim_dist,-bugdrit]) {
                cylinder(h=h+bugdrit*2, d=dia_skrue, $fn = 32);
            }
        }
    }
}