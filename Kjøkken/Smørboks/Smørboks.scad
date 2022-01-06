use <ymse.scad>

//$fn=$preview ? 8 : 32; // kanskje 256

module boks(
    hoyde=56,
    bredde=127,
    lengde=77,
    hjorneradius=3,
    gloppe=5,
    tykkelse=2,
    tekstdybde=1,
    font="Caligraf Bold PERSONAL USE:style=Regular"
) {
    difference() {
        roundedcube([bredde+gloppe*2,lengde+gloppe*2,hoyde+gloppe], 
                    hjorneradius, $fs=.01);
        translate([tykkelse,tykkelse,tykkelse]) {
            roundedcube([bredde+gloppe*2-tykkelse*2,lengde+gloppe*2-tykkelse*2,hoyde+gloppe-tykkelse],
                        hjorneradius, $fs=.01);
        }
        translate([17,tekstdybde,14]) {
            rotate([90,0,0]) {
                linear_extrude(tekstdybde) {
                    text("Smør", font=font, size=30, spacing=1.2);
                }
            }
        }

        translate([120,lengde+gloppe*2,14]) {
            rotate([90,0,0]) {
                linear_extrude(tekstdybde) {
                    mirror([1, 0, 0]) {
                        text("Smør", font=font, size=30, spacing=1.2);
                    }
                }
            }
        }
    }
}

module lokk(
    hoyde=12,
    bredde=139,
    lengde=89,
    hjorneradius=3,
    gloppe=5,
    tykkelse=2,
    tekstdybde=1,
    font="Caligraf Bold PERSONAL USE:style=Regular"

) {

    difference() {
        roundedcube([bredde+gloppe*2,lengde+gloppe*2,hoyde+gloppe], 
                    hjorneradius, $fs=.01);
        translate([tykkelse,tykkelse,tykkelse]) {
            roundedcube([bredde+gloppe*2-tykkelse*2,lengde+gloppe*2-tykkelse*2,hoyde+gloppe-tykkelse],
                        hjorneradius, $fs=.01);
        }

        translate([17,71,tekstdybde]) {
            rotate([180,0,0]) {
                linear_extrude(tekstdybde) {
//                    mirror([1, 0, 0]) {
                        text("Smør", font=font, size=36, spacing=1.1);
//                    }
                }
            }
        }
    }
}

//boks();
lokk();
translate([150,0,0]) {
//    lokk();
}

