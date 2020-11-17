$fn = 64;

size_index = 120;
button_radius = size_index/10;
rim_size = size_index/100;
internal_radius = button_radius - rim_size*2;
//button_height = 1.8;
button_height = size_index/64;
button_drop = button_height/2;
font_size = size_index/9;
text = "Align";

module mynt() { 
    difference() {
        cylinder(r = button_radius, h = button_height);
        translate([0, 0, button_drop]) {
            cylinder(r = internal_radius, h = button_drop);
        }
        /*
        // Høl
        translate([0,9.5,0]) {
            cylinder(r = 1, h = button_height);
        }
        */
    }
}

module smilie() {
    smilie_r = internal_radius*.7;
    eye_r = internal_radius*.15;

    difference() {
        echo("translate([0,", -(internal_radius/2), ",0]),
            eye_r = ", eye_r);
        cylinder(r = smilie_r, h=button_height);
        translate([0,1,0]) {
            cylinder(r = smilie_r, h=button_height);
        }
    }
    translate([-internal_radius*.35,internal_radius*.35,0])
        cylinder(r = eye_r, h=button_height*1);
    translate([internal_radius*.35,internal_radius*.35,0])
        cylinder(r = eye_r, h=button_height*1);
}

module pi() {
    content = "π";
    //font = "Liberation Sans";
    //font = "Comic Sans"; 
    font = "Palatino";

    translate ([-(font_size/2.2)-.8,-(font_size/2)+1.6,0]) {
       linear_extrude(height = button_height) {
           text(content, font = font, size = font_size);
         }
     }
 }

module dollar() {
    content = "$";
    font = "Liberation Sans";
    //font = "Comic Sans"; 
    //font = "Palatino";

    translate ([-(font_size/2.2)+.8,-(font_size/2)+.3,0]) {
       linear_extrude(height = button_height) {
           text(content, font = font, size = font_size);
         }
     }
 }
 
 mynt();
 dollar();
 