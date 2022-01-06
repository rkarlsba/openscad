smily_types = [":)", ":D", ":(", ";)", ":|"];
smily_count = 5; // for older versions of OpenSCAD without len()

/* Creates a 2D smily face
 *
 * type - string. Type of smily. :) = normal, :D = big smile, :( = frown, ;) = wink, :| = expressionless
 * radius - float. The radius of the smily face
 * line_thickness - float. The thickness of the lines in the drawing
 * inverse - bool. Not a true inverse. Draws outlines instead of filling in.
 */
module smily_2d(type, radius, line_thickness, inverse) {
	difference() {
		if(inverse) {
			circle(radius);
		}
		scale_factor = inverse ? radius / (radius + line_thickness) : 1;
		scale([scale_factor, scale_factor])
		translate([0, 0, -0.1])
		difference() {
			circle(radius);
			for(i = [-1 : 2 : 1]) {
				translate([i * (sqrt(2) / 6) * radius, (sqrt(2) / 4) * radius])
				scale([1, 2]) {
					if(type == ";)" && i == -1) {
						scale([2, 0.2]) {
							circle(line_thickness, $fn = 15);
						}
					}
					else {
						circle(line_thickness, $fn = 15);
					}
				}
			}

			// The mouth
			ratio = 0.6;
			mirror([0, type == ":(" ? 1 : 0])
			translate([0, type == ":(" ? ratio * radius + line_thickness : 0]) {
				if(type == ":|") {
					translate([0, -0.4 * radius]) {
						square([radius, line_thickness], center = true);
						for(i = [-1 : 2 : 1]) {
							translate([i * radius / 2, 0]) {
								circle(line_thickness / 2, $fn = 15);
							}
						}
					}
				}
				else {
					scale([1.1, 1]) {
						translate([0, -0.15 * radius])
						difference() {
							circle(ratio * radius);
							if(type != ":D") {
								circle(ratio * radius - line_thickness);
							}
							translate([-ratio * radius - 0.1, 0, 0]) {
								square([2 * ratio * radius + 2 * 0.1, ratio * radius + 0.1]);
							}
						}
						if(type != ":D") {
							for(i = [-1 : 2 : 1]) {
								translate([i * ratio * radius - i * line_thickness / 2, -0.15 * radius]) {
									circle(line_thickness / 2, $fn = 15);
								}
							}
						}
					}
				}
			}
		}		
	}
}

/* Creates a smily face
 *
 * type - string. Type of smily. :) = normal, :D = big smile, :( = frown, ;) = wink, :| = expressionless
 * radius - float. The radius of the smily face
 * height - float. The height of the smily face, specify 0 for 2D smily
 * line_thickness - float. The thickness of the lines in the drawing
 * inverse - bool. Not a true inverse. Draws outlines instead of filling in.
 */
module smily(type = ":)", radius = 20, height = 5, line_thickness = 2, inverse = false) {
	if(height > 0) {
		linear_extrude(height = height) {
			smily_2d(type, radius, line_thickness, inverse);
		}
	}
	else {
		smily_2d(type, radius, line_thickness, inverse);
	}
}

/* Draws some smily examples
 */
module smily_examples() {
	translate([45 / 2 - (smily_count * 45 / 2), -45 / 2])
	for(type = [0 : smily_count - 1]) {
		translate([type * 45, 0, 0]) {
			smily(smily_types[type], inverse = type % 2 == 1 ? false : true);
		}
		translate([type * 45, 45, 0]) {
			smily(smily_types[type], inverse = type % 2 == 1 ? true : false);
		}
	}
}