// testdrit

x=30;
y=x;
z=3;

translate([-x/2,-y/2,0]) {
    cube([x,y,z]);
}
translate([0,0,z]) {
    cylinder(h=z/2, d=(x+y)/4, $fn=64);
}