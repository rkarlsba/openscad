//
// Spiral Belly Lampshade (polyhedron) for E14 — hollow shell (no vase mode)
// - Axisymmetric belly for Ø80 bulb clearance
// - Single‑lobe helical bulge with tunable height envelope & end caps
// - Pattern: "solid", "slots", "ribbons" (open spiral bands)
// - Spider seat with ORIGINAL straight spokes, shifted 5mm inward (flush with seat)
// - Preview fix: tiny boosts to difference() heights so preview (F5) looks clean;
//   final render (F6) remains exact.
//
// Author: M365 Copilot (for Roy)
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
// "slots"   = helical slots through the shell
// "ribbons" = helical ribbons (open bands)
pattern = "solid";

// Helical cut parameters (for "slots" or "ribbons")
slot_count       = 2;        // 1..3
slot_width       = 16.0;     // mm (tangential width of each helical cut)
slot_z_margin    = 12.0;     // mm kept solid at bottom/top to preserve strength

///////////////////////////
// User Parameters
///////////////////////////

// Height & wall
height_mm            = 180;   // total height
wall_thickness       = 2.4;   // shell thickness (≈ 3 perimeters @ 0.4mm nozzle)

// Ends + belly (clearance)
base_diameter        = 60;    // outer at bottom
top_diameter_user    = 100;   // requested outer at top (may be raised by top opening guard)
axis_mid_diameter    = 140;   // axisymmetric belly OUTER diameter at mid (no spiral)
axis_width           = 0.35;  // belly width along Z (0.25..0.45)

// Helical lobe (spiralling bulge)
max_mid_diameter     = 210;   // OUTER diameter at mid at the lobe crest
bulge_turns          = 2.0;   // revolutions from bottom → top
left_handed          = false; // true to reverse direction
mid_position         = 0.50;  // where belly & lobe peak (0..1)
lobe_width           = 0.45;  // broader = visible over more height
lobe_power           = 2.2;   // 1=soft; 2..3=crisper lobe (cos^power, clamped ≥0)

// Height envelope control (visibility along height)
lobe_env_mix         = 0.25;  // 0.0 = flat (visible across height), 1.0 = Gaussian (focused at mid)
end_cap              = 0.04;  // fraction of height at each end where lobe → 0 (keeps ends circular)

// E14 mount (measure your hardware)
e14_hole_diameter    = 29.0;  // through-hole for E14 spigot (28–30 mm typical)
seat_clearance       = 0.4;   // added to hole diameter
mount_seat_od        = 44.0;  // seat OD (must exceed nut OD)
mount_seat_th        = 3.0;   // seat thickness
mount_at_top         = false; // false: bottom seat; true: top seat (pendant)

// Tie ring (overlaps shell interior) + inner skirt (up the inner wall)
ring_width           = 8.0;   // tie-in ring width (radial thickness)
tie_overlap_r        = 1.2;   // mm: tie ring outer intrudes into shell inner wall by this
tie_skirt_h          = 10.0;  // mm: inner skirt height overlapping shell interior

// ORIGINAL spokes (straight rectangular bars), shifted inward
spoke_count          = 4;     // number of spokes
spoke_width          = 7.0;   // spoke bar width (tangential)
spoke_inset          = 5.0;   // mm: move the inner start 5mm closer to center (overlaps seat better)
spoke_outer_overlap  = 0.6;   // mm: extend past tie-ring inner radius by this
// Note: spokes sit FLUSH on the seat (z = 0 → mount_seat_th). In preview they get tiny height boost.

// Bulb & clearance (sphere Ø80 mm)
bulb_diameter        = 80.0;
bulb_clearance       = 3.0;   // radial clearance
auto_clearance       = true;  // auto-raise belly to ensure bulb clearance

// Top opening: fit Ø60 bulb + fingers comfortably
top_inner_min_diam   = 95.0;  // required top INNER diameter

// Quality (poly count)
na                   = FAST_PREVIEW ? 96  : 160;   // angular segments
nz                   = FAST_PREVIEW ? 140 : 240;   // vertical rings

$fn = 64; // for cylinders (seat, ring)

///////////////////////////
// Guards & constants
///////////////////////////
assert(na >= 3, "na (angular segments) must be ≥ 3");
assert(nz >= 2, "nz (vertical rings) must be ≥ 2");
EPS = 0.05;
PI  = 3.141592653589793;

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function mix(a,b,k) = a*(1-k) + b*k;
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

// End cap taper to zero exactly at t=0 and t=1
function end_taper(t) =
    (t < end_cap) ? smoothstep01(t/end_cap) :
    (t > 1 - end_cap) ? smoothstep01((1 - t)/end_cap) : 1;

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

function R_belly(t) =
    let(rb   = base_top_radius(t),
        rb_m = base_top_radius(mid_position),
        A    = axis_mid_r - rb_m,
        sig  = sigma_from_width(axis_width))
    rb + A * gaussian(t, mid_position, sig);

function phi_deg(t) = twist_sign * (bulge_turns * 360 * t);

function lobe_envelope(t) =
    let(g = gaussian(t, mid_position, sigma_from_width(lobe_width)))
    end_taper(t) * mix(1, g, clamp01(lobe_env_mix));

