w=66;
d=19.5;
h1=3.2;
h2=3.9;

dingspoints = [
    [0,0,0], [w,0,0], [w,d,0], [0,d,0],
    [0,0,h1], [w,0,h1], [w,d,h2], [0,d,h2]
];

dingsfaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]   // left
];

difference() {
    // Stor firkant
    polyhedron( dingspoints, dingsfaces );
    // Høl
    translate([28.75,1.8,0])
        cube([8.3,4.7,3.9]);
}

// Lås
translate([19,19.5,0]) {
    cube([27,21,3.9]);
    translate([0,14,3.9]) {
        cube([27,7,6]);
    }
}