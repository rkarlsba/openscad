$fn = 100;
debug = 0;

sherpa_housing_core_bottom = "/Users/roysk/src/git/rkarlsba/openscad/Bitraf/Metroplex/Sherpa-stuff/sherpa-bottom-extender-0.1mm.stl";
sherpa_housing_core = "/Users/roysk/src/git/Annex-Engineering/Sherpa_Mini-Extruder/STLs/housing_core_x1_rev16.STL";
sherpa_housing_core_exp1 = "/Users/roysk/src/git/Annex-Engineering/Sherpa_Mini-Extruder/STLs/housing_core-front-grid-only-exp1.stl";
sherpa_housing_core_c1 = "/Users/roysk/src/git/rkarlsba/ymse/3d/center-stl/housing_core_x1_rev16-c1.STL";
stlfile = sherpa_housing_core;
//stlfile = sherpa_housing_core_c1;

module dings() {
    rotate([23,56,12]) {
        cube([20,28,12]);
    }
}

module 2dmodell() {
    projection(cut = false) {
        translate([0,0,3]) {
            rotate([180,0,0]) {
                intersection() {
                    translate([0,-12,0]) {
                        cube([60,12,2.9]);
                    }
                    rotate([90,0,0]) {
                        import(stlfile);
                    }
                }
            }
        }
    }
}

if (debug == 0) {
    union() {
        linear_extrude(4) {
            2dmodell();
        }
//        translate([25.4, 6.3, 0)
    }
} else if (debug == 1) {
    projection(cut = 1) {
        import(stlfile);
        //dings();
    }
} else if (debug == 2) {
    import(stlfile);
