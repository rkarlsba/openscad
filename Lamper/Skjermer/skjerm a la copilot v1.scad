//
// Spiral Belly Lampshade (polyhedron) for E14 — hollow shell (no vase mode)
// - Axisymmetric belly for bulb clearance
// - Single-lobe helical bulge with tunable height envelope & end caps
// - Robust spider seat with positive overlaps (manifold-safe)
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = true;   // true = faster; false = smoother

///////////////////////////
// User Parameters
///////////////////////////

// Height & wall
height_mm            = 180;     // total height
wall_thickness       = 2.4;     // shell thickness (e.g., 3 perimeters @ 0.4 nozzle)

// Ends + belly (clearance)
base_diameter        = 60;      // outer at bottom
top_diameter_user    = 100;     // requested outer at top (may be raised to meet top opening min)
axis_mid_diameter    = 135;     // axisymmetric belly OUTER diameter at mid (no spiral)
axis_width           = 0.35;    // belly width along Z (0.25..0.45)

// Helical lobe (spiralling bulge)
max_mid_diameter     = 205;     // OUTER diameter at mid at the lobe crest
bulge_turns          = 2.0;     // revolutions from bottom → top
left_handed          = false;   // true to reverse direction
mid_position         = 0.50;    // where belly & lobe peak (0..1)
lobe_width           = 0.35;    // Gaussian width of lobe along Z
lobe_power           = 2.2;     // 1=very soft; 2..3=crisper lobe (cos^power, clamped ≥0)

// Height envelope control for the lobe (visibility along height)
lobe_env_mix         = 0.45;    // 0.0 = flat (visible across height), 1.0 = Gaussian (focused at mid)
end_cap              = 0.05;    // fraction of height at each end where lobe → 0 (keeps ends circular)

// E14 mount (measure your hardware)
e14_hole_diameter    = 29.0;    // through-hole for E14 spigot (28–30 mm typical)
seat_clearance       = 0.4;     // added to hole diameter
mount_seat_od        = 44.0;    // seat OD (must exceed nut OD)
mount_seat_th        = 3.0;     // seat thickness
spoke_count          = 4;       // spider struts
spoke_width          = 6.0;     // strut width
ring_width           = 6.0;     // tie-in ring width (radial)
mount_at_top         = false;   // false: bottom seat; true: top seat (pendant)

// Robust union with shell (avoid gaps/coplanars)
tie_overlap_r        = 0.5;     // mm: expand tie ring outer radius into shell inner wall
tie_skirt_h          = 5.0;     // mm: inner skirt height overlapping shell interior
spoke_overlap_r      = 0.6;     // mm: how far spokes push into the tie ring
spoke_z_bite         = 0.2;     // mm: spokes start slightly below seat (negative z) to avoid coplanar
spoke_to_skirt       = true;    // true: spokes run tall to intersect skirt as well

// Bulb & clearance (sphere Ø80 mm)
bulb_diameter        = 80.0;
bulb_clearance       = 3.0;     // radial
auto_clearance       = true;    // auto-raise belly to ensure bulb clearance

// Top opening: fit Ø60 bulb + fingers
top_inner_min_diam   = 85.0;    // required top INNER diameter

// Quality (poly count)
na                   = FAST_PREVIEW ? 96  : 160;   // angular segments
nz                   = FAST_PREVIEW ? 140 : 240;   // vertical rings

$fn = 64; // for cylinders (seat, ring), unrelated to the mesh resolution

///////////////////////////
// Guards
///////////////////////////
assert(na >= 3, "na (angular segments) must be ≥ 3");
assert(nz >= 2, "nz (vertical rings) must be ≥ 2");

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
H = height_mm;
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
// Radius model
///////////////////////////
// Rounded base->top baseline (axisymmetric)
function base_top_radius(t) = Ro0 + (Ro2 - Ro0)*smoothstep01(t);

// Axisymmetric belly centered at mid_position
function R_belly(t) =
    let(rb   = base_top_radius(t),
        rb_m = base_top_radius(mid_position),
        A    = axis_mid_r - rb_m,
        sig  = sigma_from_width(axis_width))
    rb + A * gaussian(t, mid_position, sig);

// Helical phase (deg)
function phi_deg(t) = twist_sign * (bulge_turns * 360 * t);

// Lobe amplitude envelope along height:
// - gaussian around mid
// - flat (constant 1)
// Blend between them with lobe_env_mix, then apply end caps.
function lobe_envelope(t) =
    let(g = gaussian(t, mid_position, sigma_from_width(lobe_width)))
    end_taper(t) * mix(1, g, clamp01(lobe_env_mix));

// Lobe amplitude (so that crest @ mid reaches max_mid_r)
function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r)
    lobe_envelope(t) * A_mid;

// Single-lobe shape (≥0, peak 1) around angle theta (deg)
function lobe_shape(theta_deg) = pow(max(0, cos(theta_deg)), lobe_power);

// Outer/inner radius at (t,θ)
function R_outer(t, theta_deg) = R_belly(t) + lobe_amp(t) * lobe_shape(theta_deg - phi_deg(t));
function R_inner(t, theta_deg) = R_outer(t, theta_deg) - wall_thickness;

