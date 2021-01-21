// Hårete
bredde = 20;
dybde = 10;
tykkelse = 0.7;
hoyde = 15;

hull() {
    cube([bredde,bredde,tykkelse/3]);
    translate([1,1,tykkelse/3*2])
        cube([bredde-2,bredde-2,tykkelse/2]);
}
for (i = [0:1]) {
    translate([0,i*(bredde-dybde),0]) {
        translate([dybde/2,dybde/2,tykkelse]) {
            cylinder(h=hoyde,d1=dybde/2,d2=0,$fn=64);
        }
        translate([bredde-dybde/2,dybde/2,tykkelse]) {
            cylinder(h=hoyde,d1=dybde/2,d2=0,$fn=64);
        }
    }
}