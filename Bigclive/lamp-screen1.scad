//Custom fairy light cap generator 2023

//This is a FAST print by default
//You may wish to make minimum layer time zero and
//print at a lower speed like 40mm per second if it
//all goes a bit floppy.

//You can adjust these 3 variables to suit your application
//Make sure you leave the  = and ; intact on either side

basedia=9.8; //outside diameter of base
baselip=8;   //length of base
lampsize=20; //diameter of globe

//Advanced variables
facets=100;  //facets on bulb 6=hexagonal 100=round
wall=0.4;    //thickness of wall (multiple of print nozzle)
tip=5;       //diameter of tip of bulb
shape=1.7;   //0.7-1.7  1=diamond 1.7=round base

//Do not make changes below here
$fn=facets;
difference() {
    union() {
        //Outside shell of globe
        hull() {
            //base of globe
            translate([0,0,(lampsize/shape)+baselip])
                sphere(d=lampsize);
                //top of globe
            translate([0,0,(lampsize*2)+baselip])
                sphere(d=tip,$fn=100);
            //base cylinder interface
            translate([0,0,baselip-.1])
                cylinder(h=.1,d=basedia,$fn=100);
        }
        //base cylinder
        cylinder(h=baselip,d=basedia,$fn=100);
    }

    //Inside hollow of globe
    hull() {
        //base of globe
        translate([0,0,(lampsize/shape)+baselip])
            sphere(d=lampsize-(2*wall));
        //top of globe
        translate([0,0,(lampsize*2)+baselip])
            sphere(d=tip-(2*wall),$fn=100);
        //base cylinder interface
        translate([0,0,baselip-.1])
            cylinder(h=.1,d=basedia-(2*wall)-.2,$fn=100);
    }
    //base cylinder interior
    translate([0,0,-1])
        cylinder(h=baselip,d=basedia-(2*wall),$fn=100);
    //base internal ridge
    translate([0,0,baselip-1.1])
        cylinder(h=1.2,d1=basedia-(2*wall),d2=basedia-(2*wall)-1,$fn=100);
    //x-ray cube
    //translate([-50,-50,-40])
    //cube([100,50,100]);
}