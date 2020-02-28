$fn = $preview ? 16 : 64;

radius=5;
lengde=100;
bredde=120;
tykkelse=2.5;
toppkant=16;
sidekant=6;
pinnelengde=30;
pinnetykkelse=10;
teksthoyde=1;
font="Marker Felt:style=Thin";

module roundedrect(size,radius) {
    hull() {
        translate([radius,radius,0]) cylinder(r=radius,h=size[2]);
        translate([size[0]-radius,radius,0]) cylinder(r=radius,h=size[2]);
        translate([radius,size[1]-radius,0]) cylinder(r=radius,h=size[2]);
        translate([size[0]-radius,size[1]-radius,0]) cylinder(r=radius,h=size[2]);
    }
}

module ramme(size,radius,t1,t2,fontsize=10) {
    difference() {
        roundedrect(size,radius);
        translate([sidekant,toppkant,0]) {
            roundedrect([size[0]-sidekant*2,size[1]-toppkant*2,size[2]],radius);
        }
        translate([size[0]/2,size[1]-toppkant/2,0]) {
            echo(size[0]/2,toppkant/2,0);
            cylinder(h=tykkelse,r1=2,r2=4);
        }
        translate([8,size[1]-toppkant+3,tykkelse-teksthoyde]) {
            linear_extrude(height=teksthoyde) 
                text(t1, font = font, size=fontsize);
        }
        translate([size[0]/2+10,size[1]-toppkant+3,tykkelse-teksthoyde]) {
            linear_extrude(height=teksthoyde) 
                text(t2, font = font, size=fontsize);
        }
    }
}

ramme([lengde,bredde,tykkelse],radius,t1="Sygale",t2="Eva",fontsize=9);
translate([lengde/6,toppkant/2,tykkelse])
    cylinder(h=pinnelengde,d=pinnetykkelse);
translate([lengde/6*5,toppkant/2,tykkelse])
    cylinder(h=pinnelengde,d=pinnetykkelse);

//translate([lengde/2-2.5,0,0])
//    ramme([lengde/2+2.5,bredde,tykkelse],radius);
//translate([lengde/4*3,toppkant/2,tykkelse])
//    cylinder(h=pinnelengde,d=pinnetykkelse);
/*
    translate([40,bredde-8,0])
        cylinder(h=tykkelse,r1=2,r2=4);
    translate([lengde-40,bredde-8,0])
        cylinder(h=tykkelse,r1=2,r2=4);
*/
