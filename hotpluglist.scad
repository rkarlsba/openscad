$fn = 32;

listelengde = 123;
disklistetykkelse = 3.5;
disklistebredde = 6;
disklistepadding = 2;
diskpluggtykkelse = 2.65;
kabinettlistevinger = disklistebredde;
kabinettlistebredde = disklistebredde+2*kabinettlistevinger+disklistepadding;
kabinettlistetykkelse = disklistetykkelse + 2;
kabinettpluggtykkelse = 3;
kabinettplugglengde = 4;

module diskliste(ht = "b") {
    handtak = disklistetykkelse*4;

// Handtak
    if (ht == "b" || ht == "h" || ht == "v") {
        mask_h = 0;
        mask_v = 0;
        
        difference() {    
            translate([disklistetykkelse,-handtak]) {
                difference() {
                    cylinder(h=disklistetykkelse,r=handtak);
//                    cylinder(h=listtykkelse,r=handtak/2);
                }
            }
            
            if (ht == "h") {
                translate([disklistebredde,-handtak*2]) {
                    cube([disklistebredde*2,handtak*2,disklistetykkelse]);
                }
            }

            if (ht == "v") {
                translate([0-disklistebredde*2,-handtak*2]) {
                    cube([disklistebredde*2,handtak*2,disklistetykkelse]);
                }
            }
        }
    }
    translate([disklistebredde/2,5,0]) {
        cylinder(h=disklistetykkelse+4, d=diskpluggtykkelse);
        translate([0,61,0]) {
            cylinder(h=disklistetykkelse+4, d=diskpluggtykkelse);
            translate([0,41,0]) {
                cylinder(h=disklistetykkelse+4, d=diskpluggtykkelse);
            }
        }
    }
    
    translate([0,-2,0]) {
        cube([disklistebredde,listelengde+2-disklistebredde/2,disklistetykkelse]);
        translate([disklistebredde/2,listelengde+2-disklistebredde/2,0]) {
            cylinder(d=disklistebredde, h=disklistetykkelse);
        }
    }

}

module kabinettliste() {
    difference() {
        cube([kabinettlistebredde,listelengde,kabinettlistetykkelse]);
        translate([kabinettlistevinger,0,kabinettlistetykkelse-disklistetykkelse]) {
            cube([disklistebredde+disklistepadding,listelengde+2,disklistetykkelse]);
        }
    }
    translate([kabinettlistevinger/2,20,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }
    translate([kabinettlistevinger/2,listelengde/2,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }
    translate([kabinettlistevinger/2,listelengde-20,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }

    translate([kabinettlistevinger+disklistebredde+disklistepadding+kabinettlistevinger/2,20,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }
    translate([kabinettlistevinger+disklistebredde+disklistepadding+kabinettlistevinger/2,listelengde/2,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }
    translate([kabinettlistevinger+disklistebredde+disklistepadding+kabinettlistevinger/2,listelengde-20,-kabinettplugglengde]) {
        cylinder(h=kabinettplugglengde, d=kabinettpluggtykkelse);
    }
}

/*
translate([0,0,0]) {
    diskliste("h");
}
translate([9,0,0]) {
    diskliste("v");
}
*/

/*
translate([0,0,0]) {
    diskliste("h");
}
translate([13,0,0]) {
    diskliste("v");
}
translate([45,0,0]) {
    diskliste("h");
}
translate([57,0,0]) {
    diskliste("v");
}
rotate(270) {
    translate([-159,0,0]) {
        diskliste("h");
    }
}
rotate(90) {
    translate([132,-90,0]) {
        diskliste("v");
    }
}

*/
rotate([0,180,0]) {
    translate([0,0,0]) {
        kabinettliste();
    }
}
/*
translate([-46,5,0]) {
    kabinettliste();
}
translate([23,5,0]) {
    kabinettliste();
}
translate([68,5,0]) {
    kabinettliste();
}
translate([90,5,0]) {
    kabinettliste();
}
translate([112,5,0]) {
    kabinettliste();
}
*/