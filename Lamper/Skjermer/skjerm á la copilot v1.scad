//
// Spiral Lampshade for E14 lampholder
// - 180mm tall
// - Bulges in the middle, narrows at the top
// - Continuous helical twist
// - Mounts directly on E14 with a retaining ring
//
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// User Parameters
///////////////////////////

// Overall shape
height_mm         = 180;      // total height of the shade (Z)
base_diameter     = 140;      // diameter at the very bottom (outer)
mid_diameter      = 180;      // diameter at the mid-height (outer) -> bulge
top_diameter      = 110;      // diameter at the top (outer) -> narrower than base
wall_thickness    = 2.4;      // nominal wall thickness
turns             = 1.75;     // total turns from bottom to top (positive = CCW when viewed from top)

// Mounting to E14 ring (measure yours!)
// Typical E14 retaining ring OD is ~35–40 mm; the through-hole must pass the threaded spigot.
// Set the center hole so it passes over the threaded section; the nut clamps the "seat".
e14_hole_diameter = 29;       // Ø of through hole for E14 spigot (measure; 28–30 mm common)
mount_seat_od     = 44;       // flat clamping "seat" outer diameter (should be > ring nut OD)
mount_seat_th     = 3;        // thickness of the clamping seat
base_ring_th      = 3;        // thickness of the base ring around the seat

// Geometry quality
$fn               = 160;      // circular smoothness
slices_total      = 720;      // vertical slicing for the twist (increase for smoother twist)

// Handedness & fine control
left_handed       = false;    // true = reverse the spiral direction
mid_position      = 0.50;     // where the bulge peaks (0..1). 0.5 = middle.

// Clearances
seat_hole_extra   = 0.4;      // extra clearance on the E14 hole for fit (add to diameter)

///////////////////////////
// Derived Parameters (do not edit unless needed)
///////////////////////////

Ro0 = base_diameter/2;     // outer radius at base
Ro1 = mid_diameter/2;      // outer radius at mid
Ro2 = top_diameter/2;      // outer radius at top

// Make sure the inner radii remain positive
assert(Ro0 > wall_thickness + 1, "Base diameter too small for the chosen wall thickness.");
assert(Ro1 > wall_thickness + 1, "Mid diameter too small for the chosen wall thickness.");
assert(Ro2 > wall_thickness + 1, "Top diameter too small for the chosen wall thickness.");

Ri0 = Ro0 - wall_thickness;  // inner radius at base
Ri1 = Ro1 - wall_thickness;  // inner radius at mid
Ri2 = Ro2 - wall_thickness;  // inner radius at top

twist_deg = (left_handed ? -1 : 1) * (turns * 360);

// Split height at the bulge location (can bias if you want the max bulge above/below mid)
h1 = height_mm * clamp01(mid_position);
h2 = height_mm - h1;

// A helper to clamp 0..1
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);

///////////////////////////
// Main Assembly
///////////////////////////

module spiral_lampshade() {
    // Base: mounting seat + base ring
    base_mount_and_ring();

    // Shade body, lifted above the base ring thickness so the bottom stays open
    translate([0,0,base_ring_th])
        spiral_shell(Ro0, Ro1, Ro2, Ri0, Ri1, Ri2, height_mm - base_ring_th, twist_deg);
}

///////////////////////////
// Modules
///////////////////////////

// Mounting seat + base ring that merges into the shade
module base_mount_and_ring() {
    difference() {
        union() {
            // Base ring up to the shade's bottom radius for support and a clean start
            cylinder(h=base_ring_th, r=Ro0, center=false);

            // Central flat "seat" for the E14 retaining ring to clamp against
            cylinder(h=mount_seat_th, r=mount_seat_od/2, center=false);
        }

        // Through-hole for the E14 spigot (with small extra clearance)
        cylinder(h=mount_seat_th + base_ring_th + 0.5, r=(e14_hole_diameter + seat_hole_extra)/2, center=false);
    }
}

// Builds the hollow twisted shell by subtracting an inner solid from an outer solid,
// using two linear_extrude segments to get a mid bulge (non-linear radius profile).
module spiral_shell(Ro0, Ro1, Ro2, Ri0, Ri1, Ri2, H, twist_total) {
    difference() {
        // Outer surface
        spiral_solid(Ro0, Ro1, Ro2, H, twist_total);

        // Inner surface (slightly extended in height for clean subtraction)
        translate([0,0,-0.05])
            spiral_solid(Ri0, Ri1, Ri2, H + 0.1, twist_total);
    }
}

// A twisted & lofted solid controlled by the radii at base/mid/top.
// Implemented as two linear_extrude segments so we can bulge then taper.
module spiral_solid(r0, r1, r2, H, twist_total) {
    // Split height as per h1/h2 global
    // Compute twist allocation proportional to height
    t1 = twist_total * (h1 / (h1 + h2));
    t2 = twist_total - t1;

    // Segment 1: base -> mid
    // Scale factor from r0 to r1
    s1 = r1 / r0;
    linear_extrude(height=h1, twist=t1, scale=s1, slices=max(8, ceil(slices_total * (h1/(h1+h2)))), convexity=10)
        scale(r0) circle(r=1);

    // Segment 2: mid -> top (start already at r1)
    s2 = r2 / r1;
    translate([0,0,h1])
        linear_extrude(height=h2, twist=t2, scale=s2, slices=max(8, ceil(slices_total * (h2/(h1+h2)))), convexity=10)
        scale(r1) circle(r=1);
}

///////////////////////////
// Preview
///////////////////////////
spiral_lampshade();