// Vim modeline {{{
//
// vim:ts=4:sw=4:sts=4:et:ai:si:tw=100:fdm=marker
//
// }}}
// Resolution {{{

$fn = 0;   // fixed number of fragments
$fs = 0.5; // minimum fragment size (linear)
$fa = 3;   // minimum fragment angle (angular)

// }}}
// Globals {{{

kuben = [52,10,8];
mellomrom = 8;
skruelengde = 6;

// }}}
// Functions {{{

function fmt1(x) =
    let(
        i = floor(x),
        d = abs(round((x - i) * 10))
    )
    str(i, ".", d);

// }}}
// Main {{{

render(convexity=4) {
    difference() {
        cube(kuben);
        for (x = [1:kuben.x/10+1]) {
            translate([-2+mellomrom*x, kuben.y/3, kuben.z-skruelengde]) {
                translate([-1.8,2,skruelengde-1]) linear_extrude(skruelengde) text(str(fmt1(1.5+x/10)), size=2);
                cylinder(d=1.5+x/10, h=skruelengde);
            }
        }
    }
}

// }}}
