$fn = 128;

size_index = 120;
button_radius = size_index/10;
rim_size = size_index/100;
internal_radius = button_radius - rim_size*2;
//button_height = 1.8;
button_height = size_index/64;
button_drop = button_height/2;
font_size = size_index/11;

text = "Align";
 
 /*
difference() {
    cylinder(r = button_radius, h = button_height);
    translate([0, 0, button_drop]) {
        cylinder(r = internal_radius, h = button_drop);
    }
}*/
content = "βθ";
content_b = "β";
content_th = "θ";
content_t = "τ";
//font = "Liberation Sans";
//font = "Comic Sans"; 
font = "Palatino";

cylinder(r = button_radius, h = button_drop);
 
translate ([-(font_size/1.4)+1.7,-(font_size/2)+2.1,0]) {
   linear_extrude(height = button_height) {
       text(content_b, font = font, size = font_size*1.3);
     }
 }
translate ([-(font_size/1.4)+4.9,-(font_size/2)-4.6,0]) {
    linear_extrude(height = button_height) {
        text(content_t, font = font, size = font_size/1.2);
    }
}