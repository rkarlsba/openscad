markers = 5;

height = 50;
thickness = 3; // General padding between markers
backbone = 3;

// Values for the eraser width/depth and marker radius are set to work with the eraser and marker in this set: https://smile.amazon.com/gp/product/B00T3ROM9G/ 
eraser_width = 55;
eraser_depth = 41;

marker_rad = 10;
marker_ridge_height = 5; // Height of inner bevel in marker slots

nudge = 0.1; 
precision = 100;

difference() {
	union() {
		// Eraser block
		color("blue") {
            cube([
                eraser_width + thickness * 2, 
                eraser_depth + thickness * 2, 
                height + thickness
            ]);
        }

        // Markers block
        color("green") {
            translate([eraser_width + thickness * 2, 0, 0]) {
                cube([
                    (marker_rad * 2 + thickness*1.5) * markers, 
                    marker_rad * 2 + thickness * 2, 
                    height + thickness
                ]);
            }
        }
        color("yellow") {
            translate([eraser_width + thickness * 2, marker_rad * 1.5 + thickness * 2, 0]) {
                cube([
                    (marker_rad * 2 + thickness*1.5) * markers, 
                    marker_rad * 2 + thickness * 2, 
                    height + thickness
                ]);
            }
        }

	}
	
	// Eraser well
	translate([thickness, thickness, thickness]) {
        cube([eraser_width, eraser_depth, height]);
    }
	
	// Marker slots
	translate([
        thickness * 2 + eraser_width + marker_rad,
        thickness + marker_rad,
        thickness
    ]) {
        markers();
    }
	translate([
        thickness * 2 + eraser_width + marker_rad*2+1.5,
        thickness * sqrt(2)*3 + marker_rad*2 + 1,
        thickness
    ]) {
        markers(markers-1);
    }
}

color("darkgrey") {
    x = eraser_width + thickness*2 + (marker_rad*2+thickness*1.5)*markers;
    y = backbone;
    z = height + thickness;
    translate([0, -y, 0]) {
        difference() {
            cube([x, y, z]);
            for (xx=[1:2:9]) {
                translate([x / 10 * xx, y-2, z/4]) {
                    rotate([90,0,0]) {
                        cylinder(h=2, d=6, $fn = precision);
                    }
                }
                translate([x / 10 * xx, y-2, z/4*3]) {
                    rotate([90,0,0]) {
                        cylinder(h=2, d=6, $fn = precision);
                    }
                }
            }
        }
    }
}

module markers(markers=markers){
	for(i = [0:(markers - 1)]){
		translate([(marker_rad * 2 + thickness*1.5) * i, 0, 0])
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
