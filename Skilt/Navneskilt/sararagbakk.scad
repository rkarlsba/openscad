include <ymse.scad>

$fn = 100;
skilt_dim = [102,24,3];
skilt_r = 3;
tekst = "Sara Ragbakk";
bilde = "/Users/roysk/Nextcloud/Inkscape/Liv/Lego.svg";import();
tegne_bilde = True;
tegne_tekst = False;


module skilt(dim, tekst, r=3, base=1.5, border=1.5, bilde=undef, tekst=undef) {
    difference() {
        roundedcube(dim, r);
        translate([border,border,base]) {
            roundedcube([dim[0]-border*2, dim[1]-border*2, dim[2]], r);
        }
    }
    if (bilde || tekst) {
        ;
    } else {
        
    }
}

module gammeltskilt() {
    translate([0,0,2]) {
        difference() {
            cube([102,24,2]);
            translate([2,2,0]) {
                cube([98,20,2]);
            }
        }
    }

    translate([8,8,2]) {
        linear_extrude(2)  {
            text(tekst);
        }
    }
}

skilt(skilt_dim, skilt_r);
/*
translate([0, -30, 0]) {
    gammeltskilt();
}
*/