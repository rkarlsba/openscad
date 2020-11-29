use <text_on/text_on.scad>

fn = $preview ? 32 : 256;
$fn=fn;

bredde=100;
hoyde=50;
tykkelse=2;
haandtak_bredde=8;
haandtak_tykkelse=6;
skraa=5;
torusdim=haandtak_tykkelse/2;
tekst="Helgas polarbrød";

// Higher definition curves
//$fs = 0.01;

module wedge(h, r, a, $fn=50)
{
    th=(a%360)/2;
    difference()
    {
        cylinder(h=h,r=r,center=true, $fn=$fn);
        if(th<90)
        {
            for(n=[-1,1])rotate(-th*n)translate([(r+0.5)*n,0,0])
                cube(size=[r*2+1,r*2+1,h+1],center=true);
        }
        else
        {
            intersection()
            {
                rotate(-th)translate([(r+0.5),(r+0.5),0])
                    cube(size=[r*2+1,r*2+1,h+1],center=true);
                rotate(th)translate([-(r+0.5),(r+0.5),0])
                    cube(size=[r*2+1,r*2+1,h+1],center=true);
            }
        }
    }
}


module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50){
    if (angle < 360){
        intersection(){
            rotate_extrude(convexity=10, $fn=$fn)
            translate([r2, 0, 0])
            circle(r=r1, $fn=$fn);
            
            color("blue")
            wedge(h=r1*3, r=r2*2, a=angle);
        }
    } else {
        rotate_extrude(convexity=10, $fn=$fn)
        translate([r2, 0, 0])
        circle(r=r1, $fn=$fn);
    }
    
    if(endstops && angle < 360){
        rotate([0,0,angle/2])
        translate([0,r2,0])
        sphere(r=r1);
        
        rotate([0,0,-angle/2])
        translate([0,r2,0])
        sphere(r=r1);
    }
}

translate([0,0,torusdim])
    torus(r1=torusdim, r2=bredde/2-torusdim,$fn=fn);

// Sylinder med tekst
difference() {
    translate([0,0,torusdim]) {
        difference() {
            cylinder(d=bredde,h=hoyde-skraa);
            cylinder(d=bredde-tykkelse,h=hoyde-skraa);
        }
        translate([0,0,hoyde-skraa]) {
            difference() {
                cylinder(d1=bredde,d2=bredde-tykkelse,h=skraa);
                cylinder(d=bredde-tykkelse,h=skraa);
            }
        }
    }

    font="Trattatello:style=Regular";
    translate([0,0,40]) rotate([0,180,0])
    text_on_cylinder(t=tekst,locn_vec=[0,0,0],r=bredde/2,
        r1=undef,r2=undef,h=40,size=10,rotate=0,font=font,
        updown=-10,direction="ltr",extrusion_height=1,eastwest=0,face="side");
}

// Kryss
translate([-bredde/2+torusdim,0,torusdim])
    rotate([0,90,0])
        cylinder(h=bredde-torusdim*2,r=torusdim);
translate([0,bredde/2-torusdim,torusdim])
    rotate([90,0,0])
        cylinder(h=bredde-torusdim*2,r=torusdim);
/*translate([-haandtak_bredde/2,-bredde/2+torusdim,0]) {
    cube([haandtak_bredde,bredde-torusdim*2,haandtak_tykkelse]);
}*/
