use <qr.scad>
use <ymse.scad>

$fn = 100;
skilt_dim = [148,96,3];
skilt_r = 3;
// bilde = "/Users/roysk/Nextcloud/Inkscape/Liv/Lego-A6-1.0.0.svg";
// tekst = "Sara Ragbakk";
debug = true;
bilde = undef;

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

//skilt(dim=skilt_dim, r=skilt_r, base=1.5, border=0);
skilt(dim=skilt_dim, r=skilt_r, base=1.5, border=0, tekst="Max pages: 10");