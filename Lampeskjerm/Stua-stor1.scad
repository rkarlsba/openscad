/*
 * Customizable Lamp Shade - https://www.thingiverse.com/thing:2372190
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-06-08
 * version v1.0
 *
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial license.
 * https://creativecommons.org/licenses/by-nc/3.0/
*/


 // Parameter Section//
//------------------//

// choose the shape of the lamp shade
lamp_shape = "dodecahedron"; //[simple,sphere,flower,dodecahedron]

// [Simple, sphere and flower shape] Resolution of round shapes. You can also use this value as the number of edges of the simple shade. If you want a cube or a pyramide, set the value of 4. If you want a cylinder or a cone, set the value of 100-255. Create a star shape with the flower shape with resolution of 3-5. Minimum value for a sphere shape is 7. You can use a low resolution (e.g. 16-32) to create a low polygon style. You can create some interesting shapes with this parameter. Just try some different values!
resolution = 64; //[3:255]

// Thinner for more translucency, thicker for more stable lamp shade. Default: 1.0
shell_thickness_in_millimeter = 1.0;

// [All lamp shapes] Set the diameter of the base of the lamp shade. The base is the position, where the bulb fitting is located. This parameter is used for all lamp shapes.
lamp_shade_base_diameter_in_millimeter = 220.0; //[1:300]

// [Simple and flower shape] Set the diameter of the head of the lamp shade. The head is the top position of the lamp shade. If this value is higher or lower than the base diameter, you get a cone or pyramide. Lower value can be used for desk lamp, higher value can be used for ceiling lamp. This parameter is used for simple and flower shape.
lamp_shade_head_diameter_in_millimeter = 10.0; //[1:300]

// [Simple and flower shape] Set the height of the lamp shade. This parameter is used for simple and flower shape
lamp_shade_height_in_millimeter = 110.0; //[1:300]

// [Sphere and dodecahedron shape] Set the cut height of the head of the shape. 0 means a closed top. It is like sclicing the top of an apple with a knife. This parameter is used for sphere and dodecahedron shape.
head_cut_height_in_millimeter = 40.0; //[0:200]

// [Sphere shape only] Set the cut height from the base of the shape. It is like sclicing the bottom of an apple with a knife. This parameter is used for sphere and dodecahedron shape.
base_cut_height_in_millimeter = 10.0;  //[0:200]

// [Flower shape only] This parameter only is used for flower shape
number_of_flower_leaves = 8; //[2:64]

// Set the diameter of the bulb bracket you want to use. Add a little extra for tolerance like 2mm if you are using a outside threaded bracket + nut/ring. If you are using a threadless bracket, it depends on the material. If it is a silicone one, you can use a little smaller hole. If it is non elastic plastic, this could be a challenge. If it is to loose, you can try to glue the gap between bracket and the lamp shade. Or do some test prints of the first 5-10 layers, before printing the whole lamp shade. Use 0, if you don't need a hole.
bulb_bracket_diameter_in_millimeter = 42.0;

// This is the additional support height for the bulb bracket. Depending on the bulb bracket you are using, this extra makes the hole more stable.
bulb_bracket_support_height_in_millimeter = 2.0;

// This is the additional support width for the bulb bracket. Depending on the bulb bracket you are using, this extra makes the hole more stable.
bulb_bracket_support_width_in_millimeter = 13.0;

/* [Hidden] */
shape_height = lamp_shade_height_in_millimeter;
base_cut = base_cut_height_in_millimeter;
head_cut = head_cut_height_in_millimeter;
shell = shell_thickness_in_millimeter;
flower_leaves = number_of_flower_leaves;
bulb_bracket_d = bulb_bracket_diameter_in_millimeter;
bulb_bracket_support_w = bulb_bracket_support_width_in_millimeter;
bulb_bracket_support_h = bulb_bracket_support_height_in_millimeter;
shape_base_outside = lamp_shade_base_diameter_in_millimeter;
shape_head_outside = lamp_shade_head_diameter_in_millimeter;

