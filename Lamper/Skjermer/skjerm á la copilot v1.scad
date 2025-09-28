//
// True-Helix Spiral Lampshade for E14
// - 180 mm tall
// - Smooth bulge in the middle, narrower at top (C1-like smooth radius)
// - Real helical spiral (lofted by hulling rotated thin rings)
// - Mounts on an E14 lampholder with retaining ring
//
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = false;     // true = faster render (coarser); false = smooth final

///////////////////////////
// User Parameters
///////////////////////////

// Overall size
height_mm         = 180;     // total height
base_diameter     = 140;     // outer diameter at bottom
mid_diameter      = 180;     // outer diameter at bulge peak
top_diameter      = 110;     // outer diameter at top
wall_thickness    = 2.4;     // nominal shell thickness

// Spiral
turns             = 2.0;     // total helical turns from bottom to top
left_handed       = false;   // true = reverse twist direction

// Bulge shaping
mid_position      = 0.50;    // where the bulge peaks (0..1)
bulge_width       = 0.34;    // bulge width as fraction of height (Gaussian sigma approx.)
// Tip: smaller = tighter bulge; larger = broader bulge

// E14 mounting (measure your holder!)
e14_hole_diameter = 29.0;    // through-hole for E14 threaded spigot (28–30 mm typical)
seat_clearance    = 0.4;     // extra clearance on the E14 hole
mount_seat_od     = 44.0;    // clamping "seat" outer diameter (should exceed nut OD)
mount_seat_th     = 3.0;     // thickness of seat disk
base_ring_th      = 3.0;     // thickness of base ring (ties seat to the shade)

// Geometry quality
$fn               = FAST_PREVIEW ? 80 : 160;        // circular smoothness
slices_total      = FAST_PREVIEW ? 140 : 300;       // how many vertical “steps” the helix uses
slice_thickness   = height_mm / slices_total;       // thickness of each thin ring (Z)

// Safety check
assert(base_diameter/2 > wall_thickness + 1, "Base dia too small for chosen wall thickness.");
assert(mid_diameter/2  > wall_thickness + 1, "Mid dia too small for chosen wall thickness.");
assert(top_diameter/2  > wall_thickness + 1, "Top dia too small for chosen wall thickness.");

///////////////////////////
// Derived values
///////////////////////////
Ro0 = base_diameter/2;
RoM = mid_diameter/2;
Ro2 = top_diameter/2;
twist_deg_total = (left_handed ? -1 : 1)*(turns*360);

H_shell = height_mm - base_ring_th;
z0      = base_ring_th;   // start of the helical shell above the base ring

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt = clamp01(t)) tt*tt*(3 - 2*tt); // cubic smoothstep

// Smooth base→top interpolation (without bulge), eased for rounded transition
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Gaussian bump centered at mid_position, scaled so that R(mid)=RoM exactly
function sigma_from_width(w) = max(0.05, w);  // keep numeric stability
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));

// Compute outer radius at fraction t of height, with an exact mid-radius target
function outer_radius(t) =
    let( rb   = base_top_radius(t),
         rb_m = base_top_radius(mid_position),
         A    = RoM - rb_m, // amplitude needed to hit mid radius exactly
         sig  = sigma_from_width(bulge_width) )
    rb + A * gaussian(t, mid_position, sig);

// Inner radius (must remain positive!)
function inner_radius(t) = outer_radius(t) - wall_thickness;

// Angle of rotation (deg) at fraction t
function phi_deg(t) = twist_deg_total * t;

///////////////////////////
// Primitive: one thin ring slice at (t)
///////////////////////////
module ring_slice_at(t, z_offset=0) {
    r_out = outer_radius(t);
    r_in  = inner_radius(t);
    // guard
    if (r_in <= 1)
        echo("Warning: inner radius negative/too small at t=", t, " -> r_in=", r_in);

    translate([0,0,z0 + t*H_shell + z_offset])
        rotate([0,0,phi_deg(t)])
            linear_extrude(height=slice_thickness)
                difference() {
                    circle(r=r_out);
                    circle(r=max(1, r_in));
                }
}

///////////////////////////
// Build: helical shell by hulling successive ring slices
///////////////////////////
module helical_shell() {
    for (i=[0:slices_total-1]) {
        t0 = i/slices_total;
        t1 = (i+1)/slices_total;
        hull() {
            ring_slice_at(t0, 0);
            ring_slice_at(t1, 0);
        }
    }
}

///////////////////////////
// Base mount: seat + ring + center hole
///////////////////////////
module base_mount_and_ring() {
    difference() {
        union() {
            // Base ring that matches the shade’s base radius
            cylinder(h=base_ring_th, r=Ro0, center=false);
            // Central flat seat for the E14 retaining ring to clamp on
            cylinder(h=mount_seat_th, r=mount_seat_od/2, center=false);
        }
        // Through-hole for E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + base_ring_th + 0.6,
                 r=(e14_hole_diameter + seat_clearance)/2, center=false);
    }
}

///////////////////////////
// Main
///////////////////////////
module spiral_lampshade() {
    base_mount_and_ring();
    helical_shell();
}

spiral_lampshade();