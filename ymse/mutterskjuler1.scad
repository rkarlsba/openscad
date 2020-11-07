$fn = $preview ? 32 : 64;

radius = 12;
tykkelse = 1.5;
klem = 0.3;
rorlengde = 20;
vingebredde = 5;
vingelengde = 10;
vingetykkelse = 2;

// Kuppel
translate([0,0,rorlengde]) {
    difference() {
        bue(radius,klem);
        translate([0,0,-tykkelse]) bue(radius,klem);
    }
}

// Vinger
difference() {
    translate([-(radius+vingelengde),-vingebredde/2,0]) {
        cube([radius*2+vingelengde*2,vingebredde,vingetykkelse]);
    }
    cylinder(r=radius-tykkelse,h=rorlengde);
}

// Rør
difference() {
    cylinder(r=radius,h=rorlengde);
    cylinder(r=radius-tykkelse,h=rorlengde);
}


// Moduler
module bue(radius,klem) {
    difference() {
        translate([0,0,0]) scale([1,1,klem]) sphere(r=radius);
        translate([-radius,-radius,-radius*klem]) cube([radius*2,radius*2,radius*klem]);
    }
}
