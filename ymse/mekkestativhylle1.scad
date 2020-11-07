

// You could simply do it this way if you have the boxes.scad
// file in your library
//use <boxes.scad>
//roundedBox([20, 30, 40], 5, true); 
//$fn = 64;
// Or, you could do it this way if you want to roll your own
// roundedRect([20, 30, 40], 5, $fn=12);

width = 400;
depth = 200;
height = 50;
drawer_thickness = 4;
tube_thickness = 70;

union() {
    difference() {
        roundedRect([width, depth, height], width/12, $fn=64);
        translate([0,depth/2.8,0]) {
            cylinder(d=tube_thickness, h=height);
        }
        translate([0,0,drawer_thickness/2]) {
            roundedRect([width-drawer_thickness/2, depth-drawer_thickness/2, height-drawer_thickness/2], width/12, $fn=64);
        }
    }
    translate([0,depth/2.8,0]) {
        difference() {
            cylinder(d=tube_thickness, h=height);
            cylinder(d=(tube_thickness-drawer_thickness), h=height);
        }
    }
}

module festeror(d) {
}
// size - [x,y,z]
// radius - radius of corners
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