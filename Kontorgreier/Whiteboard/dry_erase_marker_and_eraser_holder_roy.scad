markers_rows = 2;
markers = [7,6];

height = 50;
thickness = 3; // General padding between markers
backplate_thickness = thickness * 2;

eraser_width = 52;
eraser_depth = 38;

marker_rad = 10; // This radius value works for standard expo dry erase markers
marker_ridge_height = 5; // sure, why not?

//fastener_width = 15;
fastener_width = 0;

nudge = 0.1;
precision = 100;

difference() {
	union() {
		//eraser block
		color("blue") {
            cube([eraser_width + thickness * 2, eraser_depth + thickness * 2, height + thickness]);
        }

		//markers block
		color("green") {
            translate([eraser_width + thickness * 2,0,0]) {
                cube([(marker_rad * 2 + thickness) * markers[0], 
                       marker_rad * 2 + thickness * 2, height + thickness]);
            }
        }

		color("red") {
            fasteners();
        }
	}
	
	//eraser hole
	translate([thickness, thickness, thickness]) {
        cube([eraser_width, eraser_depth, height]);
    }
	
	//marker holes
	translate([thickness * 2 + eraser_width + marker_rad,thickness + markers[0],thickness]) {
        markers([0]+1);
    }
}

module fastener() {
	cube([fastener_width, thickness, height + thickness]);
}

module fasteners() {
	translate([-fastener_width,0,0])
	fastener();

	translate([eraser_width + thickness * 2 + (marker_rad * 2 + thickness) * markers[0], 0, 0])
	fastener();
}

module markers() {
    for (m = [0:1]) {
        for (i = [0:7]) {
            translate([(marker_rad * 2 + thickness) * i, 0, 0]) {
                union(){
                    cylinder(r=marker_rad, h = height, $fn = precision);
                    translate([0,0,height - marker_ridge_height]) {
                        cylinder(r1 = marker_rad,
                                 r2 = marker_rad + thickness / 2 - nudge,
                                 h = marker_ridge_height, 
                                 $fn = precision);
                    }
                }
            }
        }
    }
    if (0)
    translate([0, marker_rad * 2 + thickness/sqrt(2), 0]) {
        for(i = [0:(markers_a - 1)]) {
            translate([(marker_rad * 2 + thickness) * i, 0, 0]) {
                union(){
                    cylinder(r=marker_rad, h = height, $fn = precision);
                    translate([0,0,height - marker_ridge_height]) {
                        cylinder(r1 = marker_rad,
                                 r2 = marker_rad + thickness / 2 - nudge,
                                 h = marker_ridge_height, 
                                 $fn = precision);
                    }
                }
            }
        }
    }
}
