
//Globe fairy light cap generator - bigclivedotcom
//Generates an LED cap based on a top and bottom
//diameter with flat sides.
//Suggested default values are in brackets.
//ADJUST THESE VARIABLES FOR GLOBE SHAPE AND SIZE
top=10;      //Diameter of globe at top (6)
bottom=15;  //Diameter of globe at base (20)
height=16;  //length of lamp (40)
facets=7;  //Number of facets around lamp (12 at first)
//More facets equals MUCH longer processing time!

//ADJUST THESE VARIABLES FOR BASE DIMENSIONS
baselen=4; //Length of base outside globe (4)
inside=3.5;   //Internal diameter of base (5.5)
led=3;      //LED HOLE diameter (5)

//Don't touch variables below this line
$fn=facets;
toprad=top/2;
botrad=bottom/2;
outside=inside+2;
base=baselen+5; 
difference() {
    union() {
        difference() {
            union() {
                //Outside shell of globe
                hull() {
                    //base of globe
                    sphere(r=botrad);
                    //top of globe
                    translate([0,0,height-toprad-botrad])
                        sphere(r=toprad);
                }
            }
            //Inside hollow of globe
            hull() {
                //base of globe
                sphere(r=botrad-1);
                //top of globe
                translate([0,0,height-toprad-botrad])
                    sphere(r=toprad-1);
            }
        }
        //LED base cylinder
        translate([0,0,0-botrad-(base-5)])
            cylinder(h=base,d1=outside,d2=outside,$fn=100);
        //LED base dome
        translate([0,0,0-botrad+5])
            cylinder(h=(outside-led)/2,d1=outside,d2=led+1,$fn=100);
    }
    //LED base interior
    translate([0,0,0-botrad-(base-5)-.01])
        cylinder(h=base+.02,d1=inside,d2=inside,$fn=100);
    //LED dome interior
    translate([0,0,0-botrad+5])
        cylinder(h=(outside-led)/2-1,d1=inside,d2=led,$fn=100);
    //LED hole
    translate([0,0,0-botrad+5])
        cylinder(h=10,d1=led,d2=led,$fn=100);
    //x-ray cube
    //translate([-50,-50,-40])
    //cube([100,50,100]);
}

