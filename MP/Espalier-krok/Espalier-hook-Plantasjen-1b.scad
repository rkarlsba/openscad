/* Copyleft Roy Sigurd Karlsbakk <roy@karlsbakk.net> 2019
 * Dings for å ersatatte drit fra Plantasjen
 *
 * Lisens  CC BY-NC https://creativecommons.org/licenses/by-nc/4.0/legalcode.no
 * License CC BY-NC https://creativecommons.org/licenses/by-nc/4.0/legalcode
 */

$fn=64;

cube_x=11.44;
cube_y=19.25;
cube_z=3.5;

wall_width=cube_z;

bottom_cube=[cube_x,cube_y,cube_z];
circle_center=[cube_x/2,24];
outer_circle_d=17;
cone_outer_d=10;
cone_inner_d=4.5;
cone_edge=0.5;
screw_cyl_height=2;
cone_height=screw_cyl_height+cube_z;
out_pin_thickness=2.54;
out_pin_x=8.5;
out_pin_y=2.3;
out_pin_z=18;
//out_pin_origo=[1.35,5.5,cube_z];
out_pin_origo=[0,5.5,cube_z];
back_out_y_bottom=0.5;
back_out_y_top=3.2;
front_out_y_bottom=back_out_y_bottom+19;
front_out_y_top=back_out_y_top+9;

module festering(width, outer_d, inner_d, rotational_angle=360) {
    difference() {
        cylinder(d=outer_d, h=width);
        cylinder(d=inner_d, h=width);
        translate([0,0,0]) {
            rotate([0,0,0]) {
                cube([7.5,7.5,cube_x]);
            }
        }
    }
}

module base() {
    cube(bottom_cube);
    translate(circle_center)  {
        cylinder(d=outer_circle_d,h=cube_z);
//        cylinder(h=cone_height,d=cone_outer_d);
    }
}

module trekantdings() {
    fra_x=4.2;
    fra_y=0.3;
    trekanthoyde=18.7;
    trekantfram_topp=8.2;
    trekantfram_bunn=18.5;
    helling_y=2.5;
    trekantdybde_y=8.8;
    forsterkning=0;

    polypoints=[
        [fra_x,fra_y,cube_z],                                                   // 0
        [fra_x-forsterkning,fra_y+trekantfram_bunn,cube_z],                                  // 1
        [fra_x+forsterkning+wall_width,fra_y+trekantfram_bunn,cube_z],                       // 2
        [fra_x+forsterkning+wall_width,fra_y,cube_z],                                        // 3
        [fra_x-forsterkning,fra_y+helling_y,cube_z+trekanthoyde],                            // 4
        [fra_x-forsterkning,fra_y+helling_y+trekantdybde_y,cube_z+trekanthoyde],             // 5
        [fra_x+forsterkning+wall_width,fra_y+helling_y+trekantdybde_y,cube_z+trekanthoyde],  // 6
        [fra_x+forsterkning+wall_width,fra_y+helling_y,cube_z+trekanthoyde]                  // 7
    ];
    polyfaces=[
        [0,3,2,1],
        [1,2,6,5],
        [4,5,6,7],
        [0,4,7,3],
        [0,1,5,4],
        [2,3,7,6],
    ];
    polyhedron(polypoints, polyfaces);

    // Korreksjonsblokk
    
    translate([fra_x,0,cube_z]) {
        cube([wall_width,wall_width,24]);
    }    
}
difference() {
    base();
    translate(circle_center)  {
        cylinder(d1=cone_inner_d,d2=cone_outer_d-cone_edge,h=cone_height);
    }
}
translate(out_pin_origo) {
    cube([cube_x,out_pin_y,out_pin_z]);
}
trekantdings();

translate([0,7,26]) {
    rotate([90,40,90]) {
        festering(width=cube_x, outer_d=14.1, inner_d=7);
    }
}

