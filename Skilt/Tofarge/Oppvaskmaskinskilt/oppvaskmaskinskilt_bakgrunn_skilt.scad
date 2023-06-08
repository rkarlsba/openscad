// oppvaskmaskinskilt, bakgrunn
lang="no";

include </Users/roy/src/git/rkarlsba/openscad/Tofarge/Oppvaskmaskinskilt/oppvaskmaskinskilt_globals.scad>

difference() {
    import("oppvaskmaskinskilt_bakgrunn.stl");
    scale(text_scale_clean) {
        translate(text_location_clean) {
            linear_extrude(1) {
                text(text_clean, font=font, size=11);
            }
        }
    }
    scale(text_scale_dirty) {
        translate(text_location_dirty) {
            linear_extrude(1) {
                text(text_dirty, font=font, size=11);
            }
        }
    }
}