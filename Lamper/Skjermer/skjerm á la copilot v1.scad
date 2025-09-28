//
// Helical Bulge Lampshade for E14 — hollow shell (no vase mode), smooth single-lobe spiral
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = true;         // true = faster; false = best

///////////////////////////
// User Parameters
///////////////////////////

// Overall height & wall
height_mm         = 180;     // total height
wall_thickness    = 2.4;     // shell thickness (e.g., 3 perimeters @ 0.4 mm nozzle)

// Shape: narrow ends + mid target
// These are OUTER diameters where the shape's "baseline" (without bulge) would be.
base_diameter     = 60;      // narrow bottom
mid_diameter      = 180;     // target max diameter at bulge peak (outer)
top_diameter      = 50;      // narrow top

// Helical bulge controls
bulge_turns       = 2.0;     // how many revolutions the bulge makes bottom->top
left_handed       = false;   // true = reverse direction
mid_position      = 0.50;    // z-position (0..1) where bulge amplitude peaks
bulge_width       = 0.33;    // Gaussian width (0.2..0.5, smaller = tighter belly)
lobe_power        = 2.0;     // angular sharpness of bulge (1=soft sine, 2..4 tighter lobe)

// E14 mount (measure your hardware!)
e14_hole_diameter = 29.0;    // through-hole for E14 spigot (28–30 mm typical)
seat_clearance    = 0.4;     // clearance on the hole (added to diameter)
mount_seat_od     = 44.0;    // clamp seat OD (should exceed nut OD)
mount_seat_th     = 3.0;     // seat thickness
spoke_count       = 4;       // spider struts count
spoke_width       = 6.0;     // strut width
ring_width        = 6.0;     // inner tie-in ring width
mount_at_top      = false;   // false: seat at bottom; true: seat at top (pendant)

// Bulb clearance (sphere Ø80 mm)
bulb_diameter     = 80.0;
bulb_clearance    = 3.0;     // radial clearance (≥2–3 mm)

// Geometry quality
$fn               = FAST_PREVIEW ? 96 : 200;      // circle smoothness (also used for angular samples)
slices_total      = FAST_PREVIEW ? 160 : 320;     // vertical steps of the hull
slice_thickness   = height_mm / slices_total;
ang_steps         = $fn;                           // angular resolution for the bulged profile

///////////////////////////
// Derived values & checks
///////////////////////////
Ro0 = base_diameter/2;
RoM = mid_diameter/2;
Ro2 = top_diameter/2;

assert(Ro0 > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "Base/top diameters are too small for this wall thickness.");

H_shell = height_mm;
z0 = 0;

// Convenience
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

// Baseline (axisymmetric) radius progression bottom -> top (rounded)
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Helical phase (degrees) bottom -> top for the bulge
function phi_deg(t) = (left_handed ? -1 : 1) * (bulge_turns * 360 * t);

// Bulge amplitude along height: choose amplitude s.t. max radius at mid == RoM
function amplitude_at_t(t) =
    let(rb_mid = base_top_radius(mid_position),
        A_mid  = RoM - rb_mid,                 // needed amplitude to hit target at mid
        sig    = sigma_from_width(bulge_width))
    A_mid * gaussian(t, mid_position, sig);

// Angular bulge shape (single lobe, >= 0, peak=1)
function bulge_shape(theta_deg) =
    pow(max(0, cos(theta_deg)), lobe_power);

// Outer radius as function of height fraction t and angle θ (deg)
function R_outer(t, theta_deg) =
    base_top_radius(t) + amplitude_at_t(t) * bulge_shape(theta_deg - phi_deg(t));

// Inner radius approx (radial offset)
function R_inner(t, theta_deg) = R_outer(t, theta_deg) - wall_thickness;

///////////////////////////
// 2D profile polygon at fraction t (outer/inner)
///////////////////////////
module poly_profile_at(t, is_outer=true) {
    // Build a polar polygon
    pts = [
        for (j=[0:ang_steps-1]) 
            let(ang = j*360/ang_steps)
            let(r  = is_outer ? R_outer(t, ang) : max(1, R_inner(t, ang)))
            [ r * cos(ang), r * sin(ang) ]
    ];
    polygon(points=pts);
}

///////////////////////////
// One thin slab at fraction t
///////////////////////////
module slab_at(t, is_outer=true) {
    translate([0,0,z0 + t*H_shell])
        linear_extrude(height=slice_thickness)
            poly_profile_at(t, is_outer);
}

///////////////////////////
// Build outer and inner helical volumes by hulling successive slabs
///////////////////////////
module outer_volume() {
    for (i=[0:slices_total-1]) {
        t0 = i/slices_total;
        t1 = (i+1)/slices_total;
        hull() {
            slab_at(t0, true);
            slab_at(t1, true);
        }
    }
}

module inner_volume() {
    for (i=[0:slices_total-1]) {
        t0 = i/slices_total;
        t1 = (i+1)/slices_total;
        hull() {
            slab_at(t0, false);
            slab_at(t1, false);
        }
    }
}

///////////////////////////
// Final shell: outer - inner  (true hollow wall, no vase mode needed)
///////////////////////////
module helical_bulge_shell() {
    difference() {
        outer_volume();
        // Slightly extend inner to make a clean subtraction at ends
        translate([0,0,-0.05]) scale([1,1,(H_shell+0.1)/H_shell]) inner_volume();
    }
}

///////////////////////////
// Spider mount (seat + struts + inner ring) at z = z_mount
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    // Choose the "end" baseline inner radius (no bulge at ends due to Gaussian → amplitude≈0)
    r_in_end = (at_top ? base_top_radius(1) : base_top_radius(0)) - wall_thickness;

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2);

            // Tie-in inner ring if space permits
            if (r_in_end > (mount_seat_od/2 + 2)) {
                difference() {
                    cylinder(h=mount_seat_th, r=r_in_end);
                    cylinder(h=mount_seat_th + 0.1,
                             r=max(mount_seat_od/2 + 0.2, r_in_end - ring_width));
                }
                // Struts (spokes) from seat to ring
                span_len = max(0.1, r_in_end - mount_seat_od/2);
                for (s=[0:spoke_count-1]) {
                    rotate([0,0, s*360/spoke_count])
                        translate([mount_seat_od/2, -spoke_width/2, 0])
                            cube([span_len, spoke_width, mount_seat_th]);
                }
            }
        }
        // Through hole
        cylinder(h=mount_seat_th + 0.4, r=(e14_hole_diameter + seat_clearance)/2);
    }
}

///////////////////////////
// Assembly
///////////////////////////
module lampshade() {
    // The helical shell is open at both ends by construction
    helical_bulge_shell();

    // Add E14 seat + spider at chosen end
    if (!mount_at_top) {
        // Seat at bottom (z=0)
        spider_mount_at_z(0, at_top=false);
    } else {
        // Seat at top (z=height - seat_th)
        spider_mount_at_z(H_shell - mount_seat_th, at_top=true);
    }
}

// --- Safety check for the 80 mm bulb ---
// Require the MIN inner radius at mid (baseline, i.e., without the bulge) to clear the bulb.
// This guarantees clearance around the "narrow" side too.
Ri_mid_baseline = base_top_radius(mid_position) - wall_thickness;
required_rad    = bulb_diameter/2 + bulb_clearance;
echo("Baseline inner radius at mid = ", Ri_mid_baseline, "  (required ≥ ", required_rad, ")");
assert(Ri_mid_baseline >= required_rad,
       "Baseline inner radius at mid is too small for Ø80 bulb + clearance. Increase base/top/mid or reduce wall thickness.");

lampshade();
