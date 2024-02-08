markers = 6;

height = 50;
thickness = 3; // General padding between markers

// Values for the eraser width/depth and marker radius are set to work with the eraser and marker in this set: https://smile.amazon.com/gp/product/B00T3ROM9G/ 
eraser_width = 52;
eraser_depth = 31;

marker_rad = 9;
marker_ridge_height = 5; // Height of inner bevel in marker slots

nudge = 0.1; 
precision = 100;

difference(){
	union(){
		// Eraser block
		color("blue")
		cube([
            eraser_width + thickness * 2, 
            eraser_depth + thickness * 2, 
            height + thickness
        ]);

        translate([eraser_width + thickness * 2, 0, 0])
		
        // Markers block
		color("green")
        cube([
            (marker_rad * 2 + thickness) * markers, 
            marker_rad * 2 + thickness * 2, 
            height + thickness
        ]);

	}
	
	// Eraser well
	translate([thickness, thickness, thickness])
	cube([eraser_width, eraser_depth, height]);
	
	// Marker slots
	translate([
        thickness * 2 + eraser_width + marker_rad,
        thickness + marker_rad,
        thickness
    ])
	markers();
}

module markers(){
	for(i = [0:(markers - 1)]){
		translate([(marker_rad * 2 + thickness) * i, 0, 0])
		union(){
			cylinder(r = marker_rad, h = height, $fn = precision);
			
			translate([0,0,height - marker_ridge_height])
			cylinder(
                r1 = marker_rad, 
                r2 = marker_rad + thickness / 2 - nudge, 
                h = marker_ridge_height, 
                $fn = precision
            );
		}
	}
}
