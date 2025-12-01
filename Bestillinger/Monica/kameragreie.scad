$fn = 2000;

d4y = 64;
d4i = 62;
d3y = 19;
d3i = 18;
d2 = 11;
d1 = 5;
inner_d = 57; // To be changed
height = 4;
thickness = 1.5;
mount_width = 4;
mount_thickness = thickness;
mount_height = 6;

difference() {
    cylinder(h=height+thickness, d1=d4y, d2=0);
    cylinder(h=height, d1=d4y, d2=0);
    cylinder(h=height+thickness, d=d3y);
}

