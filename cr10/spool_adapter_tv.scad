// customisable filament spool adapter
// version 1.0  26/02/2002

// customisable parameters:
internal_diameter = 36; // internal diameter
thickness = 2;     		// wall thickness
external_diameter = 72; // external diameter
length = 15;    		// length of adapter
lip = true;    // set to true to print a lip
lip_height = thickness;  // or whatever you want

// Non-customisable (don't change these):
a_bit = 0.01;	// a fudge factor to ensure the integrity of the mesh
spoke_length = (external_diameter/2-thickness)-(internal_diameter/2+thickness)+thickness;
$fn = $preview ? 24 : 180;

// spell to create a wheel spoke
module spoke() {
    translate([internal_diameter/2+thickness/2,-thickness/2,0]) {
        cube([spoke_length,thickness,length]);
    }
}

// the inside cylinder
difference() {
    cylinder(h=length,d=internal_diameter+2*thickness);
    translate([0,0,-a_bit]) {
        cylinder(h=length+2*a_bit,d=internal_diameter);
    }
}

// the outside cylinder
difference() {
    cylinder(h=length,d=external_diameter);
    translate([0,0,-a_bit]) {
        cylinder(h=length+2*a_bit, d=external_diameter-2*thickness);
    }
}

// add in 5 spokes
for (i = [0:72:288]) rotate([0,0,i]) spoke();
  
// an optional lip
if (lip) {
    difference() {
    cylinder(d=external_diameter+lip_height+thickness, h=thickness);
        translate([0,0,-a_bit]) {
            cylinder(d=external_diameter-thickness/2, h=thickness+2*a_bit);
        }
    }
}