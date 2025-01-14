/* 2021-11-10 dishwasher status sign */
/* by Torfinn Ingolfsen */

// History:
// 2021-11-12 removed the sign holder, I can just write on the sides with a marker. Reduced depth of pocket to 6 mm. Reduced with of gadget to 100 mm.
// 2021-11-10 initial version
//

preview_bug_fix = $preview ? 0.1 : 0;
sign_length = 100; // the gadget is going to be 110 mm wide
sign_height = 20; // and 20 mm high
side_depth = 6;  // was 10, try with 6 instead
side_thickness = 2;
holder_thickness = 1;
print_holder = false;
print_main = true;
debug = true;

// sign holder to put in a paper / cardboard sign
module sign_holder() {
    translate([holder_thickness + holder_thickness, 0, 0]) {
        cube([holder_thickness,holder_thickness + holder_thickness, sign_length]);
    }
    translate([holder_thickness, 0, 0]) {
        cube([holder_thickness,holder_thickness,sign_length]);
    }
    color("blue") {
        cube([holder_thickness,sign_height + side_thickness, sign_length]);
    }
    translate([holder_thickness + holder_thickness, sign_height, 0]) {
        color("red") {
            cube([holder_thickness,holder_thickness + holder_thickness, sign_length]);
        }
    }
    translate([holder_thickness, sign_height + holder_thickness, 0]) {
        cube([holder_thickness, holder_thickness, sign_length]);
    }
}

module side() {
    difference() {
        cube([side_depth + side_thickness + side_thickness, sign_height + side_thickness, sign_length]);
        translate([side_thickness, 0, 0]) {
            cube([side_depth, sign_height, sign_length]);
        }
    }
    // translate([side_depth + side_thickness + side_thickness, 0, 0]) color("green") sign_holder();
}



// main
module main () {
    translate([sign_height, -side_thickness/2, 0]) {
        rotate([0,0,30]) {
            color("blue") {
                side();
            }
        }
    }
    rotate([0,0, -90]) {
        color("red") {
            side();
        }
    }
    translate([(sign_height)/2 + side_thickness,sign_height - side_thickness,0]) {
        rotate([0,0, 150]) {
            color("green") {
                side();
            }
        }
    }
}

if (debug) {
    translate([-40,0,0]) {
        rotate([0,0,90]) {
            side();
        }
    }
}

if (print_main) {
    translate([0,0,0]) {
        main(); 
    }
}

if (print_holder) {
    translate([40,0,0]) {
        sign_holder(); 
    }
}
