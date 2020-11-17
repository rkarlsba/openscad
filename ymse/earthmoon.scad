$fn=64;

r_earth=6.371;
r_moon=1.737;

translate([r_earth,r_earth,r_earth]) {
    sphere(r=6.371);
}
translate([1.4,1.4,8]) {
    sphere(r=r_moon);
}