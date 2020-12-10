$fn = $preview ? 16 : 128;

include <lampefilter.scad>

outer_diameter=99;
border_diameter=outer_diameter+10;
thickness=1;
honeycomb_dia = 3;
honeycomb_wall = 0.5;

lampefilter("gitter");

