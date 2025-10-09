// norsk flagg

fisk = $preview ? .1 : 0;
gaps = $preview ? 0 : .2;

liten_rod = [6-gaps,6-gaps];
stor_rod = [liten_rod[0]*2-gaps,liten_rod[1]-gaps];
hvit = 1-gaps;
blaa = 2-gaps;

flagg = [(liten_rod[0]+stor_rod[0]+hvit*2+blaa),liten_rod[1]+stor_rod[1]+hvit*2+blaa];

// base
color("white") square(flagg);
color("red") square(liten_rod);
translate([gaps, liten_rod[0]+hvit*2+blaa]) color("red") square(liten_rod);

// Rød
translate([liten_rod[0]+hvit*2*blaa, 0]) color("red") square(stor_rod);
translate([liten_rod[0]+hvit*2*blaa, liten_rod[0]+hvit*2+blaa]) color("red") square(stor_rod);

// Blå
translate([gaps, liten_rod[0]+hvit]+gaps*2) color("blue") square([flagg[0], blaa]);
translate([liten_rod[1]+hvit, gaps]) color("blue") square([2, liten_rod[1]+stor_rod[1]+hvit*2+blaa]);
//translate([liten_rod[1]+hvit]) color("blue") square([blaa, flagg[1]]);