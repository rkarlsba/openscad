bredde = [270,170];    // pluss ei bue på 7mm
hoyde = [33,60];
hull_d = 8;
hullgloppe = 12;   // sentrum av høla langs y
hullmellomrom = 43-hull_d;
antall_hull = [8,5];
borstelengde = [11,35]; // Børstelengde
borstebredde = 6;
borstespalte = 1;
borster = [38,23]; // veit ikke om jeg trenger denne
avrunding_d = 24;
avrunding_y = -2;
avrunding_x = 6;

foran = 0;
bak = 1;

module freseskjort(versjon) {
    difference() {
        // Liste
        union() {
            x = (versjon == foran) ? avrunding_x : 0;
            translate([x,0]) {
                square([bredde[versjon]-x,hoyde[versjon]]);
            }
            if (versjon == foran) {
                difference() {
                    translate([hullgloppe,hullgloppe+avrunding_y]) {
                        circle(d = avrunding_d);
                    }
                    translate([-hull_d,-hull_d]) {
                        square([hull_d*5,hull_d]);
                    }
                }
            }
        }
        
        // Høl
        for (x=[hullgloppe:hullmellomrom:bredde[versjon]-hullgloppe]) {
            translate([x,hullgloppe]) {
                circle(d=hull_d);
            }
        }
        
        // Børster
        for (x=[borstebredde:borstebredde+borstespalte:bredde[versjon]-borstebredde]) {
            translate([x,hoyde[versjon]-borstelengde[versjon]]) {
                square([borstespalte,borstelengde[versjon]]);
            }
        }
    }
}

freseskjort(foran);
translate([0, 40]) {
    freseskjort(bak);
}
