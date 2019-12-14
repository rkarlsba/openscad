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
 
union() {
    difference() {
        cylinder(r = button_radius, h = button_height);
        translate([0, 0, button_drop]) {
            cylinder(r = internal_radius, h = button_drop);
        }
    }
    translate([-internal_radius/2,-(rim_size*3.5),button_drop]) {
        cube(size=[internal_radius, rim_size, button_drop]);
    }
    translate([-(rim_size/2),-internal_radius+rim_size,button_drop]) {
        cube(size=[rim_size, internal_radius*2-rim_size*2, button_drop]);
    }
}


/*
content = "RK";
font = "Liberation Sans";

translate ([-(font_size),-(font_size/2),0]) {
   linear_extrude(height = button_height) {
       text("RK", font = font, size = font_size);
     }
 }
*/
 /*
projection() {
    translate([0,0,button_drop*sqrt(2)]) {
        text("asdf", halign=50);
    }
}
*/