//
// Spiral Belly Lampshade (polyhedron) for// Ends + belly (clearance)
// outer at bottom (auto-sized for socket type)
// requested outer at top (may be raised by top opening guard)4 — hollow shell (no vase mode)
// - Axisymmetric belly for Ø80 bulb clearance (end-capped so tips honor your diameters)
// - Helical bulge: now supports multi-start (parallel helicals) via lobe_count
// - Pattern: "solid", "slots" (slits via difference), "ribbons" (bands via intersection)
// - Spider seat with ORIGINAL straight spokes, shifted 5mm inward (flush with seat)
// - Preview fix: tiny boosts to difference() heights so preview (F5) looks clean;
//   final render (F6) remains exact.
//
// Author: RoM365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview & debug
///////////////////////////
FAST_PREVIEW     = true;     // true = faster; false = smoother (higher na/nz)
SHOW_SHELL_ONLY  = false;    // render shell only (debug)
SHOW_SPIDER_ONLY = false;    // render spider only (debug)

// Preview fix for coplanar difference artifacts (F5 only; is 0 in F6)
previewfix = $preview ? 0.2 : 0;  // mm

///////////////////////////
// Pattern mode
///////////////////////////
// "solid"   = closed shell (helical bulge only)
// "slots"   = helical slots through the shell (difference: remove narrow bands)
// "ribbons" = helical ribbons (intersection: keep wide bands)
pattern = "solid";

// Helical cut parameters (for "slots" or "ribbons")
slot_count       = 2;        // 1..3
slot_width       = 12.0;     // mm (tangential width of each helical *slot* removal band)
ribbon_width     = 18.0;     // mm (tangential width of each helical *ribbon* kept band)
slot_z_margin    = 12.0;     // mm kept solid at bottom/top to preserve strength

///////////////////////////
// User Parameters
///////////////////////////

// Height & wall
height_mm            = 180;   // total height
wall_thickness       = 2.0;   // shell thickness (increased for strength)

// Ends + belly (clearance)
base_diameter        = 76;    // outer at bottom (increased for E14 lock ring clearance)
top_diameter_user    = 100;   // requested outer at top (may be raised by top opening guard)
axis_mid_diameter    = 140;   // axisymmetric belly OUTER diameter at mid (no spiral)
axis_width           = 0.35;  // belly width along Z (0.25..0.45)
belly_end_cap        = 0.30;  // fraction of height at each end where belly tapers to 0 (fixes tip inflation)

// Helical lobe (spiralling bulge)
max_mid_diameter     = 160;   // OUTER diameter at mid at the lobe crest
bulge_turns          = 0.5;   // revolutions from bottom → top
left_handed          = false; // true to reverse direction
lobe_count           = 8;     // NEW: number of parallel helical lobes (1 = single, 2 = double, etc.)
lobe_start_angle     = 0;     // starting angle of the lobes in degrees (0-360)
lobe_axis_angle      = 0;     // rotates the lobe pattern orientation (deg)
mid_position         = 0.50;  // where belly & lobe peak (0..1)
lobe_width           = 0.45;  // broader = visible over more height
lobe_power           = 70.2;   // 1=soft; 2..3=crisper lobe (cos^power, clamped ≥0)

// Height envelope control (visibility along height)
lobe_env_mix         = 0.25;  // 0.0 = flat (visible across height), 1.0 = Gaussian (focused at mid)
end_cap              = 0.04;  // fraction of height at each end where lobe → 0 (keeps ends circular)

// Socket mount (E14 or E27)
socket_type          = "E14"; // "E14" or "E27" - automatically adjusts hole size and base diameter
seat_clearance       = 0.4;   // added to hole diameter
mount_at_top         = false; // false: bottom seat; true: top seat (pendant)

// Socket-specific dimensions (calculated automatically)
socket_hole_diameter = (socket_type == "E27") ? 39.0 : 28.2; // E27: 39mm, E14: 28.2mm
mount_seat_od        = (socket_type == "E27") ? 66.0 : 50.0;  // E27: larger seat, E14: standard
mount_seat_th        = (socket_type == "E27") ? 6.0 : 5.0;    // E27: thicker for strength
base_diameter_auto   = (socket_type == "E27") ? 85 : 72;      // E27: wider base, E14: standard

