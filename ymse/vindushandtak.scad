use <ymse.scad>;

feste=12;
slingring=.75;
$fn = $preview ? 8 : 64;
zz = 25;

module pinne(x1=10, y1=10, z1=zz, z2=feste, width=feste, slingring=slingring) {
    cube([width-slingring,width-slingring,z2]);
    translate([(width-x1-slingring)/2,(width-y1-slingring)/2,z2])
        cube([x1,y1,z1],1);
}

module trekantpinne(d=10, z=zz) {
    translate([d/2-sqrt(2),d/2,z])
        cylinder(h=zz, d=d, $fn=3);
    cube([d,d,z],1);
}

module handtak(lengde=150, bredde=25, feste=feste) {
    difference() {
        roundedcube([bredde,lengde,feste],2);
        translate([feste/2,feste/2,0]) {
            cube([feste,feste,feste]);
        }
    }
}

//translate([0,0,0]) pinne(10, 10);
//translate([20,0,0]) pinne(10, 10, slingring=.65);
//translate([0,0,0]) pinne(9, 9);
//translate([0,0,0]) pinne(8, 8);
//translate([0,0,0]) pinne(11, 11);
//mirror([0,0,1]) translate([0,0,0]) pinne(12, 12);
//translate([40,20,0]) pinne(13, 13, 20, 12, 12);
//translate([-30,0,0]) handtak();
translate([0,0,0]) trekantpinne();
//translate([20,0,0]) trekantpinne(d=12);
//translate([40,0,0]) trekantpinne(d=14);
