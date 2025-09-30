// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// ---------------------- Controls ----------------------
$fa = 1;
$fs = 0.2;

h = 80;         // samples along the profile (0..h)
scale_y = 0.8;  // vertical scale (mm per sample)
wall = 1.0;     // <<-- wall thickness (mm)
a_max = 193;    // degrees of sine sweep (OpenSCAD uses degrees)

// Base radius shape: narrow bottom, wider towards the top (adjust as you like)
function r_out(x) = 20 + 10 * sin(x * a_max / h); // x in [0..h]

// Inner radius (ensure it doesn't go negative)
function r_in(x)  = max(0.1, r_out(x) - wall);

// Build point lists
outer_pts = [ for (x = [0:h])      [ r_out(x), x * scale_y ] ];
inner_pts = [ for (x = [h:-1:0])   [ r_in(x),  x * scale_y ] ]; // reversed

// 2D closed cross-section for rotate_extrude (outer up, inner down)
module lampshade_profile()
    polygon(points = concat(outer_pts, inner_pts));

// Revolve around the Z-axis. X = radius, Y = height (becomes Z after rotation).
// rotate_extrude()
    lampshade_profile();
