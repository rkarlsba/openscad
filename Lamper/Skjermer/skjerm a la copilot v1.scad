//
// Spiral Belly Lampshade (polyhedron) for E14 — hollow shell (no vase mode)
// - Axisymmetric belly for Ø80 bulb clearance
// - Single‑lobe helical bulge with tunable height envelope & end caps
// - Spider seat with *annular-ring spokes* (overlap both seat and tie ring; no protrusion)
// - Pattern switch: "solid" (default), "slots", or "ribbons" (as in the screenshot)
//
// Author: M365 Copilot (for Roy)
// Units: millimeters
//

///////////////////////////
// Quick preview & debug
///////////////////////////
FAST_PREVIEW     = true;     // true = faster; false = smoother
SHOW_SHELL_ONLY  = false;    // render shell only (debug)
SHOW_SPIDER_ONLY = false;    // render spider only (debug)

///////////////////////////
// Pattern mode
///////////////////////////
// "solid"   = closed shell (helical bulge only)
// "slots"   = helical slots through the shell
// "ribbons" = helical ribbons (open bands), similar to the image you sent
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

// Spider geometry — *annular-ring spokes* (robust, never protrude outside)
ring_width           = 8.0;   // tie-in ring width (radial thickness)
tie_overlap_r        = 1.2;   // mm: tie ring outer intrudes into shell inner wall by this
tie_skirt_h          = 10.0;  // mm: inner skirt height overlapping shell interior

spoke_count          = 4;     // number of spokes
spoke_arc_fraction   = 0.35;  // fraction of each 360/N segment kept as *solid* (0.2..0.5 works well)
spoke_seat_overlap   = 0.6;   // mm: spokes extend this much *inside* seat OD to overlap the seat
spoke_ring_overlap   = 0.4;   // mm: spokes extend this much *outside* tie ring inner radius to overlap the ring
spoke_z_bite         = 0.6;   // mm: spokes start below seat to avoid coplanar
spoke_to_skirt       = true;  // run spokes tall enough to intersect the skirt

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
EPS = 0.05; // tiny fudge for boolean robustness
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
H  = height_mm;
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
// Helical cutters (for "slots" and "ribbons")
///////////////////////////
Rcut = max(max_mid_r, Ro0, Ro2) + 6; // radial reach of cutters
twist_total = bulge_turns * 360 * (left_handed ? -1 : 1);

module helical_cutters() {
    h_cut = max(0, H - 2*slot_z_margin);
    if (h_cut > 0) {
        for (k=[0:slot_count-1]) {
            rotate([0,0, k*360/slot_count]) {
                translate([0,0, slot_z_margin])
                    linear_extrude(height=h_cut, twist=twist_total, slices=nz, convexity=10)
                        translate([0, -slot_width/2])
                            square([Rcut, slot_width], center=false);
            }
        }
    }
}

module shell_poly() {
    if (pattern == "solid") {
        shell_poly_raw();
    } else if (pattern == "slots" || pattern == "ribbons") {
        // both modes use helical cutters; "ribbons" usually wants fewer, wider cuts
        difference() {
            shell_poly_raw();
            helical_cutters();
        }
    } else {
        // fallback
        shell_poly_raw();
    }
}

///////////////////////////
// Spider mount (seat + tie ring + *annular-ring spokes*)
// Spokes are a ring between r_spoke_i .. r_spoke_o, with windows cut out
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    end_t     = at_top ? 1 : 0;
    r_in_end  = R_belly(end_t) - wall_thickness;  // inner radius of shell at that end

    // Tie ring dimensions (positive overlap into shell interior)
    r_ring_o  = r_in_end + tie_overlap_r;
    r_ring_i  = r_ring_o - ring_width;
    // Ensure at least 1 mm gap from seat to ring inner wall for material
    r_ring_i  = max(mount_seat_od/2 + 1.0, r_ring_i);

    // Spoke ring dimensions: it *overlaps the seat inward* and *overlaps the tie ring outward*
    r_spoke_i = max(0.1, mount_seat_od/2 - spoke_seat_overlap);
    r_spoke_o = max(r_spoke_i + 1.0, r_ring_i + spoke_ring_overlap);

    // Height of spokes: from below seat up into the skirt if enabled
    spoke_h   = mount_seat_th + (spoke_to_skirt ? (tie_skirt_h + EPS) : 0);

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat disc
            cylinder(h=mount_seat_th, r=mount_seat_od/2, center=false);

            // Tie ring (overlaps shell interior)
            difference() {
                cylinder(h=mount_seat_th + EPS, r=r_ring_o, center=false);
                cylinder(h=mount_seat_th + 2*EPS, r=r_ring_i, center=false);
            }

            // Inner skirt above the seat
            translate([0,0,mount_seat_th - EPS])
                difference() {
                    cylinder(h=tie_skirt_h + 2*EPS, r=r_ring_o, center=false);
                    cylinder(h=tie_skirt_h + 3*EPS, r=r_ring_i, center=false);
                }

            // --- Spokes as an annular ring with windows removed ---
            // Start with a solid annular ring (spoke volume)
            translate([0,0,-spoke_z_bite])
                difference() {
                    // Solid ring volume
                    difference() {
                        cylinder(h=spoke_h + spoke_z_bite + EPS, r=r_spoke_o, center=false);
                        cylinder(h=spoke_h + spoke_z_bite + 2*EPS, r=r_spoke_i, center=false);
                    }
                    // Cut windows to leave spoke_count evenly spaced spokes
                    rm = (r_spoke_i + r_spoke_o)/2;
                    seg_len = 2*PI*rm / max(1,spoke_count);
                    // solid fraction per segment -> window width = (1 - solid_fraction) * segment length
                    window_w = seg_len * (1 - clamp01(spoke_arc_fraction));

                    for (s=[0:spoke_count-1]) {
                        rotate([0,0, s*360/spoke_count]) {
                            // place a tangential box at the mid radius to carve the opening
                            translate([rm, 0, 0])  // move to mid radius
                                cube([ (r_spoke_o - r_spoke_i) + 2,  // radial length (overshoot)
                                       window_w,                      // tangential width
                                       spoke_h + spoke_z_bite + 4 ],  // tall cut (overshoot)
                                     center=true);
                        }
                    }
                }
        }
        // Through-hole for E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + tie_skirt_h + spoke_h + 2.0,
                 r=(e14_hole_diameter + seat_clearance)/2, center=false);
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
r_spoke_i_diag    = max(0.1, mount_seat_od/2 - spoke_seat_overlap);
r_spoke_o_diag    = max(r_spoke_i_diag + 1.0, r_ring_i_diag + spoke_ring_overlap);
rm_diag           = (r_spoke_i_diag + r_spoke_o_diag)/2;
seg_len_diag      = 2*PI*rm_diag / max(1,spoke_count);
window_w_diag     = seg_len_diag * (1 - clamp01(spoke_arc_fraction));

echo(str("Spider diag: r_in_end=", r_in_end_diag,
         "  ring_i=", r_ring_i_diag,
         "  ring_o=", r_ring_o_diag,
         "  spoke_i=", r_spoke_i_diag,
         "  spoke_o=", r_spoke_o_diag,
         "  rm=", rm_diag,
         "  window_w=", window_w_diag));

///////////////////////////
// Go
///////////////////////////
lampshade();

