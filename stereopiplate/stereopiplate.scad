$fn = $preview ? 16 : 64;

hull=3.05;
ring=5;
kantbredde=2;

module plate() {
    cube([145,50,4]);
    translate([10,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([25,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([55,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([70,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([85,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([115,10,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([130,10,4]) cylinder(d=hull+kantbredde*2, h=4);

    translate([10,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([25,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([55,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([70,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([85,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([115,40,4]) cylinder(d=hull+kantbredde*2, h=4);
    translate([130,40,4]) cylinder(d=hull+kantbredde*2, h=4);
}

difference() {
    plate();
    translate([10,10,0]) cylinder(d=hull,h=8);
    translate([25,10,0]) cylinder(d=hull,h=8);
    translate([55,10,0]) cylinder(d=hull,h=8);
    translate([70,10,0]) cylinder(d=hull,h=8);
    translate([85,10,0]) cylinder(d=hull,h=8);
    translate([115,10,0]) cylinder(d=hull,h=8);
    translate([130,10,0]) cylinder(d=hull,h=8);

    translate([10,40,0]) cylinder(d=hull,h=8);
    translate([25,40,0]) cylinder(d=hull,h=8);
    translate([55,40,0]) cylinder(d=hull,h=8);
    translate([70,40,0]) cylinder(d=hull,h=8);
    translate([85,40,0]) cylinder(d=hull,h=8);
    translate([115,40,0]) cylinder(d=hull,h=8);
    translate([130,40,0]) cylinder(d=hull,h=8);
}