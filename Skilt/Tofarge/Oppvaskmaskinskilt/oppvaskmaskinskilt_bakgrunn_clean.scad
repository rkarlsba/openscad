// oppvaskmaskinskilt, bakgrunn

lang="no";

include </Users/roy/src/git/rkarlsba/openscad/Tofarge/Oppvaskmaskinskilt/oppvaskmaskinskilt_globals.scad>

translate(text_location_clean) {
    scale(text_scale_clean) {
        linear_extrude(1) {
            text(text_clean, font=font, size=11);
        }
    }
}
