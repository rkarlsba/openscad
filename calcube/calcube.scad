xyz=20;
thickness=0.5;

difference() {
    cube([xyz,xyz,xyz]);
    translate([thickness,thickness,thickness])
        cube([xyz-thickness*2,xyz-thickness*2,xyz-thickness]);
}