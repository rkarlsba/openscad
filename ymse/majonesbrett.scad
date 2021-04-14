x=120;
y=64;
z1=3;
z2=1.5;
v=2;
r=2;
k=6;

module linjedrit() {
    translate([k,k,z2])
        cube([x,y/2,z2]);
    translate([k,k*2+y/2,z2])
        cube([x,y/2,z2]);
}

difference() {
    cube([x+k*2,y+k*2,z1]);
    linjedrit();
}