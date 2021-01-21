// pisa

x=50;
y=30;
z=55;

bleed=.5;
walls=4;
var=walls*.75;

module statsbygg(size, bleed=.5, var=1, stepsize=1, rseedx, rseedy) {
    x = size[0];
    y = size[1];
    
    // init random
    rmin = -var;                    // float
    rmax = var;                     // float

    rvals = size[2]+1;              // int - veit ikke om jeg trenger z+1, men skader ikke
    srand = rands(0,99999,2);  // trengs hvis ikke angitt
    
    rsx = (rseedx == undef) ? srand[0] : rseedx;
    rsy = (rseedy == undef && rsx != undef) ? rsx : 
          (rseedy == undef && rsy == undef) ? srand[1] : rseedy;
    
    xrand = rands(rmin, rmax, rvals, rsx);
    yrand = rands(rmin, rmax, rvals, rsy);
    
    echo("Starting the fun with srand", srand, ", rsx, ", rsx, " and rsy ", rsy);
    xpos = 0;
    ypos = 0;
    
    for (z = [0:stepsize:size[2]]) {
        xpos = xpos + xrand[z];
        ypos = ypos + yrand[z];
        translate([xpos,ypos,z])
            linear_extrude(stepsize)
                square([x+bleed*2,y+bleed*2]);
                //square([size[0]+bleed*2,size[1]+bleed*2]);
    }
}

module ramme(size, walls=3, bleed=.5) {
    translate([bleed,bleed]) {
        difference() {
            translate([-bleed,-bleed])
                square([size[0]+bleed*2,size[1]+bleed*2]);
            translate([walls,walls]) {
                square([size[0]-walls*2,size[1]-walls*2]);
            }
        }
    }
}


statsbygg(size=[x,y,z], bleed=0, var=1.5, stepsize=3);