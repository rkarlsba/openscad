// vim:ts=4:sw=4:sts=4:et:ai

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


