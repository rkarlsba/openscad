$fn = 64;

size_index = 100;
button_radius = size_index/10;
rim_size = size_index/100;
internal_radius = button_radius - rim_size*2;
//button_height = 1.8;
button_height = size_index/64;
button_drop = button_height/2;
font_size = size_index/16;

text = "Align";
 font = "Liberation Sans";
 
 valign = [
   [  0, "top"],
   [ 40, "center"],
   [ 75, "baseline"],
   [110, "bottom"]
 ];
 
difference() {
    cylinder(r = button_radius, h = button_height);
    translate([0, 0, button_drop]) {
        cylinder(r = internal_radius, h = button_drop);
    }
    
}


content = "1";
font = "Liberation Sans";

translate ([-(font_size/2),-(font_size/2),0]) {
   linear_extrude(height = button_height) {
       text(content, font = font, size = font_size);
     }
 }
 /*
projection() {
    translate([0,0,button_drop*sqrt(2)]) {
        text("asdf", halign=50);
    }
}
*/