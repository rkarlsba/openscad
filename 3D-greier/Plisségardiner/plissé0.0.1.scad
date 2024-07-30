// Total lengde 950mm
hull_d = 4;
hullbrem_d = 10;
hullbrem_h = 1.2;
hull_dist = 20;
bruk_skruehull = false;
bunn = 2 + (bruk_skruehull ? hullbrem_h : 0);
hull_h = bunn;
bredde = 24;
hoyde = 20;
lengde = 160;
vegg = 2;
avrunding = vegg;
kant = 1.5;
vkant = kant*1.5;
plugg_d = 1.8;
plugg_h = 15;
bruk_plugger = true;

skinne_p = [
    [0,0],
    [bredde+vegg*2, 0],
    [bredde+vegg*2, hoyde+bunn],
    [bredde+vegg-kant, hoyde+bunn],
    [bredde+vegg, hoyde+bunn-vkant],
    [bredde+avrunding, bunn+avrunding],
    [bredde, bunn],
    [vegg+avrunding, bunn],
    [vegg, bunn+avrunding],
    [vegg, bunn],
    [vegg, hoyde+bunn-vkant],
    [vegg+kant, hoyde+bunn],
    [0, hoyde+bunn],
    [0, hoyde],
];

module plugghull(plugg_d = plugg_d, plugg_h=plugg_h) {
    cylinder(d=plugg_d, h=plugg_h, $fn=128);
}

module skruehull(
    hull_d = hull_d,
    hull_h = hull_h, 
    dybde = bunn, 
    hullbrem_d = hullbrem_d, 
    hullbrem_h = hullbrem_h) {
    cylinder(d=hullbrem_d, h=hullbrem_h, $fn=128);
    translate([0,0,hullbrem_h]) {
        cylinder(d=hull_d, h=hull_h-hullbrem_h, $fn=128);
    }
}

module skinne(storrelse = skinne_p, hoyde = lengde) {
    difference() {
        linear_extrude(lengde) {
            polygon(skinne_p);
        }
        if (bruk_skruehull) {
            translate([bredde/2+vegg,hull_h,hull_dist]) {
                rotate([90,0,0]) {
                    skruehull();
                    echo ("høl");
                }
            }
            translate([bredde/2+vegg,hull_h,lengde-hull_dist]) {
                rotate([90,0,0]) {
                    skruehull();
                }
            }
        }
        if (bruk_plugger) {
            translate([vegg*.9,vegg*.9,0]) {
                plugghull();
            }
            translate([vegg*.9,vegg*.9,hoyde-plugg_h]) {
                plugghull();
            }
            translate([bredde+vegg*1.1,vegg*.9,0]) {
                plugghull();
            }
            translate([bredde+vegg*1.1,vegg*.9,hoyde-plugg_h]) {
                plugghull();
            }
        }
    }
}

skinne();
