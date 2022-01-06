// RJ45-ramme
$fn = $preview ? 32 : 128;

feste = 20;

inner_h = 24.7;
inner_w = 23.2;
inner_d = 3;

outer_h = 38.5;
outer_w = inner_w+4;
outer_d = inner_d;

bleed = 0.2;

skinne = 20;
monteringshull = 5;

difference() {
    cube([outer_w, outer_h+skinne*2, outer_d]);
    translate([(outer_w-inner_w)/2,(outer_h-inner_h)/2+20,(outer_d-inner_d)/2]) {
        cube([inner_w, inner_h, inner_d]);
    }        
    translate([outer_w/2,skinne/2,0]) {
        rotate([0,0,0]) {
            cylinder(d=monteringshull, h=inner_d);
        }
    }
    translate([outer_w/2,outer_h+skinne*1.5,0]) {
        rotate([0,0,0]) {
            cylinder(d=monteringshull, h=inner_d);
        }
    }
}
/*
translate([0, skinne, inner_d]) {
    cube([outer_w, outer_h, outer_d+30]);
}
*/