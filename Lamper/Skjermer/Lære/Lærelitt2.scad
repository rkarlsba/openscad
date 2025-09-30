// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

$fa = 1;
$fs = 0.2;

// Kurve med smal bunn, bred midt, og smalere topp
function f(x) = 10 + 20 * sin(x * 150 / 80); // x fra 0 til 80 → sin går fra 0 til 180°

// rotate_extrude()
    polygon(points=[
        for (x = [0:80])
            [f(x), x * 0.8]
    ]);
