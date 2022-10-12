use <threadlib/threadlib.scad>

//bolt("M6", turns=10, higbee_arc=30);

//translate([10,0,0]) 
{
//    nut("M10", turns=12, Douter=12);
}

skruetype = "M10";
gjenger=12;

linear_extrude(3) {
    hull() {
        translate([25,0,0]) circle(d=12.5);
        translate([0,0,0]) circle(d=20);
        translate([-25,0,0]) circle(d=12.5);
    }
}
translate([0,0,1]) {
    bolt(skruetype, gjenger);
}