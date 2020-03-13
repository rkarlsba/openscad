// oppvaskmaskinskilt, bakgrunn
//fn=$preview?16:256;
fn=8;
$fn=fn;

text="DISHES";
font="Copperplate:style=Bold";

text_clean="CLEAN";
text_dirty="DIRTY";

translate([10,13,3]) {
    linear_extrude(1) {
        text(text_clean, font=font, size=11, $fn=fn);
    }
}
