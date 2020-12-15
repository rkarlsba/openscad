$fn = $preview ? 16 : 32;

include <lampefilter.scad>

outer_diameter=99;
border_diameter=outer_diameter+10;
inner_diameter=65;
thickness=1;
honeycomb_dia = 9;

lampefilter("midtfilter");
//lampefilter("midtgitter");
