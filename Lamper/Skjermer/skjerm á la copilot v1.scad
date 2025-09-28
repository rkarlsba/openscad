//
// True-Helix Spiral Lampshade for E14 — visible spiral slots, smooth bulge, thick walls
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = true;      // true = faster; false = best quality

///////////////////////////
// User Parameters
///////////////////////////

// Overall size & wall
height_mm         = 180;     // total height of the shade
wall_thickness    = 2.4;     // shell thickness (≥ nozzle * 3 recommended)

// Profile (strongly tapered ends + mid bulge)
// NOTE: These are OUTER diameters.
base_diameter     = 70;      // very narrow at bottom
mid_diameter      = 180;     // bulge (ensures bulb space)
top_diameter      = 60;      // very narrow at top

// Spiral shape
turns             = 2.0;     // total helical turns from base to top (float)
left_handed       = false;   // true = reverse twist direction

// Bulge shaping (smooth, rounded)
mid_position      = 0.50;    // where the bulge peaks (0..1)
bulge_width       = 0.34;    // Gaussian width; smaller = tighter bulge

// E14 Mount (measure yours!)
e14_hole_diameter = 29.0;    // through-hole for E14 threaded spigot (28–30 mm typical)
seat_clearance    = 0.4;     // extra clearance for fit
mount_seat_od     = 44.0;    // seat disc outer diameter (should exceed nut OD)
mount_seat_th     = 3.0;     // seat thickness
spoke_count       = 4;       // spider struts connecting seat to the shell
spoke_width       = 6.0;     // strut width (radial direction is auto by geometry)
ring_width        = 6.0;     // inner base ring width that ties into the shell
mount_at_top      = false;   // false: seat at bottom (table/standard); true: seat at top (pendant)

// Spiral slots (make the helix visible)
// Set enable_slots=false if you want a fully closed shade (I can add ribs instead).
enable_slots      = true;
slot_count        = 2;       // number of helical slots (multi-start)
slot_width        = 10.0;    // slot width (tangential)
slot_z_margin     = 6.0;     // keep slots away from very bottom/top (mm)

// Geometry quality
$fn               = FAST_PREVIEW ? 96 : 180;              // circular smoothness
slices_total      = FAST_PREVIEW ? 180 : 320;             // vertical helical steps
slice_thickness   = height_mm / slices_total;

// Bulb clearance (80mm bulb)
bulb_diameter     = 80.0;
bulb_clearance    = 3.0;     // radial clearance margin (≥2–3mm recommended)

///////////////////////////
// Derived values
///////////////////////////
Ro0 = base_diameter/2;
RoM = mid_diameter/2;
Ro2 = top_diameter/2;

assert(Ro0 > wall_thickness + 1 && RoM > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "One of the diameters is too small for the chosen wall thickness.");

Ri0 = Ro0 - wall_thickness;
RiM = RoM - wall_thickness;
Ri2 = Ro2 - wall_thickness;

twist_deg_total = (left_handed ? -1 : 1) * (turns * 360);

Rmax = max(Ro0, RoM, Ro2);
Rmin = min(Ro0, RoM, Ro2);

H_shell = height_mm;
z0 = 0; // we keep the inside open from the bottom/top depending on mount

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt = clamp01(t)) tt*tt*(3 - 2*tt);

// Smooth base→top interpolation (rounded)
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Gaussian bump centered at mid_position, scaled to hit RoM exactly
function sigma_from_width(w) = max(0.05, w);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));

// Outer radius at t
function outer_radius(t) =
    let(rb   = base_top_radius(t),
        rb_m = base_top_radius(mid_position),
        A    = RoM - rb_m,
        sig  = sigma_from_width(bulge_width))
    rb + A * gaussian(t, mid_position, sig);

// Inner radius
function inner_radius(t) = outer_radius(t) - wall_thickness;

// Angle (degrees) at t
function phi_deg(t) = twist_deg_total * t;

