// Backgammon-brikke
// Backgammon man size
// Backgammon checker size

use <ymse.scad>

inch=25.4; // 1" is 25.4mm - we're doing things metric from now on
playstyle = "Normal"; // Traveller, Normal or Pro

bgman = 35; // really 1.4", but hell, we're in Europe
bgman_small = 1.25*inch; // Normal play size
bgman_pro = 1.75*inch; // huge, since touch men have huge hands and so on
bgman_thickness = 8.5;

bgman_d =   (playstyle == "Traveller") ? inch :
            (playstyle == "Normal") ? 35 :
            (playstyle == "Pro") ? inch*1.75 :
            false;
        
bgman_th =  (playstyle == "Traveller") ? 7.5 : 
            (playstyle == "Normal") ? 8.5 :
            (playstyle == "Pro") ? 10 :
            false;

assert(bgman_d, str("Failed to assert() man diameter, derived from playstyle '", playstyle, "'"));
assert(bgman_th, str("Failed to assert() man thickness, derived from playstyle '", playstyle, "'"));

module draw_man() {
    roundedcylinder(r=bgman_d/2,h=bgman_th,n=1,$fn=200);
}

/* This one takes a two dimensional array with [x,y]
 * telling how many rows/columns you'd like 
 */
module draw_men(number) {
    assert(false, "Please just use the slicer instead of this bullocks");
}