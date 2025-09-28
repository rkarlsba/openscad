//
// Spiral Belly Lampshade for E14 — hollow shell (no vase mode), axisymmetric belly + helical lobe
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = true;          // true = faster; false = best

///////////////////////////
// User Parameters
///////////////////////////

// Height & wall
height_mm          = 180;     // total height
wall_thickness     = 2.4;     // shell thickness (e.g., 3 perimeters @ 0.4 nozzle)

// Ends (keep them narrow)
base_diameter      = 60;      // outer diameter at bottom end
top_diameter       = 50;      // outer diameter at top end

// Axisymmetric belly (global bulge for bulb clearance)
axis_mid_diameter  = 110;     // outer diameter of the uniform belly at mid (no spiral)
axis_width         = 0.33;    // Gaussian width of belly along Z (0.25..0.45)

// Helical lobe (spiral that rides on the belly)
max_mid_diameter   = 180;     // outer diameter at mid *at the lobe crest* (visual max)
bulge_turns        = 2.0;     // how many revolutions the crest makes bottom->top
left_handed        = false;   // reverse spiral
mid_position       = 0.50;    // where the belly & lobe peak along height (0..1)
lobe_width         = 0.33;    // Gaussian width of the lobe along Z (can match axis_width)
lobe_power         = 2.0;     // 1=soft; 2..3=crisper single lobe (uses cos^power, clamped to ≥0)

// E14 mount
e14_hole_diameter  = 29.0;    // through-hole for E14 threaded spigot (28–30 mm typical)
seat_clearance     = 0.4;     // added to the hole diameter
mount_seat_od      = 44.0;    // clamp seat OD (should exceed nut OD)
mount_seat_th      = 3.0;     // seat thickness
spoke_count        = 4;       // spider struts
spoke_width        = 6.0;     // width of each strut
ring_width         = 6.0;     // tie-in inner ring width
mount_at_top       = false;   // false: seat at bottom; true: seat at top (pendant)

// Bulb & clearance
bulb_diameter      = 80.0;    // target bulb
bulb_clearance     = 3.0;     // radial clearance
auto_clearance     = true;    // if true, auto-raise axis_mid_diameter to ensure clearance

// Quality
$fn                = FAST_PREVIEW ? 96 : 200;      // circle/angle smoothness
slices_total       = FAST_PREVIEW ? 160 : 320;     // vertical helical steps
slice_thickness    = height_mm / slices_total;
ang_steps          = $fn;                           // angular sampling for the lobe profile

///////////////////////////
// Derived & checks
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

Ro0 = base_diameter/2;
Ro2 = top_diameter/2;
assert(Ro0 > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "Base/top diameters are too small for this wall thickness.");

H_shell = height_mm;
z0 = 0;

// Required clearance as OUTER radius at mid baseline
required_rad_inner   = bulb_diameter/2 + bulb_clearance;         // inner radial clearance
required_rad_outer   = required_rad_inner + wall_thickness;      // outer baseline radius needed
axis_mid_r_user      = axis_mid_diameter/2;
axis_mid_r           = auto_clearance ? max(axis_mid_r_user, required_rad_outer) : axis_mid_r_user;

// If max_mid < axis_mid, clamp it
max_mid_r_user       = max_mid_diameter/2;
max_mid_r            = max(axis_mid_r + 0.01, max_mid_r_user);   // ensure > axis_mid

// Baseline (ends) interpolation: rounded base->top
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Add a non-rotating belly centered at mid_position with width axis_width
function R_belly(t) =
    let(rb   = base_top_radius(t),
        rb_m = base_top_radius(mid_position),
        A    = axis_mid_r - rb_m,          // amplitude to reach target axis_mid_r at mid
        sig  = sigma_from_width(axis_width))
    rb + A * gaussian(t, mid_position, sig);

// Helical phase of the lobe (deg)
function phi_deg(t) = (left_handed ? -1 : 1) * (bulge_turns * 360 * t);

// Lobe amplitude vs height so that at mid crest we hit max_mid_r
function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r,
        sig   = sigma_from_width(lobe_width))
    A_mid * gaussian(t, mid_position, sig);

// Single-lobe shape (≥0, peak=1)
function lobe_shape(theta_deg) =
    pow(max(0, cos(theta_deg)), lobe_power);

// Final OUTER radius at (t,θ): belly + helical lobe
function R_outer(t, theta_deg) =
    R_belly(t) + lobe_amp(t) * lobe_shape(theta_deg - phi_deg(t));

// Inner radius
function R_inner(t, theta_deg) = R_outer(t, theta_deg) - wall_thickness;

///////////////////////////
// 2D polygon of the cross-section at fraction t
///////////////////////////
module poly_profile_at(t, is_outer=true) {
    pts = [
        for (j=[0:ang_steps-1])
            let(ang = j*360/ang_steps)
            let(r  = is_outer ? R_outer(t, ang) : max(1, R_inner(t, ang)))
            [ r*cos(ang), r*sin(ang) ]
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
// Build outer/inner helical volumes by hulling successive slabs
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
// Final shell: outer - inner  (true hollow wall)
///////////////////////////
module spiral_belly_shell() {
    difference() {
        outer_volume();
        // Slight height extension for a clean boolean
        translate([0,0,-0.05])
            scale([1,1,(H_shell + 0.1)/H_shell])
                inner_volume();
    }
}

///////////////////////////
// Spider mount (seat + struts + inner ring)
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    // At the ends, the lobe amplitude is near zero, so use the belly baseline
    r_in_end = (at_top ? R_belly(1) : R_belly(0)) - wall_thickness;

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2);

            // Inner ring to tie seat into the shell
            if (r_in_end > (mount_seat_od/2 + 2)) {
                difference() {
                    cylinder(h=mount_seat_th, r=r_in_end);
                    cylinder(h=mount_seat_th + 0.1,
                             r=max(mount_seat_od/2 + 0.2, r_in_end - ring_width));
                }

                // Struts
                span_len = max(0.1, r_in_end - mount_seat_od/2);
                for (s=[0:spoke_count-1]) {
                    rotate([0,0, s*360/spoke_count])
                        translate([mount_seat_od/2, -spoke_width/2, 0])
                            cube([span_len, spoke_width, mount_seat_th]);
                }
            }
        }
        // Through-hole for the E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + 0.4, r=(e14_hole_diameter + seat_clearance)/2);
    }
}

///////////////////////////
// Assembly
///////////////////////////
module lampshade() {
    spiral_belly_shell();

    if (!mount_at_top) {
        spider_mount_at_z(0, at_top=false);
    } else {
        spider_mount_at_z(H_shell - mount_seat_th, at_top=true);
    }
}

// Diagnostics
echo("Axis mid outer radius (after auto_clearance) = ", axis_mid_r);
echo("Required outer mid radius for bulb+clearance = ", required_rad_outer);
echo("Max mid outer radius (crest) = ", max_mid_r);
assert(axis_mid_r >= required_rad_outer,
  "Axis mid is too small for Ø80 bulb + clearance. Increase axis_mid_diameter or enable auto_clearance.");

lampshade();
