/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=100
 *
 * bigclivedotcom
 *
 * Since many of you thought my last star generating OpenSCAD script was from the Famous "Welcome to fabulous Las Vegas" sign, here's a version that makes that star.
 * I've included "customizer" options in the script to allow you to adjust it to your preference.
 */


//Vegas star script by bigclivedotcom
//Size of star (mm)
size=170;

//Star plumpness 0.1-0.5 
plump=0.25;

//Depth of star (mm)
depth=25;

//Back wall thickness (mm)
thick=1;

//Side wall thickness (adjust to suit)
side=3;

//Lamp hole diameter (mm)
lamp=14;

//Screw hole diameter (mm)
screw=4;
wall=2*side;
fixing=size/4;

difference() {
    union() {
        //Star body
        rotate([0,0,45])
            scale([plump,1,1])
                cylinder(depth,d=size*.75);
        rotate([0,0,135])
            scale([plump,1,1])
                cylinder(depth,d=size*.75);
        scale([plump,1,1])
            cylinder(depth,d=size);
        scale([1,plump,1])
            cylinder(depth,d=size);
    }

    //Star interior
    rotate([0,0,45])
        scale([plump,1,1])
            translate([0,0,thick])
                cylinder(depth,d=(size*.75)-wall);
    rotate([0,0,135])
        scale([plump,1,1])
            translate([0,0,thick])
                cylinder(depth,d=(size*.75)-wall);
    scale([plump,1,1])
        translate([0,0,thick])
            cylinder(depth,d=size-wall);
    scale([1,plump,1])
        translate([0,0,thick])
            cylinder(depth,d=size-wall);

    //Lamp socket hole
    translate([0,0,-1])
        cylinder(thick+2,d=lamp,$fn=100);

    //Screw holes
    translate([0,fixing,-1])
        cylinder(thick+2,d=screw,$fn=100);
    translate([fixing,0,-1])
        cylinder(thick+2,d=screw,$fn=100);
    translate([0,-fixing,-1])
        cylinder(thick+2,d=screw,$fn=100);
    translate([-fixing,0,-1])
        cylinder(thick+2,d=screw,$fn=100);
}
$fn=4; 
