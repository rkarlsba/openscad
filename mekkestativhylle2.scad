$fn=64;

width = 240;
depth = 123;
height = 30;
plastic_thickness = 2;
tube_thickness = 46;
round_rad_big=35;
round_rad_small=5;

union() {
    difference() {
        hull() {
            translate([round_rad_big,round_rad_big,0])
                cylinder(r=round_rad_big,h=height);
            translate([width-round_rad_big,round_rad_big,0])
                cylinder(r=round_rad_big,h=height);
            translate([round_rad_small,depth-round_rad_small,0])
                cylinder(r=round_rad_small,h=height);
            translate([width-round_rad_small,depth-round_rad_small,0])
                cylinder(r=round_rad_small,h=height);
        }
        hull() {
            translate([round_rad_big+plastic_thickness,round_rad_big+plastic_thickness,plastic_thickness])
                cylinder(r=round_rad_big,h=height);
            translate([width-round_rad_big-plastic_thickness,round_rad_big+plastic_thickness,plastic_thickness])
                cylinder(r=round_rad_big,h=height);
            translate([round_rad_small+plastic_thickness,depth-round_rad_small-plastic_thickness,plastic_thickness])
                cylinder(r=round_rad_small,h=height);
            translate([width-round_rad_small-plastic_thickness,depth-round_rad_small-plastic_thickness,plastic_thickness])
                cylinder(r=round_rad_small,h=height);
        }
        translate([width/2,depth*.27,0])
            cylinder(d=tube_thickness,h=plastic_thickness);
    }
    translate([width/2,depth*.27,0]) {
        difference() {
            cylinder(d=(tube_thickness+plastic_thickness*2), h=height);
            cylinder(d=tube_thickness, h=height);
        }
    }
}
/*
module skrufeste() {
    translate([0,depth/4,0])
        cylinder(d=width/2,h=height);
}*/

module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}