// Tie ring (overlaps shell interior) + inner skirt (up the inner wall)
ring_width           = 10.0;  // tie-in ring width (increased for strength)
tie_overlap_r        = 2.0;   // mm: tie ring outer intrudes into shell inner wall by this (increased)
tie_skirt_h          = 15.0;  // mm: inner skirt height overlapping shell interior (increased)

// ORIGINAL spokes (straight rectangular bars), shifted inward
spoke_count          = 5;     // number of spokes
spoke_width          = 10.0;  // spoke bar width (tangential)
spoke_inset          = 5.0;   // mm: move the inner start 5mm closer to center (overlaps seat better)
spoke_outer_overlap  = 0.6;   // mm: extend past tie-ring inner radius by this
// Note: spokes sit FLUSH on the seat (z = 0 → mount_seat_th). In preview they get tiny height boost.

// Bulb & clearance (sphere Ø80 mm)
bulb_diameter        = 80.0;
bulb_clearance       = 3.0;   // radial clearance
auto_clearance       = true;  // auto-raise belly to ensure bulb clearance

// Top opening: fit Ø60 bulb + fingers comfortably
top_inner_min_diam   = 95.0;  // required top INNER diameter

// Quality (poly count) - balanced for detail and performance
na                   = (FAST_PREVIEW && $preview) ? 192 : 480;   // angular segments (balanced)
nz                   = (FAST_PREVIEW && $preview) ? 280 : 640;   // vertical rings (balanced)

$fn = 48; // for cylinders (seat, ring)

///////////////////////////
// Guards & constants
///////////////////////////
assert(na >= 3, "na (angular segments) must be ≥ 3");
assert(nz >= 2, "nz (vertical rings) must be ≥ 2");
assert(lobe_count >= 1, "lobe_count must be ≥ 1");
EPS = 0.05;

echo(str("na is ", na, " and nz is ", nz));

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function mix(a,b,k) = a*(1-k) + b*k;
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

// End cap taper to zero exactly at t=0 and t=1 (for the helical lobe)
function end_taper(t) =
    (t < end_cap) ? smoothstep01(t/end_cap) :
    (t > 1 - end_cap) ? smoothstep01((1 - t)/end_cap) : 1;

// Belly end cap (so axisymmetric belly adds 0 at both ends)
function end_taper_belly(t) =
    (t < belly_end_cap) ? smoothstep01(t/belly_end_cap) :
    (t > 1 - belly_end_cap) ? smoothstep01((1 - t)/belly_end_cap) : 1;

///////////////////////////
// Derived & checks
///////////////////////////
H   = height_mm;
Ro0 = base_diameter/2;

// Enforce minimum top inner diameter by raising top outer if needed
top_outer_needed = top_inner_min_diam/2 + wall_thickness;
Ro2_user         = top_diameter_user/2;
Ro2              = max(Ro2_user, top_outer_needed);

assert(Ro0 > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "Base/top diameters too small for this wall thickness.");

required_rad_inner = bulb_diameter/2 + bulb_clearance;
required_rad_outer = required_rad_inner + wall_thickness;

axis_mid_r_user    = axis_mid_diameter/2;
axis_mid_r         = auto_clearance ? max(axis_mid_r_user, required_rad_outer) : axis_mid_r_user;
max_mid_r          = max(max_mid_diameter/2, axis_mid_r + 0.01); // crest > belly

twist_sign = left_handed ? -1 : 1;

///////////////////////////
// Radius model (helical bulge on axisymmetric belly)
///////////////////////////
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Belly with end-cap so it doesn't inflate top/bottom tips
function R_belly(t) =
    let(rb   = base_top_radius(t),
        rb_m = base_top_radius(mid_position),
        A    = axis_mid_r - rb_m,
        sig  = sigma_from_width(axis_width))
    rb + end_taper_belly(t) * (A * gaussian(t, mid_position, sig));

function phi_deg(t) = lobe_start_angle + twist_sign * (bulge_turns * 360 * t);

// Height envelope for the lobe amplitude
function lobe_envelope(t) =
    let(g = gaussian(t, mid_position, sigma_from_width(lobe_width)))
    end_taper(t) * mix(1, g, clamp01(lobe_env_mix));

