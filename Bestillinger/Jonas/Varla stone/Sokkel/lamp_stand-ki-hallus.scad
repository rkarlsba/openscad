// Lamp Stand Design with Threaded Cover and Compartments
// Circular base with threaded top, electronics compartment, and sand chamber
// By GitHub Copilot

// Parameters
base_diameter = 220;        // Base diameter in mm
base_height = 80;           // Height of the lamp stand
wall_thickness = 8;         // Wall thickness for hollow interior
tube_hole_size = 10;        // 10x10mm square hole for aluminum tube
tube_hole_depth = 40;       // How deep the tube hole goes

// Thread parameters (metric M200x2)
thread_pitch = 2;           // Metric thread pitch
thread_depth = 1.5;         // Thread depth
thread_height = 20;         // Height of threaded section
cover_thickness = 10;       // Thickness of removable cover

// Electronics compartment
electronics_radius = 40;    // Radius of central electronics compartment
divider_thickness = 4;      // Thickness of wall between compartments

// Calculated values
base_radius = base_diameter / 2;
outer_sand_inner_radius = electronics_radius + divider_thickness;
outer_sand_outer_radius = base_radius - wall_thickness;

// Simple thread approximation module
module metric_thread_external(radius, pitch, height) {
    linear_extrude(height = height, twist = 360 * height / pitch, slices = height * 4)
        polygon([
            [radius - thread_depth, -pitch/4],
            [radius, 0],
            [radius - thread_depth, pitch/4]
        ]);
}

module metric_thread_internal(radius, pitch, height) {
    linear_extrude(height = height, twist = -360 * height / pitch, slices = height * 4)
        polygon([
            [radius, -pitch/4],
            [radius + thread_depth, 0],
            [radius, pitch/4]
        ]);
}

module lamp_stand_base() {
    difference() {
        // Main body with rounded top
        hull() {
            // Bottom cylinder (flat)
            cylinder(h = base_height - base_radius/3, r = base_radius);
            
            // Top sphere section for rounded appearance
            translate([0, 0, base_height - base_radius/3])
                sphere(r = base_radius/3);
        }
        
        // Central electronics compartment
        translate([0, 0, wall_thickness])
            cylinder(h = base_height - cover_thickness - wall_thickness, r = electronics_radius);
        
        // Outer sand compartment (ring around electronics)
        translate([0, 0, wall_thickness])
            difference() {
                cylinder(h = base_height - cover_thickness - wall_thickness, r = outer_sand_outer_radius);
                cylinder(h = base_height - cover_thickness - wall_thickness + 1, r = outer_sand_inner_radius);
            }
        
        // Threaded cavity for cover (inside the base)
        translate([0, 0, base_height - cover_thickness - thread_height])
            cylinder(h = cover_thickness + thread_height + 1, r = base_radius - wall_thickness);
        
        // Internal female threads (inside the cavity)
        translate([0, 0, base_height - cover_thickness - thread_height])
            metric_thread_internal(base_radius - wall_thickness - 1, thread_pitch, thread_height);
        
        // Square hole for 10x10mm aluminum tube - goes down from top only
        translate([0, 0, base_height - tube_hole_depth])
            linear_extrude(height = tube_hole_depth + 1)
                square([tube_hole_size, tube_hole_size], center = true);
    }
}

module lamp_stand_cover() {
    translate([base_diameter + 20, 0, 0]) {
        difference() {
            union() {
                // Cover body - sits flush with base top
                cylinder(h = cover_thickness, r = base_radius - wall_thickness - 1);
                
                // External male threads that screw into the base cavity
                translate([0, 0, cover_thickness])
                    metric_thread_external(base_radius - wall_thickness - 1, thread_pitch, thread_height);
            }
            
            // Tube hole through cover
            translate([0, 0, -1])
                linear_extrude(height = cover_thickness + thread_height + 2)
                    square([tube_hole_size, tube_hole_size], center = true);
        }
    }
}

// Render both parts
lamp_stand_base();
lamp_stand_cover();

// Optional: Show a preview of the aluminum tube
%translate([0, 0, base_height - tube_hole_depth/2])
    linear_extrude(height = tube_hole_depth + 20)
        square([tube_hole_size - 0.2, tube_hole_size - 0.2], center = true);