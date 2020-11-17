$fn=64;

content = "Bitraf";
//font = "Liberation Sans";
//font = "Comic Sans"; 
font = "Palatino";
font_size = 12;

difference() {
    cube([50,35,1]);
    translate([1.5, 20, 0.25]) {
        linear_extrude(height = 0.75) {
            text(content, font = font, size = font_size);
        }
    }
    translate([48.5, 14.5, 0.25]) {
        rotate(180,0,0) {
            linear_extrude(height = 0.75) {
                text(content, font = font, size = font_size);
            }
        }
    }
    translate([2.5,17,0]) {
        cube([13.3,1,1]);
    }
    translate([18.3,17,0]) {
        cube([13.4,1,1]);
    }
    translate([34.2,17,0]) {
        cube([13.3,1,1]);
    }
}
 //}
//
//text("Bitraf");