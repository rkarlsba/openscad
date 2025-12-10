include <ymse.scad>

$fn = 100;

height = 50;
size = [90,80];
radius = 20;

linear_extrude(height) {
    roundedsquare(size, radius);
}
