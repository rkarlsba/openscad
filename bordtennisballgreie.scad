tykkelse=8;
bredde=46;
dybde=bredde;
hoyde=120;
ballstoerrelse=40; // diameter
//tegne_ball=false;

cube([bredde,dybde,tykkelse]);
cube([tykkelse,tykkelse,hoyde-tykkelse]);
translate([bredde-tykkelse,0,0])
    cube([tykkelse,tykkelse,hoyde-tykkelse]);
translate([0,bredde-tykkelse,0])
    cube([tykkelse,tykkelse,hoyde-tykkelse]);
translate([bredde-tykkelse,bredde-tykkelse,0])
    cube([tykkelse,tykkelse,hoyde-tykkelse]);
translate([0,0,hoyde-tykkelse])
cube([bredde,dybde,tykkelse]);

if (tegne_ball == true) {
    translate([bredde/2,dybde/2,ballstoerrelse])
        sphere(d=ballstoerrelse, $fn = 64);
}