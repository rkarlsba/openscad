$fn=64;

yd=6;
id=3;
ydx=5;

difference() {
    cylinder(h=19,d=yd);
    cylinder(h=16,d=id);
}
translate([0,0,16]) {
//    cylinder(h=ydx,d1=yd,d2=yd+ydx);
}
translate([0,0,23]) {
    sphere(d=yd+ydx);
}