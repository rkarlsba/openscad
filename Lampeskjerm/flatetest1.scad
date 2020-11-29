difference() {
    cube([200,200,2]);
    translate([10,10,0]) {
        cube([180,180,2]);
    }
}
translate([20,20,0]) {
    difference() {
        cube([160,160,2]);
        translate([10,10,0]) {
            cube([140,140,2]);
        }
    }
}

translate([40,40,0]) {
    difference() {
        cube([120,120,2]);
        translate([10,10,0]) {
            cube([100,100,2]);
        }
    }
}

translate([60,60,0]) {
    difference() {
        cube([80,80,2]);
        translate([10,10,0]) {
            cube([60,60,2]);
        }
    }
}

translate([80,80,0]) {
    difference() {
        cube([40,40,2]);
        translate([10,10,0]) {
            cube([20,20,2]);
        }
    }
}

