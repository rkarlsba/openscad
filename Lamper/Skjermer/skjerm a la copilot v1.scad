//
// Spiral Belly Lampshade (polyhedron) for E14 — hollow shell (no vase mode),
// axisymmetric belly for bulb clearance + single-lobe helical bulge
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
height_mm          = 180;     // total height
wall_thickness     = 2.4;     // shell thickness

// Ends (narrow), plus belly for bulb clearance
base_diameter      = 60;      // outer at bottom
top_diameter       = 50;      // outer at top
axis_mid_diameter  = 110;     // outer diameter of the axisymmetric belly at mid
axis_width         = 0.33;    // Gaussian width of the belly along Z (0.25..0.45 recommended)

// Helical lobe (the spiralling bulge riding on the belly)
max_mid_diameter   = 180;     // outer diameter at mid *at the lobe crest*
bulge_turns        = 2.0;     // revolutions of the lobe from bottom to top
left_handed        = false;   // true to reverse direction
mid_position       = 0.50;    // where belly/lobe peak along height (0..1)
lobe_width         = 0.33;    // Gaussian width of the lobe along Z
lobe_power         = 2.0;     // 1=soft; 2..3=crisper lobe (cos^power, clamped ≥0)

// E14 mount (measure your hardware)
e14_hole_diameter  = 29.0;    // through-hole for E14 spigot (28–30 mm typical)
seat_clearance     = 0.4;     // adds to hole dia
mount_seat_od      = 44.0;    // seat OD (must exceed nut OD)
mount_seat_th      = 3.0;     // seat thickness
spoke_count        = 4;       // spider struts
spoke_width        = 6.0;     // strut width
ring_width         = 6.0;     // tie-in ring width
mount_at_top       = false;   // false: seat at bottom; true: seat at top (pendant)

// Bulb & clearance (sphere Ø80 mm)
bulb_diameter      = 80.0;
bulb_clearance     = 3.0;     // radial clearance
auto_clearance     = true;    // auto-raise axis_mid_diameter to ensure bulb clearance

// Quality (poly count) — tune these to balance detail vs speed
na                 = FAST_PREVIEW ? 96  : 160;   // angular segments (circumference)
nz                 = FAST_PREVIEW ? 140 : 240;   // vertical rings (height)

// (No need to touch $fn; we control resolution via na/nz)
$fn = 48;

///////////////////////////
// Helpers
///////////////////////////
function clamp01(x) = x < 0 ? 0 : (x > 1 ? 1 : x);
function smoothstep01(t) = let(tt=clamp01(t)) tt*tt*(3 - 2*tt);
function gaussian(t, mu, sigma) = exp(-0.5*pow((t - mu)/sigma, 2));
function sigma_from_width(w) = max(0.05, w);

///////////////////////////
// Derived & checks
///////////////////////////
H = height_mm;
Ro0 = base_diameter/2;
Ro2 = top_diameter/2;
assert(Ro0 > wall_thickness + 1 && Ro2 > wall_thickness + 1,
       "Base/top diameters too small for this wall thickness.");

required_rad_inner = bulb_diameter/2 + bulb_clearance;
required_rad_outer = required_rad_inner + wall_thickness;
axis_mid_r_user    = axis_mid_diameter/2;
axis_mid_r         = auto_clearance ? max(axis_mid_r_user, required_rad_outer) : axis_mid_r_user;
max_mid_r          = max(max_mid_diameter/2, axis_mid_r + 0.01);  // ensure crest > belly

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

// Lobe amplitude along Z so that crest @ mid reaches max_mid_r
function lobe_amp(t) =
    let(A_mid = max_mid_r - axis_mid_r,
        sig   = sigma_from_width(lobe_width))
    A_mid * gaussian(t, mid_position, sig);

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
faces_outer = concat(
    [ for (i=[0:nz-1], j=[0:na-1]) 
        let(a=idx_out(i,j), b=idx_out(i,(j+1)%na), c=idx_out(i+1,(j+1)%na), d=idx_out(i+1,j))
        [ [a,b,c], [a,c,d] ]
    ]
);

faces_inner = concat(
    [ for (i=[0:nz-1], j=[0:na-1])
        // reverse winding vs outer
        let(a=idx_in(i,j), b=idx_in(i+1,j), c=idx_in(i+1,(j+1)%na), d=idx_in(i,(j+1)%na))
        [ [a,b,c], [a,c,d] ]
    ]
);

// Bottom edge faces: connect outer(0,*) to inner(0,*) along thickness
faces_bottom = concat(
    [ for (j=[0:na-1])
        let(a=idx_out(0,j), b=idx_out(0,(j+1)%na), c=idx_in(0,(j+1)%na), d=idx_in(0,j))
        [ [a,b,c], [a,c,d] ]
    ]
);

// Top edge faces: connect outer(nz,*) to inner(nz,*)
faces_top = concat(
    [ for (j=[0:na-1])
        // flip winding so normals point outward
        let(a=idx_out(nz,j), b=idx_in(nz,j), c=idx_in(nz,(j+1)%na), d=idx_out(nz,(j+1)%na))
        [ [a,b,c], [a,c,d] ]
    ]
);

faces = concat(faces_outer, faces_inner, faces_bottom, faces_top);

///////////////////////////
// Shell as a single polyhedron
///////////////////////////
module shell_poly() {
    polyhedron(points=points, faces=faces, convexity=10);
}

///////////////////////////
// Spider mount (seat + ring + struts)
///////////////////////////
module spider_mount_at_z(z_mount, at_top=false) {
    // At ends the lobe amplitude is tiny; use belly baseline
    end_t   = at_top ? 1 : 0;
    r_in_end = R_belly(end_t) - wall_thickness;

    translate([0,0,z_mount]) difference() {
        union() {
            // Seat
            cylinder(h=mount_seat_th, r=mount_seat_od/2);

            // Inner tie ring if space allows
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
        // Through-hole for E14 spigot (+ clearance)
        cylinder(h=mount_seat_th + 0.4, r=(e14_hole_diameter + seat_clearance)/2);
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
        // Seat at top
        spider_mount_at_z(H - mount_seat_th, at_top=true);
    }
}

// Diagnostics
echo(str("Vertices: ", len(points), "  Faces: ", len(faces)));
echo(str("Axis mid outer radius (after auto_clearance) = ", axis_mid_r));
echo(str("Required outer mid radius for bulb+clearance = ", required_rad_outer));
assert(axis_mid_r >= required_rad_outer,
  "Axis mid too small for Ø80 bulb + clearance. Increase axis_mid_diameter or enable auto_clearance.");

lampshade();
