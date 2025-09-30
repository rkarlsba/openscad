use <hull_polyline2d.scad>
use <triangle/tri_ear_clipping.scad> 
use <shape_starburst.scad>
use <experimental/tri_bisectors.scad>

shape = shape_starburst(30, 12, 10);
hull_polyline2d(concat(shape, [shape[0]]), width = 1);

tris = tri_ear_clipping(shape);
for(tri = tris) {
    for(line = tri_bisectors([for(idx = tri) shape[idx]])) {
        hull_polyline2d(line, width = 1);
    }
}