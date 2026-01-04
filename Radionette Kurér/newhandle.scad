// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

// Trenger jeg denne?
include <ymse.scad>

// Settings
$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// Fuckup
bug = $preview ? .1 : 0;

// Variables
x = 30;
y = 15;
z = 100;
corner_rounding = 5;
hole_r = 1.5;           // Original had 1
hole_depth = 20;        // Original had 15

// For å unngå buggetibug
//  render(convexity=4) {

