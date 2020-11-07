// Hjullapper 
$fn = $preview ? 8 : 256;

tykkelse=2;
ventil_r=4.25;
bredde=25;
knekk_lengde=40;
full_lengde=knekk_lengde+20;
fontface="Octin Prison:style=Regular";

module tag(tagtext, height) {
    linear_extrude(height) {
        difference() {
            hull() { 
                translate([ventil_r,ventil_r]) circle(r=ventil_r);
                translate([ventil_r,bredde-ventil_r]) circle(r=ventil_r);
                translate([knekk_lengde-ventil_r,ventil_r/2]) circle(r=ventil_r/2);
                translate([knekk_lengde-ventil_r,bredde-ventil_r/2]) circle(r=ventil_r/2);
                translate([full_lengde-ventil_r,bredde/2+ventil_r/2]) circle(r=ventil_r/sqrt(2));
                translate([full_lengde-ventil_r,bredde/2-ventil_r/2]) circle(r=ventil_r/sqrt(2));
            }
            translate([full_lengde-ventil_r*2,bredde/2]) circle(r=ventil_r);
            translate([ventil_r,ventil_r]) text(tagtext,size=17,font=fontface, spacing=1.2);
        }
    }
}

tag("HF", height=tykkelse);
/*tag("HB", height=tykkelse);
tag("VF", height=tykkelse);
tag("VB", height=tykkelse);
*/