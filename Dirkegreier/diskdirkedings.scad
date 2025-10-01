$fn = 32;
step=1;
teksthoyde=0.2;

lengde = 70;
flipplengde = 10;
bredde = 6;
avrunding = 1;

//tekst = "The lockpick thingie BB & LPL left out";

module pilhaandtak(lengde = 60, bredde = 6, avrunding = 1) {
    hull()
    {
        translate([avrunding,avrunding-flipplengde/2]) {
            circle(r=avrunding);
        }
        translate([avrunding,bredde-avrunding+flipplengde/2]) {
            circle(r=avrunding);
        }
        translate([avrunding+flipplengde,bredde-avrunding]) {
            circle(r=avrunding);
        }
        translate([avrunding+flipplengde,avrunding]) {
            circle(r=avrunding);
        }
    }
}

module pilspiss(lengde = 60, bredde = 6, avrunding = 1) {
    hull()
    {
        translate([avrunding+flipplengde,bredde-avrunding]) {
            circle(r=avrunding);
        }
        translate([avrunding+flipplengde,avrunding]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding,avrunding]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding+bredde, bredde/2]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding,bredde-avrunding]) {
            circle(r=avrunding);
        }
    }
}

module modell() {
    hull()
    {
        linear_extrude(step) {
            pilhaandtak(lengde = lengde, bredde = bredde, avrunding = avrunding);
        }
        translate([0,step,step]) {
            linear_extrude(1) {
                pilhaandtak(lengde = lengde-step, bredde = bredde-step*2, avrunding = avrunding);
            }
        }
    }

    hull()
    {
        linear_extrude(step) {
            pilspiss(lengde = lengde, bredde = bredde, avrunding = avrunding);
        }
        translate([0,step,step]) {
            linear_extrude(1) {
                pilspiss(lengde = lengde-step, bredde = bredde-step*2, avrunding = avrunding);
            }
        }
    }
    if (tekst) {
        translate([flipplengde+step*2,step*2,step*2]) {
            linear_extrude(teksthoyde) {
                text(tekst, size=1.8, spacing=1.13);
            }
        }
    }
}

pst=90;

strl=pst/100;
scale([strl,strl,strl]) {
    modell();
    translate([step*2,step*7,step*2]) {
        rotate([0, 0, 270]) {
            linear_extrude(teksthoyde) {
                text(str(pst), size=5, spacing=1.13);
            }
        }
    }
}