// Lobe amplitude (so that crest @ mid reaches max_mid_r)
function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r)
    lobe_envelope(t) * A_mid;

// NEW: Multi-start lobe shape (take the max over lobe_count evenly spaced lobes)
// Keeps amplitude normalized (doesn't exceed 1) while adding parallel helices.
function lobe_shape_multi(theta_deg, t) =
     (lobe_count <= 1)
     ? pow(max(0, cos((theta_deg - lobe_axis_angle) - phi_deg(t))), lobe_power)
     : max([ for (k=[0:lobe_count-1])
                 pow(max(0, cos((theta_deg - lobe_axis_angle) - (phi_deg(t) + k*360/lobe_count))), lobe_power)
             ]);

// Final radii
function R_outer(t, theta_deg) = R_belly(t) + lobe_amp(t) * lobe_shape_multi(theta_deg, t);
function R_inner(t, theta_deg) = R_outer(t, theta_deg) - wall_thickness;

///////////////////////////
// Polyhedron mesh (shell)
///////////////////////////
function idx_out(i,j) = i*na + (j % na);
function idx_in(i,j)  = (nz+1)*na + i*na + (j % na);

function v_out(i,j) =
    let(t = i/nz, ang = j*360/na, r = R_outer(t, ang))
    [ r*cos(ang), r*sin(ang), t*H ];

function v_in(i,j) =
    let(t = i/nz, ang = j*360/na, r = max(1, R_inner(t, ang)))
    [ r*cos(ang), r*sin(ang), t*H ];

pts_out = [ for (i=[0:nz], j=[0:na-1]) v_out(i,j) ];
pts_in  = [ for (i=[0:nz], j=[0:na-1]) v_in(i,j)  ];
points  = concat(pts_out, pts_in);