function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r)
    lobe_envelope(t) * A_mid;

function lobe_shape(theta_deg) = pow(max(0, cos(theta_deg)), lobe_power);

function R_outer(t, theta_deg) = R_belly(t) + lobe_amp(t) * lobe_shape(theta_deg - phi_deg(t));
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
// Helical cutters (for "slots" and "ribbons") — PREVIEW-FIXED
///////////////////////////
Rcut = max(max_mid_r, Ro0, Ro2) + 6; // radial reach of cutters
twist_total = bulge_turns * 360 * (left_handed ? -1 : 1);

module helical_cutters() {
    h_cut = max(0, H - 2*slot_z_margin);
    if (h_cut > 0) {
        for (k=[0:slot_count-1]) {
            rotate([0,0, k*360/slot_count]) {
                // start slightly lower and cut slightly taller in preview to avoid coplanar
                translate([0,0, slot_z_margin - previewfix])
                    linear_extrude(height=h_cut + 2*previewfix, twist=twist_total, slices=nz, convexity=10)
                        translate([0, -slot_width/2])
                            square([Rcut + previewfix, slot_width], center=false);
            }
        }
    }
}

module shell_poly() {
    if (pattern == "solid") {
        shell_poly_raw();
    } else if (pattern == "slots" || pattern == "ribbons") {
        // Preview fix applied via enlarged cutters
        difference() { shell_poly_raw(); helical_cutters(); }
    } else {
        shell_poly_raw();
    }
}

///////////////////////////
// Helper modules for spokes (GLOBAL to avoid parser errors)
///////////////////////////
module spoke_bar_rect(r0, r1, w, h) {
    translate([r0, -w/2, 0]) cube([max(0.2, r1 - r0), w, h], center=false);
}

module spoke_bar_obround(r0, r1, w, h) {
    // Obround = center plank shortened by w + end caps (cylinders)
    len = max(0, (r1 - r0) - w);
    union() {
        if (len > 0)
            translate([r0 + w/2, -w/2, 0]) cube([len, w, h], center=false);
        // End caps
        translate([r0 + w/2, 0, 0]) cylinder(h=h, r=w/2, center=false);
        translate([r1 - w/2, 0, 0]) cylinder(h=h, r=w/2, center=false);
    }
}

///////////////////////////
// Spider mount (seat + tie ring + ORIGINAL straight spokes) — preview-safe & nicer from below
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    end_t = at_top ? 1 : 0;

    let(
        // Shell inner radius at end (axisymmetric; lobe→0 at ends)
        r_in_end       = R_belly(end_t) - wall_thickness,

        // Tie ring (positive overlap into the shell; never protrudes outside)
        r_ring_o       = r_in_end + tie_overlap_r,
        r_ring_i_raw   = r_ring_o - ring_width,
        r_ring_i       = max(mount_seat_od/2 + 1.0, r_ring_i_raw),

        // ORIGINAL straight spokes, shifted inward by spoke_inset
        r_spoke_inner  = max(0.1, mount_seat_od/2 - spoke_inset),
        r_spoke_outer  = r_ring_i + spoke_outer_overlap,
        span_len       = max(0.2, r_spoke_outer - r_spoke_inner),

        // Preview-only tiny height boosts to avoid coplanar z-fighting in underside view
        seat_h         = mount_seat_th + previewfix,
        ring_h         = mount_seat_th + previewfix,
        skirt_h        = tie_skirt_h   + previewfix,
        hole_h         = mount_seat_th + tie_skirt_h + 0.8 + 2*previewfix
    )
    translate([0,0,z_mount]) difference() {

        // --- UNION: seat + tie ring + skirt + spokes ---
        union() {

            // Seat (sits on z=0; a hair taller in preview)
            cylinder(h=seat_h, r=mount_seat_od/2, center=false);

            // Tie ring (same base; inner subtraction a hair taller → no coplanar)
            difference() {
                cylinder(h=ring_h,         r=r_ring_o, center=false);
                cylinder(h=ring_h + 0.02,  r=r_ring_i, center=false);
            }

            // Inner skirt (overlaps inside shell; starts just above seat)
            translate([0,0,mount_seat_th - 0.01])
                difference() {
                    cylinder(h=skirt_h + 0.02, r=r_ring_o, center=false);
                    cylinder(h=skirt_h + 0.03, r=r_ring_i, center=false);
                }

            // SPOKES: obround in preview (nicer), rectangular in final render
            for (s=[0:spoke_count-1]) {
                rotate([0,0, s*360/spoke_count]) {
                    if ($preview)
                        spoke_bar_obround(r_spoke_inner, r_spoke_outer, spoke_width, seat_h);
                    else
                        spoke_bar_rect   (r_spoke_inner, r_spoke_outer, spoke_width, mount_seat_th);
                }
            }
        }

        // SUBTRACT: through-hole for E14 spigot (+ clearance) — start lower & taller in preview
        translate([0,0, -previewfix])
            cylinder(h=hole_h, r=(e14_hole_diameter + seat_clearance)/2, center=false);
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
echo(str("Top outer radius used = ", Ro2));
echo(str("Top inner min required = ", top_inner_min_diam/2));

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
