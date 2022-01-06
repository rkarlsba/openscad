$fn = $preview ? 32 : 128;
indre_d = 13.5;
ytre_d = indre_d+2;
cyl_h = 32;

vegg_t = (ytre_d-indre_d)/2;
difference() {
    positive();
    negative();
}

module positive() {
    linear_extrude(cyl_h+vegg_t)
        circle(d=ytre_d);
    translate([0,0,cyl_h+vegg_t])
        sphere(d=ytre_d);
}

module negative() {
    linear_extrude(cyl_h)
        circle(d=indre_d);
    translate([0,0,cyl_h])
        sphere(d=indre_d);
}