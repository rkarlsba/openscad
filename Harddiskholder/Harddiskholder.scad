/*
 * Harddiskholder.scad
 *
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 * Licensed under AGPL v3. See https://www.gnu.org/licenses/agpl-3.0.html
 * for details
 * 
 * disktype choices
 *
 *   HDD-3.5        Alias av HDD-3.5-34
 *   HDD-3.5-20     Thinner drives, not much used these days (2022)
 *   HDD-3.5-24     Usual 3,5" size
 *   HDD-2.5        Alias for HDD-2.5-7
 *   HDD-2.5-5      Really thin ones
 *   HDD-2.5-7      Probably the most common
 *   HDD-2.5-9.5    Older drives/SSDs
 *   HDD-2.5-12.5   Older or larger
 *   HDD-2.5-15     This and the next one are usually only used for large SAS drives
 *   HDD-2.5-19
 *
 * Set disktype according to what you want.
 * Set wall_thickness accordingly. My testing shows that 1.5mm should be fine with
 * 2.5" drives, while you might want 2mm for 3.5" drives.abs
 * Call storboks() with the number of drives you need space for. It will only grow
 * in the Y axis.
 *
 * PS: Original code was and some varabiels still are in Norwagian, but it should be
 * understandable. Didn't bother to translate it all.
 *
 */

// Settings
wall_thickness = 1.5;
disktype = "HDD-3.5";
y_slack = 2;

// Internal vars
boksdim = disktype == "HDD-3.5" ? [105,24+y_slack,40] : 
          disktype == "HDD-3.5-20" ? [105,20+y_slack,40] : 
          disktype == "HDD-3.5-23" ? [105,23+y_slack,40] : 
          disktype == "HDD-2.5-5" ? [72,5+y_slack,25] : 
          disktype == "HDD-2.5" ? [72,7+y_slack,25] : 
          disktype == "HDD-2.5-7" ? [72,7+y_slack,25] : 
          disktype == "HDD-2.5-9.5" ? [72,9.5+y_slack,25] : 
          disktype == "HDD-2.5-12.5" ? [72,12.5+y_slack,25] : 
          disktype == "HDD-2.5-15" ? [72,15+y_slack,25] : 
          disktype == "HDD-2.5-19" ? [72,19+y_slack,25] : 
          [];
ty=wall_thickness;

// Modules
module boks() {
    difference() {
        cube([boksdim[0]+ty*2,boksdim[1]+ty*2,boksdim[2]]);

        translate([ty,ty,ty]) {
            cube(boksdim);
        }
    }
}

module storboks(antall) {
    for (t = [0:antall-1]) {
        translate([0, boksdim[1]*t+t*2, 0]) {
            boks();
        }
    }
}

// Main code

// Bottom part
storboks(6);

// Top part (if you need one)
//scale([1,1,.4]) {
//    storboks(6);
//}
