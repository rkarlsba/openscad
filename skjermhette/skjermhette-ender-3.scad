/*
 * Skjermhette til Ender 3
 */
 
bredde = 106;
hoyde =  66;
tykkelse = 1;
kant = 5;

difference() {
    cube([bredde,hoyde,tykkelse+kant]);
    translate([tykkelse,0,0])
        cube([bredde-tykkelse*2,hoyde-tykkelse,kant]);
    echo(bredde-tykkelse*2, hoyde-tykkelse, kant-tykkelse);
}