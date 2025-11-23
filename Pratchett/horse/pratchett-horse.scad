$fn = 200;


d = 100;
s = .6;
ih = 2;
th = 1;
t = h*2;

scale([1,s]) {
    cylinder(d1=d, d2=d-t, ih=h);
}
translate([0,0,ih]) {
    linear_extrude(th) {
        import(
    }
}