///////////////////////////
// Indexing helpers for polyhedron vertex array
///////////////////////////
function idx_out(i,j) = i*na + (j % na);
function idx_in(i,j)  = (nz+1)*na + i*na + (j % na);

///////////////////////////
// Build point arrays
///////////////////////////
function v_out(i,j) = 
    let(t = i/nz, ang = j*360/na, r = R_outer(t, ang))
    [ r*cos(ang), r*sin(ang), t*H ];

function v_in(i,j) =
    let(t = i/nz, ang = j*360/na, r = max(1, R_inner(t, ang)))
    [ r*cos(ang), r*sin(ang), t*H ];

pts_out = [ for (i=[0:nz], j=[0:na-1]) v_out(i,j) ];
pts_in  = [ for (i=[0:nz], j=[0:na-1]) v_in(i,j)  ];
points  = concat(pts_out, pts_in);

///////////////////////////
// Faces: outer surface (CCW outward), inner surface (reverse), edge rings
///////////////////////////
faces_outer = [
  for (i=[0:nz-1], j=[0:na-1])
  let(
    a = idx_out(i,   j),
    b = idx_out(i,   (j+1) % na),
    c = idx_out(i+1, (j+1) % na),
    d = idx_out(i+1, j)
  )
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_inner = [
  for (i=[0:nz-1], j=[0:na-1])
  let(
    a = idx_in(i,   j),
    b = idx_in(i+1, j),
    c = idx_in(i+1, (j+1) % na),
    d = idx_in(i,   (j+1) % na)
  )
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_bottom = [
  for (j=[0:na-1])
  let(
    a = idx_out(0, j),
    b = idx_out(0, (j+1) % na),
    c = idx_in(0, (j+1) % na),
    d = idx_in(0, j)
  )
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces_top = [
  for (j=[0:na-1])
  let(
    a = idx_out(nz, j),
    b = idx_in(nz,  j),
    c = idx_in(nz,  (j+1) % na),
    d = idx_out(nz, (j+1) % na)
  )
  for (tri = [[a,b,c], [a,c,d]]) tri
];

faces = concat(faces_outer, faces_inner, faces_bottom, faces_top);

///////////////////////////
// Shell as a single polyhedron
///////////////////////////
module shell_poly() {
    polyhedron(points=points, faces=faces, convexity=10);
}

///////////////////////////
// Spider mount (seat + ring + struts) — with solid overlaps
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    // Ends are axisymmetric; use belly baseline for a clean, circular tie
    end_t     = at_top ? 1 : 0;
    r_in_end  = R_belly(end_t) - wall_thickness;      // inner radius of shell at that end

    // Ring outer radius expanded to ensure overlap; inner radius set by ring_width
    r_ring_o  = r_in_end + tie_overlap_r;
    r_ring_i  = max(mount_seat_od/2 + 0.2, r_ring_o - ring_width);

    // Spokes overlap: extend into ring and up into skirt (optional)
    spoke_h   = mount_seat_th + (spoke_to_skirt ? tie_skirt_h : 0);
    span_len  = max(0.1, (r_ring_i + spoke_overlap_r) - mount_seat_od/2);

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2, center=false);

            // Tie ring at seat level (positively overlapping the shell)
            difference() {
                cylinder(h=mount_seat_th, r=r_ring_o, center=false);
                cylinder(h=mount_seat_th + 0.1, r=r_ring_i, center=false);
            }

            // Inner skirt above the seat
            translate([0,0,mount_seat_th])
                difference() {
                    cylinder(h=tie_skirt_h, r=r_ring_o, center=false);
                    cylinder(h=tie_skirt_h + 0.1, r=r_ring_i, center=false);
                }

            // Struts: extend slightly below seat (spoke_z_bite) and into ring/skirt
            for (s=[0:spoke_count-1]) {
                rotate([0,0, s*360/spoke_count])
                    translate([mount_seat_od/2, -spoke_width/2, -spoke_z_bite])
                        cube([span_len, spoke_width, spoke_h + spoke_z_bite], center=false);
            }
        }
        // Through-hole for E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + tie_skirt_h + 0.6,
                 r=(e14_hole_diameter + seat_clearance)/2, center=false);
    }
}

///////////////////////////
// Assembly
///////////////////////////
module lampshade() {
    shell_poly();

    if (!mount_at_top) {
        // Seat at bottom (z=0)
        spider_mount_at_z(0, at_top=false);
    } else {
        // Seat at top (just below the top plane)
        spider_mount_at_z(H - mount_seat_th - tie_skirt_h, at_top=true);
    }
}

// Diagnostics
echo(str("Vertices: ", len(points), "  Faces: ", len(faces)));
echo(str("Axis mid outer radius (after auto_clearance) = ", axis_mid_r));
echo(str("Required outer mid radius for bulb+clearance = ", required_rad_outer));
echo(str("Top outer radius used = ", Ro2));
echo(str("Top inner min required = ", top_inner_min_diam/2));
assert(axis_mid_r >= required_rad_outer,
  "Axis mid too small for Ø80 bulb + clearance. Increase axis_mid_diameter or enable auto_clearance.");

lampshade();
