// oppvaskmaskinskilt, bakgrunn
lang="no";

include </Users/roy/src/git/rkarlsba/openscad/Tofarge/Oppvaskmaskinskilt/oppvaskmaskinskilt_globals.scad>

translate(text_location_dirty) {
    scale(text_scale_dirty) {
        linear_extrude(1) {
            text(text_dirty, font=font, size=11);
        }
    }
}
