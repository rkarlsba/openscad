// oppvaskmaskinskilt, forgrunn
lang="no";

include </Users/roy/src/git/rkarlsba/openscad/Tofarge/Oppvaskmaskinskilt/oppvaskmaskinskilt_globals.scad>

translate(text_location_front) {
    scale(text_scale_front) {
        linear_extrude(1) {
            text(text_front, font=font, size=12);
        }
    }
}