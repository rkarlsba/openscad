/*
 * Hull: 4,4mm
 * Avstand, ytterkant til ytterkant: 134mm 
 * Avstand, sentrum til sentrum: 134-4,4=129,6mm
 * Dybde: 16,2mm
 */


hole_d = 4.4;           // In door
screw_d = 4;            // M4
holes_distance=19.6;    // Between the two
screw_length=16.2;      // Through door
taps=6.5;               // Into handle
total_length=screw_length+taps;

/*
use <agentscad/mxf-screw.scad>
use <agentscad/mxf-thread.scad>

$fn=128;
// cylinder(d=screw_d,h=screw_length);
// translate([0,0,screw_length])
mxfBoltHexagonalThreaded( MF4(tl=taps) );

/ 

// module hex_bolt (lenght, thread_d, head_h, head_d, tolerance, quality, thread, pitch) {

// hex_bolt (3/8, 2/8, 1/8, 3/8, 1/128, 32, "imperial", 28);
hex_bolt(lenght=10);
*/