///////////////////////////
// Ring slice at t (helical hull primitive)
///////////////////////////
module ring_slice_at(t) {
    r_out = outer_radius(t);
    r_in  = inner_radius(t);
    if (r_in <= 1) echo("Warning: inner radius small at t=", t, " r_in=", r_in);

    translate([0,0,z0 + t*H_shell])
      rotate([0,0,phi_deg(t)])
        linear_extrude(height=slice_thickness)
          difference() {
            circle(r=r_out);
            circle(r=max(1, r_in));
          }
}

///////////////////////////
// Helical shell (closed, smooth bulge)
///////////////////////////
module helical_shell() {
    for (i=[0:slices_total-1]) {
        t0 = i/slices_total;
        t1 = (i+1)/slices_total;
        hull() {
            ring_slice_at(t0);
            ring_slice_at(t1);
        }
    }
}

///////////////////////////
// Helical slot cutters (to make the spiral visible)
///////////////////////////
module helical_slots() {
    // Slots start & end with margin from both ends
    h_cut = max(0, H_shell - 2*slot_z_margin);

    // Only build slots if there is usable height
    if (h_cut > 0) {
        for (k = [0:slot_count-1]) {
            rotate([0,0, k*360/slot_count]) {
                translate([0,0,z0 + slot_z_margin])
                  linear_extrude(height=h_cut,
                                 twist=twist_deg_total,
                                 slices=slices_total,
                                 convexity=10)
                    // A radial slab from center to beyond max radius; narrow tangential width => slot width
                    translate([0, -slot_width/2])
                      square([Rmax + 8, slot_width], center=false);
            }
        }
    }
}

///////////////////////////
// Base "spider" mount: seat + struts + inner ring (keeps bottom open)
///////////////////////////
module spider_mount_at_z(z_mount) {
    translate([0,0,z_mount]) difference() {
        // Union of seat, struts, and inner ring
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2);

            // Inner ring that ties into the shell’s inner wall near t=0 (or t=1 if top-mounted)
            // Place ring adjacent to the shell’s inner radius at that end
            r_in_end = (z_mount == 0) ? inner_radius(0) : inner_radius(1);
            if (r_in_end > (mount_seat_od/2 + 2)) {
                difference() {
                    cylinder(h=mount_seat_th, r=r_in_end);
                    cylinder(h=mount_seat_th + 0.1, r=max(mount_seat_od/2 + 0.2, r_in_end - ring_width));
                }
            }

            // Struts (spokes) from seat to ring
            span_len = max(0.1, r_in_end - mount_seat_od/2);
            for (s=[0:spoke_count-1]) {
                rotate([0,0, s*360/spoke_count])
                    translate([mount_seat_od/2, -spoke_width/2, 0])
                        cube([span_len, spoke_width, mount_seat_th]);
            }
        }

        // Central through-hole for the E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + 0.4, r=(e14_hole_diameter + seat_clearance)/2);
    }
}

///////////////////////////
// Assembly
///////////////////////////
module shade_body_with_slots() {
    if (enable_slots) {
        difference() {
            helical_shell();
            helical_slots();
        }
    } else {
        helical_shell();
    }
}

module spiral_lampshade() {
    if (!mount_at_top) {
        // Seat at bottom (z=0)
        spider_mount_at_z(0);
        translate([0,0,0]) shade_body_with_slots();
    } else {
        // Seat at top (invert along Z)
        // Build the body then add seat at top plane
        translate([0,0,0]) shade_body_with_slots();
        spider_mount_at_z(H_shell - mount_seat_th);
    }
}

// --- Sanity checks / informative echoes ---
echo("Ri(mid) = ", RiM, "  (must be ≥ ", (bulb_diameter/2 + bulb_clearance), ")");
assert(RiM >= (bulb_diameter/2 + bulb_clearance),
       "Inner radius at bulge is too small for the 80mm bulb + clearance. Increase mid_diameter or reduce wall_thickness.");

spiral_lampshade();
