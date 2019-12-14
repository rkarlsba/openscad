/////
///// PARAMETRIC MEASURING SPOON
///// 1.0
///// by Brian Enigma <brian@netninja.com>
/////
/*

== WHAT IS IT? ==

This file is an OpenSCAD document for outputting a measuring spoon of any
desired volume.  The measuring spoon consists of a scoop (a half-sphere of
desired radius and thickness) connected to a handle (with desired length 
and thickness).  All of these parameters are variables that can be fine
tuned to your desire.

== MAKE YOUR OWN ==

Do you want a two-teaspoon measuring spoon?  Three-quarters of a 
tablespoon?  Five milliliters?  You only need to adjust the "radius"
variable.

To make a measuring spoon of a specific size, you need to first convert 
that size to milliliters.  There are lots of conversion tools to do that.
I use ConvertBot on the iPhone.  Once you have the volume, in milliliters,
convert it to a radius using this formula:

radius (in centimeters) = cube_root((3 * volume) / (2 * pi))

You will need to shift the decimal point over one spot (that is, multiply
by 10) because OpenSCAD uses millimeters.  Plug that radius value into
the variable named "radius" in this document.

If you want a label, uncomment the "label" variable and point it to a
*.dxf file.  My printer was unable to handle the detail of the text labels.

== DESIGN CONSTRAINTS ==

I designed this to print on MY particular Cupcake CNC.  My printer not only
has the older Mark-5 extruder, but suffers from the same extruder motor
issues that many others have.  It's been hacked with a MOSFET between the
extruder controller and extruder, so its accuracy and rate of flow are more
of a black art than an exact science.  

Because of this, it cannot do detail very well.  Your printer might, so I 
highly encourage you to play around with the scoop thickness and labels.
I experimented with 2mm and 3mm thicknesses, but settled on a full half
centimeter (5mm) due to quality issues.  At 2mm, it mostly printed fine
until it got to the apex of the sphere, where there wasn't enough plastic
to handle the overhang.  There was a lot of drool, resulting in a holy
teaspoon.  At 3mm, it was thick enough to print an outer and inner shell
of the half-sphere, then attempt a solid fill.  My extruder spit out too
much plastic for the solid fill, which caused mechanical issues during
printing (little hills of plastic built up which impeded the print 
head's motion).  5mm was thick enough for a hollow (honeycomb) fill which
allows for a little more slop and a little more margin for extruder error.

I really love the labels, but my hacked Mark-5 extruder just spits out
too much plastic for those to work without buildup and, consequently, 
mechanical errors during printing.

*/

////////// Uncomment these lines for a 1 tsp measuring spoon
//radius = 13.301; // radius of the inner half-sphere
//label = "1tsp";

////////// Uncomment these lines for a 1 tbl measuring spoon
radius = 19.184; // radius of the inner half-sphere
label = "1tbl";


//label = "half_tsp";
//label = "quarter_tsp";

// width of handle
handle_width = 12;

// thickness of handle and scoop
scoop_thickness = 2;
handle_thickness = 2;

// length of handle (actually, not including the end-cap)
handle_length = 60;

// hanger hole radius
hole_radius = 2;

// resolution of spheres -- 10 makes for quick renders, higher makes for good prints
//res = 10;
res = 50;

translate(v = [0, -25, 0]) // slide over to be better centered on the table
{
	rotate (a = [0, 180, 0]) // rotate to place correctly on the table for printing
	{
		difference() // subtract out the inner sphere and make it only half a sphere
		{
			union() // combine spheres with handle and curve on end of handle
			{
				// outer sphere
				sphere(r = radius + scoop_thickness, $fn = res);
				// handle
				translate(v = [handle_width / 2 * -1, 0, handle_thickness * -1]) {
					cube(size = [handle_width, handle_length, handle_thickness]);
				}
				// cap at end of handle
				translate(v = [0, handle_length, handle_thickness * -1]) 
				{
					cylinder(h = handle_thickness, r = handle_width / 2, $fn = res);
				}
			}
			// subtract out top half of spheres
			translate(v = [-30, -30, 0])
			{
				cube(size = [60, 60, 60]);
			}
			// subtract out inner sphere
			sphere(r = radius, $fn = res);
			// subtract out hanger hole
			translate(v = [0, handle_length, handle_thickness * -1.5]) 
			{
				cylinder(h = handle_thickness * 2, r = hole_radius, $fn = res);
			}
			// Extrude a label, if given one
			if ("" != label)
			{
				translate(v = [5.5, handle_length / 2, handle_thickness / -2]) 
				{
					rotate(a = [0, 0, 90]) {
						scale(v = [7, 7, 7])
						{
							linear_extrude(file = str(label, ".dxf"), height = thickness / 2);
						}
					}
				}
			}
		}
	}
}