shape_base_inside = shape_base_outside - shell * 2;
shape_head_inside = shape_head_outside - shell * 2;
$fn=resolution;


 // Program Section//
//-----------------//

color("DeepSkyBlue") rotate([0,0,45]) {
        difference() {
                union() {
                        // Shape part
                        if(lamp_shape == "simple") simple_shape();
                        if(lamp_shape == "sphere") sphere_shape();
                        if(lamp_shape == "flower") flower_shape();
                        if(lamp_shape == "dodecahedron") dodecahedron_shape();
                        
                        // Bulb bracket support
                        cylinder(d = bulb_bracket_d + bulb_bracket_support_w * 2, h = bulb_bracket_support_h + shell, $fn=100);
                }
                
                // Bottom bulb bracket hole
                translate([0,0,- 0.1]) {
                        cylinder(d = bulb_bracket_d, h = shell + bulb_bracket_support_h + 0.2, $fn=100);
                }

        }
}


 // Module Section//
//---------------//

module simple_shape() {
        difference() {
                cylinder(d1 = shape_base_outside, d2 = shape_head_outside, h = shape_height);
                translate([0, 0, shell]) {
                        cylinder(d1 = shape_base_inside, d2 = shape_head_inside, h = shape_height);
                }
        }
}

module sphere_shape() {
        translate([0, 0, shape_base_outside / 2 - base_cut]) {
                difference() {
                        base_cut_sphere(shape_base_outside, base_cut);
                        translate([0, 0, shell / 2]) {
                                base_cut_sphere(shape_base_inside, base_cut);
                        }
                        // Head Cut
                        translate([0, 0, shape_base_outside / 2 - head_cut]) {
                                cylinder(d = shape_base_outside * 2, h = head_cut);
                        }
                }
        }
}

module flower_shape() {
        difference() {
                flower(shape_base_outside, shape_head_outside);
                translate([0, 0, shell]) {
                        flower(shape_base_inside, shape_head_inside);
                }
        }
}

module dodecahedron_shape() {
        translate([0, 0, shape_base_outside / 2]) {
                difference() {
                    dodecahedron(shape_base_outside);
                    dodecahedron(shape_base_inside);
                           // Head Cut
                                translate([0, 0, shape_base_outside / 2 - head_cut]) {
                                        cylinder(d = shape_base_outside * 2, h = head_cut + 0.1);
                        }
            }
        }
}

module base_cut_sphere(size, base) {
        difference() {
                sphere(d = size);
                // Base Cut
                translate([0, 0, - size / 2]) {
                        cylinder(d = size * 2, h = base);
                }
        }
}

module dodecahedron(size) {
        scale([size, size, size]) {
        intersection() {
            cube([2, 2, 1], center = true);
            intersection_for(i = [0:4]) {
                rotate([0, 0, 72 * i]) {
                        rotate([116.565, 0, 0]) {
                        cube([2, 2, 1], center = true);
                    }
                }
            }
        }
    }
}

module flower(size1, size2) {
        leaf_diameter1 = size1 * 3 / flower_leaves;
        leaf_diameter2 = size2 * 3 / flower_leaves;
        
        difference() {
                union() {
                        cylinder(d1 = size1 - leaf_diameter1,, d2 = size2 - leaf_diameter2, h = shape_height, $fn=100);
                        for(leaf = [0:flower_leaves]) {
                                rotate([0, 0, 360 / flower_leaves * leaf]) {
                                        hull() {
                                                translate([(size1 - leaf_diameter1) / 2, 0, 0]) {
                                                        cylinder(d = leaf_diameter1, h = 0.1);
                                                }
                                                translate([(size2 - leaf_diameter2) / 2, 0, shape_height]) {
                                                        cylinder(d = leaf_diameter2, h = 0.1);
                                                }
                                        }
                                }        
                        }
                }
                translate([0, 0, shape_height]) {
                        cylinder(d = size2 + 1, h = 0.2);
                }
        }
}

