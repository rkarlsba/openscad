magnettykkelse = 2.5;
magnetbredde = 30;
bredde = 50;
dybde = 60;
hoyde = 50;
vegg = 3;

echo (kammerhoyde);
difference() {
    cube([bredde,dybde,hoyde]);
    translate([vegg,0,vegg+magnettykkelse]) {
        cube([bredde-vegg*2,dybde,hoyde/2-vegg*2]);
        translate([(bredde-magnetbredde)/2-vegg,0,-3.75])
            cube([magnetbredde,dybde-vegg,magnettykkelse]);
        translate([0,0,hoyde/2-vegg*2+magnettykkelse*2]) {
            cube([bredde-vegg*2,dybde,hoyde/2-vegg*2]);
            translate([(bredde-magnetbredde)/2-vegg,0,-3.75])
                cube([magnetbredde,dybde-vegg,magnettykkelse]);
        }
    }
}