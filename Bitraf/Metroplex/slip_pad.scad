
$fn=$preview ? 16 : 128;

h=0.3;
tapp_h=1.0;
tapp_d=2.8;

color("blue") {
    cube([14,7,h]);
}

translate([12,3.5,h]) {
    cylinder(d=tapp_d, h=tapp_h);
}