/*
 * vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
 *
 * Sáhkku-brett
 * 15 x 3 felter fordelt som 15 vertikale streker, 60mm høye
 * med 10mm mellom hver strek.
 */
 
pi = 3.14159265;
linjelengde = 60;
linjebredde = 1.3;
mellomrom_h = 19;
mellomrom_v = 9;
linjeantall = 15;
rader = 3;
krysstrek = 27;
kryssvinkel = 56;

module linje(lengde, bredde=linjebredde) {
    translate([-bredde/2,0]) {
        square([bredde, lengde]);
    }
}

module kryss(strek = krysstrek, vinkel = kryssvinkel) {
    rotate([0,0,vinkel]) {
        linje(strek);
    }
    translate([-strek*sin(vinkel),0]) {
        rotate([0,0,-vinkel]) {
            linje(strek);
        }
    }
}
    
 
module sahkkubrett(
    linjelengde = linjelengde, 
    mellomrom_h = mellomrom_h, 
    mellomrom_v = mellomrom_v, 
    linjeantall = linjeantall, 
    rader = rader) 
{
    for (y = [0:(linjelengde+mellomrom_v):(linjelengde+mellomrom_v)*rader-1]) {
        for (x = [0:mellomrom_h:(linjeantall-1)*mellomrom_h]) {
            translate([x,y]) {
                linje(linjelengde);
                if (y == (linjelengde+mellomrom_v))  {
                    if (x == mellomrom_h * 3 || x == mellomrom_h * 11) 
                    {
                        translate([krysstrek-15.8,linjelengde/2-7.54]) {
                            kryss();
                            echo(str("x = ", x, " and y = ", y));
                        }
                    } else if (x == mellomrom_h * 7) 
                    {
                        translate([krysstrek-15.8,linjelengde/2-7.54]) {
                            kryss();
                            echo(str("x = ", x, " and y = ", y));
                        }
                    }
                }
            }
        }
    }
}

translate([0,0]) {
    sahkkubrett();
}

//translate([30,30]) kryss();