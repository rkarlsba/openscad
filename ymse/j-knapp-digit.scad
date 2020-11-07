$fn = 64;

size_index = 100;
button_radius = size_index/10;
rim_size = size_index/100;
internal_radius = button_radius - rim_size*2;
//button_height = 1.8;
button_height = size_index/64;
button_drop = button_height/2;
font_size = size_index/10;

text = "Align";
 
difference() {
    cylinder(r = button_radius, h = button_height);
    translate([0, 0, button_drop]) {
        cylinder(r = internal_radius, h = button_drop);
    }
    
}


content = "Ti";
//font = "Liberation Sans";
//font = "Comic Sans"; 
font = "Palatino";

translate ([-(font_size/2.2)+1,-(font_size/2),0]) {
   linear_extrude(height = button_height) {
       text(content, font = font, size = font_size);
     }
 }