faces_outer = [
  for (i=[0:nz-1], j=[0:na-1])
  let(a=idx_out(i,j), b=idx_out(i,(j+1)%na), c=idx_out(i+1,(j+1)%na), d=idx_out(i+1,j))
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_inner = [
  for (i=[0:nz-1], j=[0:na-1])
  let(a=idx_in(i,j), b=idx_in(i+1,j), c=idx_in(i+1,(j+1)%na), d=idx_in(i,(j+1)%na))
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_bottom = [
  for (j=[0:na-1])
  let(a=idx_out(0,j), b=idx_out(0,(j+1)%na), c=idx_in(0,(j+1)%na), d=idx_in(0,j))
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_top = [
  for (j=[0:na-1])
  let(a=idx_out(nz,j), b=idx_in(nz,j), c=idx_in(nz,(j+1)%na), d=idx_out(nz,(j+1)%na))
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces = concat(faces_outer, faces_inner, faces_bottom, faces_top);

module shell_poly_raw() {
    polyhedron(points=points, faces=faces, convexity=12);
}

///////////////////////////
// Helical cutters / keepers — PREVIEW-FIXED
///////////////////////////
Rcut        = max(max_mid_r, Ro0, Ro2) + 6; // radial reach of cutters
twist_total = bulge_turns * 360 * (left_handed ? -1 : 1);

// Narrow *removal* bands for "slots"
module helical_slot_cutters() {
    h_cut = max(0, H - 2*slot_z_margin);
    if (h_cut > 0) {
        for (k=[0:slot_count-1]) {
            rotate([0,0, k*360/slot_count]) {
                // Start a bit lower & taller in preview so no coplanars
                translate([0,0, slot_z_margin - previewfix])
                    linear_extrude(height=h_cut + 2*previewfix,
                                   twist=twist_total, slices=nz, convexity=10)
                        translate([0, -slot_width/2])
                            square([Rcut + previewfix, slot_width], center=false);
            }
        }
    }
}

// Wide *keep* bands for "ribbons"
module helical_ribbon_keepers() {
    h_keep = max(0, H - 2*slot_z_margin);
    if (h_keep > 0) {
        for (k=[0:slot_count-1]) {
            rotate([0,0, k*360/slot_count]) {
                translate([0,0, slot_z_margin - previewfix])
                    linear_extrude(height=h_keep + 2*previewfix,
                                   twist=twist_total, slices=nz, convexity=10)
                        translate([0, -ribbon_width/2])
                            square([Rcut + previewfix, ribbon_width], center=false);
            }
        }
    }
}

module shell_poly() {
    if (pattern == "solid") {
        shell_poly_raw();
    } else if (pattern == "slots") {
        // Remove narrow helical bands (shell remains continuous)
        difference() {
            shell_poly_raw();
            helical_slot_cutters();
        }
    } else if (pattern == "ribbons") {
        // Keep only wide helical bands (intersection), leaving solid collars top/bottom
        intersection() {
            shell_poly_raw();
            helical_ribbon_keepers();
        }
    } else {
        shell_poly_raw();
    }
}

// Helper modules removed - no longer needed for solid mount

///////////////////////////
// Simple solid mount (no spokes, no gaps) — just a solid disk with E14 hole
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    end_t = at_top ? 1 : 0;

    let(
        // Shell outer radius at end (axisymmetric; lobe→0 at ends)
        r_out_end      = R_belly(end_t),
        
        // Solid mount extends to outer radius for proper connection to shell wall
        mount_radius   = r_out_end,
        
        // Preview-only tiny height boosts to avoid coplanar z-fighting
        seat_h         = mount_seat_th + previewfix,
        hole_h         = mount_seat_th + 2*previewfix
    )
    translate([0,0,z_mount]) difference() {

        // Solid cylinder filling the entire bottom opening
        cylinder(h=seat_h, r=mount_radius, center=false);

        // SUBTRACT: through-hole for socket spigot (+ clearance)
        translate([0,0, -previewfix])
            cylinder(h=hole_h, r=(socket_hole_diameter + seat_clearance)/2, center=false);
    }
}

///////////////////////////
// Assembly
///////////////////////////
module lampshade() {
    if (SHOW_SHELL_ONLY) {
        shell_poly();
    } else if (SHOW_SPIDER_ONLY) {
        if (!mount_at_top) {
            spider_mount_at_z(0, at_top=false);
        } else {
            translate([0,0,H - mount_seat_th - tie_skirt_h]) spider_mount_at_z(0, at_top=true);
        }
    } else {
        union() {
            shell_poly();
            if (!mount_at_top) {
                spider_mount_at_z(0, at_top=false);
            } else {
                translate([0,0,H - mount_seat_th - tie_skirt_h]) spider_mount_at_z(0, at_top=true);
            }
        }
    }
}

// Diagnostics
echo(str("Vertices: ", len(points), "  Faces: ", len(faces)));
echo(str("Axis mid outer radius (after auto_clearance) = ", axis_mid_r));
echo(str("Required outer mid radius for bulb+clearance = ", required_rad_outer));
echo(str("Top outer radius used (guarded) = ", Ro2));
echo(str("Top inner min required = ", top_inner_min_diam/2));

// Report the actual modeled top radii (belly is end-capped, lobe=0 at tips)
top_outer_from_model = R_belly(1);
top_inner_from_model = top_outer_from_model - wall_thickness;
echo(str("Computed top OUTER radius = ", top_outer_from_model,
         "  (should match Ro2) ; top INNER radius = ", top_inner_from_model));

end_t_diag        = mount_at_top ? 1 : 0;
r_in_end_diag     = R_belly(end_t_diag) - wall_thickness;
r_ring_o_diag     = r_in_end_diag + tie_overlap_r;
r_ring_i_diag     = max(mount_seat_od/2 + 1.0, r_ring_o_diag - ring_width);
r_spoke_inner_d   = max(0.1, mount_seat_od/2 - spoke_inset);
r_spoke_outer_d   = r_ring_i_diag + spoke_outer_overlap;
span_len_d        = max(0.1, r_spoke_outer_d - r_spoke_inner_d);

echo(str("Spider diag: r_in_end=", r_in_end_diag,
         "  ring_i=", r_ring_i_diag,
         "  ring_o=", r_ring_o_diag,
         "  spoke_inner=", r_spoke_inner_d,
         "  spoke_outer=", r_spoke_outer_d,
         "  span_len=", span_len_d));

///////////////////////////
// Go
///////////////////////////
lampshade();
