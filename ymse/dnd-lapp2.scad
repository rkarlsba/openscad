use <ymse.scad>;

hoyde=150;
bredde=90;
tykkelse=1.5;
avrunding=2;
runding=30;
rammebredde=2;
rammehoyde=1;
fontsize=15;
fontface="Marker Felt:style=Thin";
teksthoyde=tykkelse;
finger="/Users/roy/Nextcloud/Dokumenter/Bitraf/3D-greier/Middle_Finger.dxf";

use_finger = true;

// lapp
difference() {
    linear_extrude(tykkelse) {
        roundedsquare([bredde, hoyde], avrunding);
    }
    if (use_finger) {
        translate([18,hoyde-18,0]) {
            rotate([0,0,180]) {
                linear_extrude(tykkelse) {
                    import(finger);
                }
            }
        }
    } else {
        translate([bredde/2,hoyde-bredde/2,0]) {
            cylinder(r=runding, h=tykkelse);
        }
    }
}

// ramme
translate([0,0,tykkelse]) {
    difference() {
        linear_extrude(rammehoyde) {
            roundedsquare([bredde, hoyde], avrunding);
        }
        translate([rammebredde/2, rammebredde/2]) {
            linear_extrude(rammehoyde) {
                roundedsquare([bredde-rammebredde, hoyde-rammebredde], avrunding);
            }
        }
    }
    if (use_finger) {
    } else {
        translate([bredde/2,hoyde-bredde/2,0]) {
            difference() {
                cylinder(r=runding+rammebredde, h=tykkelse);
                cylinder(r=runding, h=tykkelse);
            }
        }
    }
}

// tekst
translate([10,rammebredde+40,tykkelse]) {
    linear_extrude(teksthoyde) {
        text("Do not", size=fontsize, font=fontface);
    }
}
translate([10,rammebredde+15,tykkelse]) {
    linear_extrude(teksthoyde) {
        text("disturb", size=fontsize, font=fontface);
    }
}
translate([70,rammebredde+10,tykkelse]) {
    linear_extrude(teksthoyde) {
        text("!", size=fontsize*3, font=fontface);
    }
}
