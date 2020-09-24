$fn=$preview?16:64;

fra_midten=1.8;
stottepinnebredde=0.8;
stottepinnelengde=2;
knappehoyde=2; // halvparten av totlen
knappebredde=5;
akslingshoyde=5; // husk: du trenger to av disse
akslingsbredde=2;

module knapp() {
    cylinder(h=akslingshoyde,r=akslingsbredde/2);
    cylinder(h=knappehoyde,r=knappebredde);
}

module stottepinne() {
    cylinder(h=stottepinnelengde,r=stottepinnebredde);
}

module stottepinner() {
    for (pin = [0:3]) {
        translate([pin*stottepinnebredde*3,0,0]) stottepinne();
    }
}
module knappmedfester() {
    difference() {
        knapp();
        translate([fra_midten,fra_midten]) cylinder(h=stottepinnelengde/2,r=stottepinnebredde);
        translate([-fra_midten,fra_midten]) cylinder(h=stottepinnelengde/2,r=stottepinnebredde);
        translate([fra_midten,-fra_midten]) cylinder(h=stottepinnelengde/2,r=stottepinnebredde);
        translate([-fra_midten,-fra_midten]) cylinder(h=stottepinnelengde/2,r=stottepinnebredde);
    }
}

knappmedfester();
translate([-knappebredde/2,knappebredde*1.5,0]) stottepinner();

