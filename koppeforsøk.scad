$fn = 64;

cup_size_index = 10;
cup_r = cup_size_index * 8.5;
cup_h = cup_size_index * 15;
cup_thickness = 4;
inner_r = cup_r - cup_thickness * 2;
inner_h = cup_h - cup_thickness;

difference() {
    //cylinder(h = cup_h, r = cup_r);
    translate([0,0,cup_thickness]) {
        cylinder(h = inner_h, r = inner_r);
        sphere(d=inner_h-2)
    }
  
  //}
  /*
    union() {
        cylinder(h = inner_h, r = inner_r);
        sphere(r = inner_r);
    }
  */
}