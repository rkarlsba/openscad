/*
 * Alle mål i millimeter - x, y angir diskens størrelse for henholdsvis
 * bredde og tykkelse med litt slakk. z angir hvor høye lommene skal være.
 *
 * Disktype kan være
 *
 *   HDD-3.5        Alias av HDD-3.5-36
 *   HDD-3.5-20     Eldre, tynnere smådisker
 *   HDD-3.5-26     Vanlig for større disker)
 *   HDD-2.5        Alias for HDD-2.5-7
 *   HDD-2.5-5
 *   HDD-2.5-7      Ofte det vanligste for SSD
 *   HDD-2.5-9.5
 *   HDD-2.5-12.5
 *   HDD-2.5-15
 *   HDD-2.5-19
 *
 * Kun HDD-2.4 og HDD-3.5 er implenentert så langt
 */

tykkelse = 2;

disktype = "HDD-2.5";

boksdim = disktype == "HDD-3.5" ? [105,26,40] : (
          disktype == "HDD-2.5" ? [72,9,25] : []);
//x=105; y=26; z=40;

// internt;
ty=tykkelse;

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

storboks(6);