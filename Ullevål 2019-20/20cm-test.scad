lengde=100;
bredde=10;

translate([-bredde/2,-bredde/2,0]) cube([bredde,bredde,lengde]);
translate([bredde/2,-bredde/2,0]) cube([lengde-bredde/2,bredde,bredde]);
translate([-bredde/2,bredde/2,0]) cube([bredde,lengde-bredde/2,bredde]);
translate([-lengde,-bredde/2,0]) cube([lengde-bredde/2,bredde,bredde]);
translate([-bredde/2,-lengde,0]) cube([bredde,lengde-bredde/2,bredde]);