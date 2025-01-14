/*
 * vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
 *
 * Sáhkku-brett
 * 15 x 3 felter fordelt som 15 vertikale streker, 60mm høye
 * med 10mm mellom hver strek.
 */

notasjon = true;
pi = 3.14159265;
linjelengde = 60;
linjebredde = .3;
mellomrom_h = 19;
mellomrom_v = 9;
linjeantall = 15;
rader = 3;
krysstrek = 27;
kryssvinkel = 45;
//font = "Big Caslon:style=Medium";
//font = "Baskerville:style=Bold";
// font = "Baskerville:style=SemiBold";
font = "Baskerville:style=Regular";

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
    
module boks(strek = krysstrek/sqrt(2), vinkel = kryssvinkel) {
    rotate([0,0,45]) {
        linje(strek+linjebredde/2);
        translate([strek,-linjebredde/2]) {
            linje(strek+linjebredde);
        }
        translate([strek-linjebredde/2,0]) {
            rotate([0,0,90]) {
                linje(strek);
                translate([strek,0]) {
                    linje(strek);
                }
            }
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
//            echo(str("x is ", x, " and y is ", y, " and linjelengde+mellomrom_v)*rader-1 is ", (linjelengde+mellomrom_v)*rader-1));
            translate([x,y]) {
                linje(linjelengde);
                if (y == (linjelengde+mellomrom_v))  {
                    if (x == mellomrom_h * 3 || x == mellomrom_h * 11) {
                        translate([krysstrek*.354,linjelengde/2-8.54]) {
                            kryss();
                        }
                    } else if (x == mellomrom_h * 7) {
                        translate([krysstrek-27,linjelengde/2-13.5]) {
                            boks();
                        }
                    }
                } else if (notasjon) {
                    // abcdefghijklmno
                    if (y == 0) {
                        translate([0,-20]) {
                            text(chr(65+x/mellomrom_h), 
                                font=font,
                                halign="center",
                                size = 9);
                            //echo(str("[1] and out with a chr(65+x/mellomrom_h), that is, ", chr(65+x/mellomrom_h)));
                        }
                    // onmlkjihgfedcba
                    } else if (y == 2*(linjelengde+mellomrom_v)) {
                        translate([0,linjelengde + 20]) {
                            rotate([0,0,180]) {
                                text(chr(65+x/mellomrom_h), 
                                    font=font,
                                    halign="center",
                                    size = 9);
                                //echo(str("[2] and out with a chr(65+x/mellomrom_h), that is, ", chr(65+x/mellomrom_h)));
                            }
                        }
                    }
                    // 
                    if (x == 0) {
                        translate([-mellomrom_h,linjelengde/2]) {
                            text(chr(49+y/(linjelengde+mellomrom_v)), 
                                font=font,
                                halign="center",
                                valign="center",
                                size = 11);
                            echo(str("[3] and out with a chr(49+y/(linjelengde+mellomrom_v)), that is, ", 
                                chr(49+y/(linjelengde+mellomrom_v))));
                            echo(str("¿ x is ", x, " and y is ", y));
                        }
                    } else if (x == (linjeantall-1)*mellomrom_h) {
                        translate([mellomrom_h,linjelengde/2]) {
                            rotate([0,0,180]) {
                                text(chr(49+y/(linjelengde+mellomrom_v)), 
                                    font=font,
                                    halign="center",
                                    valign="center",
                                    size = 11);
                                echo(str("[4] and out with a chr(49+y/(linjelengde+mellomrom_v)), that is, ", 
                                    chr(49+y/(linjelengde+mellomrom_v))));
                                echo(str("-- x is ", x, " and y is ", y, " and chr(49+y/(linjelengde+mellomrom_v) is ",
 chr(49+y/(linjelengde+mellomrom_v))));
                                echo(str("y is ", y, " and y/(linjelengde+mellomrom_v) is ", y/(linjelengde+mellomrom_v)));
                                echo(str("linjelengde is ", linjelengde));
                                echo(str("+mellomrom_v is ", +mellomrom_v));
                            }
                        }
                    } else {
                        //echo(str("<><><><><> x is ", x, " and y is ", y));
                    }
                    //echo("fremdeles notasjon");
                }
            }
        }
    }
}

translate([60,50]) {
    sahkkubrett();
}

//translate([30,30]) kryss();