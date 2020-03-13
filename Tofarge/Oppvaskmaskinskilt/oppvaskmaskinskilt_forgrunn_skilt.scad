// oppvaskmaskinskilt, forgrunn
fn=$preview?16:256;
$fn=fn;

text="DISHES";
font="Copperplate:style=Bold";

difference() {
    import("oppvaskmaskinskilt_forgrunn.stl");
    translate([5,15,6]) {
        linear_extrude(1) {
            text(text, font=font, size=12, $fn=fn);
        }
    }
}