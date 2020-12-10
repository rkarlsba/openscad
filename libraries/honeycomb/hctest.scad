include <honeycomb/honeycomb.scad>

outer_diameter = 100;
honeycomb_dia = 3;
honeycomb_wall = 0.5;

linear_extrude(1) {
    honeycomb(outer_diameter, outer_diameter, honeycomb_dia, honeycomb_wall);
}
