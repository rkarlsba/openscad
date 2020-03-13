height=2.5;

$fn=$preview?8:64;
big_r=45;
r=3.5;
pinneskip=5;
firkantpinne_h=8;
firkantpinne_s=2.5;

hull() {
    cylinder(r=r, h=height);
    translate([34,0,0])
        cylinder(r=r, h=height);
}
translate([pinneskip,-1.5,height]) {
    cube([firkantpinne_s,firkantpinne_s,firkantpinne_h]);
    translate([1.3,1.3,firkantpinne_h]) {
        cylinder(h=2.5,r=1);
    }
}
translate([34-pinneskip-firkantpinne_s,-1.5,height]) {
    cube([firkantpinne_s,firkantpinne_s,firkantpinne_h]);
    translate([1.3,1.3,firkantpinne_h]) {
        cylinder(h=2.5,r=1);
    }
}
translate([17,-big_r+7,0]) {
    difference() {
        cylinder(r=big_r, h=height);
        translate([-big_r,-big_r,0]) {
            cube([big_r*2,big_r*2-4,height]);
        }
    }
}
