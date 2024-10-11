use <ymse.scad>

pff = $preview ? .1 : 0; // preview fuckup fix

hsx = 50;   // house size x
hsy = 30;   // house size y
hsz = 20;   // house size z
ft = 2;     // floor thickness
wt = 2;     // wall thickness

dpx = 10;   // door position x
dpy = 0;    // door position y
dpz = ft;   // door position z

dsx = 9;    // door size x
dsy = wt;   // door size y
dsz = floor(hsz*.7);   // door size z

// debug
echo(round(pi()));

module main() {
    difference() {
        cube([hsx,hsy,hsz]);
        union() { // remove this
            translate([wt,wt,wt]) {
                cube([hsx-wt*2,hsy-wt*2,hsz-ft+pff]);
            }
            translate([dpx,dpy-pff,dpz]) {
                cube([dsx,dsy+pff*2,dsz]);
            }
        }
    }
}

main();