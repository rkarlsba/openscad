//
// Spiral Belly Lampshade (polyhedron) for E14 — hollow shell (no vase mode),
// axisymmetric belly for bulb clearance + single-lobe helical bulge (spirals),
// robust spider mount with overlap (manifold), top opening sized for hands.
//
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview toggle
///////////////////////////
FAST_PREVIEW = true;   // true = faster; false = best quality

///////////////////////////
// User Parameters
///////////////////////////

// Height & wall
height_mm            = 190;     // total height
wall_thickness       = 2.4;     // shell thickness

// Ends (narrow) + belly (clearance)
base_diameter        = 50;      // outer at bottom
top_diameter_user    = 90;     // preferred outer at top (will be raised if top opening min is larger)
axis_mid_diameter    = 140;     // outer diameter of the axisymmetric belly at mid (no spiral)
axis_width           = 0.35;    // Gaussian width of the belly along Z (0.25..0.45 good)

// Helical lobe (the spiralling bulge riding on the belly)
max_mid_diameter     = 200;     // outer diameter at mid *at the lobe crest*
bulge_turns          = 4.2;     // revolutions of the lobe from bottom to top
left_handed          = false;   // true to reverse direction
mid_position         = 0.50;    // where belly/lobe peak along height (0..1)
lobe_width           = 0.33;    // Gaussian width of the lobe along Z
lobe_power           = 2.0;     // 1=soft; 2..3=crisper lobe (cos^power, clamped ≥0)

// E14 mount (measure your hardware)
e14_hole_diameter    = 28.5;    // through-hole for E14 spigot (28–30 mm typical)
seat_clearance       = 0.4;     // adds to hole dia
mount_seat_od        = 44.0;    // seat OD (must exceed nut OD)
mount_seat_th        = 3.0;     // seat thickness
spoke_count          = 4;       // spider struts
spoke_width          = 6.0;     // strut width
ring_width           = 6.0;     // tie-in ring width (radial)
mount_at_top         = false;   // false: seat at bottom; true: seat at top (pendant)

// Robust union with shell (avoid holes / coplanar)
// Positive overlap (radial) where tie ring meets inner wall, and a short inner skirt (axial)
tie_overlap_r        = 0.3;     // mm: expand tie ring outer radius by this to bite into shell
tie_skirt_h          = 4.0;     // mm: height of a short inner skirt overlapping the shell interior

// Bulb & clearance (sphere Ø80 mm)
bulb_diameter        = 80.0;
bulb_clearance       = 3.0;     // radial clearance
auto_clearance       = true;    // auto-raise belly to ensure bulb clearance

// Top opening: ensure hands fit a Ø60 bulb comfortably
top_inner_min_diam   = 80.0;    // required top INNER diameter (≥ bulb + fingers)

// Quality (poly count)
na                   = FAST_PREVIEW ? 96  : 160;   // angular segments
nz                   = FAST_PREVIEW ? 140 : 240;   // vertical rings

$fn = 48; // not used for mesh, but keep sane for cylinders

///////////////////////////
// Guards
///////////////////////////
assert(na >= 3, "na (angular segments) must be ≥ 3");
assert(nz >= 2, "nz (vertical rings) must be ≥ 2");

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

// End taper window to kill lobe at the very ends (avoid micro-wobbles / coplanars)
function end_window(t) =
    let(s = smoothstep01(t) * smoothstep01(1 - t)) pow(s, 1.0);  // power 1 is fine; raise for steeper kill

///////////////////////////
// Derived & checks
///////////////////////////
H = height_mm;
Ro0 = base_diameter/2;

// Enforce a MINIMUM top inner diameter by adjusting top outer if necessary
top_outer_needed = top_inner_min_diam/2 + wall_thickness;
Ro2_user         = top_diameter_user/2;
Ro2              = max(Ro2_user, top_outer_needed);

assert(Ro0 > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "Base/top diameters too small for this wall thickness.");

required_rad_inner = bulb_diameter/2 + bulb_clearance;
required_rad_outer = required_rad_inner + wall_thickness;

axis_mid_r_user    = axis_mid_diameter/2;
axis_mid_r         = auto_clearance ? max(axis_mid_r_user, required_rad_outer) : axis_mid_r_user;
max_mid_r          = max(max_mid_diameter/2, axis_mid_r + 0.01); // ensure crest > belly

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

// Lobe amplitude along Z so that crest @ mid reaches max_mid_r;
// multiply by end_window(t) to force exact zero at both ends.
function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r,
        sig   = sigma_from_width(lobe_width))
    end_window(t) * (A_mid * gaussian(t, mid_position, sig));

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
// Spider mount (seat + ring + struts) with overlap & inner skirt
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    // Ends are axisymmetric now; use belly baseline for a clean, circular tie
    end_t     = at_top ? 1 : 0;
    r_in_end  = R_belly(end_t) - wall_thickness;      // inner radius of shell at that end

    // Ring outer radius slightly expanded to ensure overlap (no coplanar)
    r_ring_o  = r_in_end + tie_overlap_r;
    r_ring_i  = max(mount_seat_od/2 + 0.2, r_ring_o - ring_width);

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2);

            // Tie ring (flush with seat) + short inner skirt to grab shell interior up the wall
            // Ring base at seat level:
            difference() {
                cylinder(h=mount_seat_th, r=r_ring_o);
                cylinder(h=mount_seat_th + 0.1, r=r_ring_i);
            }
            // Inner skirt (above the seat) for robust overlap into shell interior
            translate([0,0,mount_seat_th])
                difference() {
                    cylinder(h=tie_skirt_h, r=r_ring_o);
                    cylinder(h=tie_skirt_h + 0.1, r=r_ring_i);
                }

            // Struts from seat to ring
            span_len = max(0.1, r_ring_i - mount_seat_od/2);
            for (s=[0:spoke_count-1]) {
                rotate([0,0, s*360/spoke_count])
                    translate([mount_seat_od/2, -spoke_width/2, 0])
                        cube([span_len, spoke_width, mount_seat_th], center=false);
            }
        }
        // Through-hole for E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + tie_skirt_h + 0.4, r=(e14_hole_diameter + seat_clearance)/2);
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
        // Seat at top (z=H - seat_th)
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
