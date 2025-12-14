/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */
include <ymse.scad>

$fn = $preview ? 64 : 512;

kuledia = 200;

module halvkule(dia) {
    difference() {
        sphere(d=dia);
        translate([-dia/2,-dia/2,-dia])
        {
            cube([dia,dia,dia]);
        }
    }
}

halvkule(kuledia);
