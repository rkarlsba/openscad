// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
$fn = 512;

// Parameters
filename = "body1.obj"; // Change to your STL file name
nx = 4;  // number of splits in X
ny = 2;  // number of splits in Y
nz = 2;  // number of splits in Z

// These index variables choose which part to render (0-based indices)
ix = 0;
iy = 0;
iz = 0;

// Load the model
// model = import(filename);
import(filename);

// Get bounding box of the model
// OpenSCAD does not provide bounding box function by default, 
// so you need to measure or estimate the bounds manually.
// Here we assume you know the bounding box extents:
minX = 0; maxX = 235; // replace with your model's bounds
minY = 0; maxY = 235;
minZ = 0; maxZ = 235;

// Calculate size of each chunk
dx = (maxX - minX) / nx;
dy = (maxY - minY) / ny;
dz = (maxZ - minZ) / nz;

// Cutting cube position for this part
x1 = minX + ix * dx;
y1 = minY + iy * dy;
z1 = minZ + iz * dz;

// Cutting cube size
cube_size = [dx, dy, dz];

intersection() {
    import(filename);
    translate([x1, y1, z1])
        cube(cube_size, center=false);
}

