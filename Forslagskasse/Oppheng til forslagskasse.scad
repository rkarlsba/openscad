use <ymse.scad>

$fn = $preview ? 16 : 64;

ned_til_skruer = 20;
skrue_til_topp = 72;
skruehue = 10;
box_h = 210;
box_b = 160;
box_d = 5;
box_mellom_skruer = 44;
box_resten = 160 - box_mellom_skruer;
box_skrue = box_resten / 2;

translate([0,0,-5]) {
    color("lightblue") {
        translate([box_b/2,box_h,0]) {
            pie_slice(180,box_b/2,5);
        }

    }
    color("pink") {
        cube([box_b, box_h, box_d]);
    }
}
oppheng_h = box_h-50;
oppheng_b = 68;
difference() {
    translate([box_b/2-oppheng_b/2, box_h-oppheng_h-6]) square([oppheng_b,oppheng_h]);

    translate([box_skrue,box_h-ned_til_skruer]) circle(d=skruehue);
    translate([box_b-box_skrue,box_h-ned_til_skruer]) circle(d=skruehue);
    translate([box_b/2-oppheng_b/2+10, 124]) square([oppheng_b-20,oppheng_h/4]);
    translate([box_b/2-oppheng_b/2+10, 60]) square([oppheng_b-20,oppheng_h/4]);

}