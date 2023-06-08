// oppvaskmaskinskilt_globals.scad
//$fn=$preview?16:256;
$fn=$preview?16:64;

// font
font="Copperplate:style=Bold";

// Languages
text_front = lang == "no" ? "OPPVASK" : "DISHES";
text_clean = lang == "no" ? "REINT" : "CLEAN";
text_dirty = lang == "no" ? "GRISETE" : "DIRTY";

// Scaling of text
text_scale_front = lang == "no" ? [.82, 1, 1]   : [1, 1, 1];
text_scale_clean = lang == "no" ? [1.1, 1, 1] : [1, 1, 1];
text_scale_dirty = lang == "no" ? [.93,   1, 1] : [1, 1, 1];

// Text location
text_location_front = [5,15,6];
text_location_clean = [10,13,3];
text_location_dirty = [95,13,3];