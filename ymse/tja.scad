//MK3 platen for filter paper on 120mm fan
$fn=100;
//You can adjust the variables below
depth=10;       //depth of lip and fins (10)
platen=1.5;     //thickness of platen (1.5)
//don't adjust anything below here
hole=platen+2;
difference(){
union(){
//platen
cylinder(h=platen, d1=140, d2=140);
//Main outer cylinder
cylinder(h=depth+platen, d1=118, d2=118);
}
//internal cylinder
translate([0,0,platen])  
cylinder(h=depth+platen,d1=116,d2=116);
//filter hole pattern
for (i=[0:45:330])rotate([0, 0, i]){
translate([35,0,-1])
cylinder(h=hole, d1=20, d2=20);
translate([16,0,-1])
cylinder(h=hole, d1=10, d2=10);
}
for (i=[22.5:45:350])rotate([0, 0, i]){
translate([24,0,-1])
cylinder(h=hole, d1=10, d2=10);
translate([41,0,-1])
cylinder(h=hole, d1=10, d2=10);
translate([32.5,0,-1])
cylinder(h=hole, d1=5, d2=5);
}
translate([0,0,-1])
cylinder(h=hole, d1=20, d2=20);
    }
//anti turbulence fins
    difference(){
        for (i=[0:45:330])rotate([0, 0, i]){
translate([46,-0.5,0])
cube([12,1,depth+platen]);
}
}