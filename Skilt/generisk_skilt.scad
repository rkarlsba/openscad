include <ymse.scad>

$fn = 100;
skilt_dim = [148,96,3];
skilt_r = 3;
bilde = "/Users/roysk/Nextcloud/Inkscape/Liv/Lego-A6-1.0.0.svg";
//tekst = "Sara Ragbakk";
//bilde = undef;
tekst = undef;
debug = true;

module decho(s=undef) {
    if (debug) {
        s = s == undef ? "someone should RTFM" : s;
        echo(str("DEBUG: ", s));
    }
}

module skilt(dim, r=3, base=1.5, border=1.5, bilde=bilde, tekst=tekst) {
    difference() {
        roundedcube(dim, r);
        translate([border,border,base]) {
            roundedcube([dim[0]-border*2, dim[1]-border*2, dim[2]], r);
        }
    }
    translate([0, 0, base]) {
        if (bilde) {
            if (debug) {
                echo(str("Tegner ", bilde));
            }
            import(bilde);
        } else if (tekst) {
            echo(str("ADVARSEL: Tekst krever masse mikk og det er nok bedre å gå via ei svg-fil eksportert fra Inkscape eller noe.\n\nSkriver ", tekst));        
            text(tekst);
        } else {
            assert(bilde == undef && tekst == undef, 
                str("Kan ikke lage skilt med både grafikk og tekst (ennå). Bilde = ", 
                bilde, ", tekst = ", tekst));
            assert(bilde != undef && tekst != undef,
                str("Gidder ikke lage tomt skilt (ennå?). Bilde = ", 
                bilde, ", tekst = ", tekst));
        }
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

// module skilt(dim, r=3, base=1.5, border=1.5, bilde=bilde, tekst=tekst);
skilt(dim=skilt_dim, r=skilt_r, base=1.5, border=0);
/*
translate([0, -30, 0]) {
    gammeltskilt();
}
*/