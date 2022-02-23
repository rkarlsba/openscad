// Custom battery tray - bigclivedotcom
// Slightly fixed by roy@karlsbakk.net
$fn = $preview ? 30 : 100; // $fn = 30 if preview, 100 if render
preview_fix = $preview ? 0.1 : 0; // preview shows shadows with zero thin layers, so stop that

//You can adjust these variables.
width=4;        // Number of horizontal cups
height=5;       // Number of vertical cups
depth=10;       // Internal depth of cups
diameter=15;    // Diameter of cylinder AA=15 AAA=11
thickness=1;    // Thickness of wall
base=1;         // Thickness of cup bases

// Don't adjust stuff below here unless you know what you're doing
columns=width-1;
rows=height-1;
wall=thickness*2;
dia=diameter+thickness;
cup=depth+base;

// A single cell holder
module cellholder() {
    difference() {
        cylinder(h=cup, d=diameter+wall);
        translate([0,0,base]) {
            cylinder(h=cup-base+preview_fix,d=diameter);
        }
    }
}

// Iterate over columns and rows given above or as arguments and draw the final thing
module lotsofcells(columns=columns, rows=rows) {
    for (x=[0:columns]) {
        for (y=[0:rows]){ 
            translate([x*dia, y*dia, 0]) {
                cellholder();
            }
        }
    }
}

// Bigclive's original code - stuffed into a module for reference
module bigclivesoriginal() {
    difference() {
        union() {
            //main body
            for (x=[0:columns]) {
                for (y=[0:rows]){ 
                    translate([x*dia,y*dia,0])  
                    cylinder(h=cup,d=diameter+wall);
                }
            }
        }
        //hollow cores
        for (x=[0:columns]){
            for (y=[0:rows]){ 
                translate([x*dia,y*dia,base])  
                cylinder(h=cup,d=diameter);
            }
        }
    }
}

lotsofcells(2,3);
//bigclivesoriginal();