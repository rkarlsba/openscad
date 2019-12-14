// Door open holder V2 (C) by Joachim Eibl 2015
// Licence: CC BY-NC-SA 3.0 
// Creative Commons: attribution, non commercial, share alike
// See: http://creativecommons.org/licenses/by-nc-sa/3.0/

quality = 50;

thickness = 5;
rs = thickness / 2;
length = 80;
yOffset = length/2-5;
width = 20;

module profile()
{
	translate([rs,0,0]) 
		circle(r=rs, $fn=quality );
	translate([width-rs,0,0]) 
		circle(r=rs, $fn=quality );
	translate([rs,-rs])
		square([width-2*rs,thickness]);
}

module roundedHalfBox()
{
	translate([rs,rs,rs]) 					sphere(r=rs,$fn=quality);
	translate([rs,length-rs,rs])            sphere(r=rs,$fn=quality);
	translate([rs,length-rs,width-rs])      sphere(r=rs,$fn=quality);
	translate([rs,rs,width-rs])             sphere(r=rs,$fn=quality);

	translate([0,rs,0])     cube( [ thickness-rs,length - 2*rs, width ] ); 
	translate([0,0,rs])     cube( [ thickness-rs,length, width -2*rs ] ); 
	translate([0,rs,rs])	cube( [ thickness,length - 2*rs, width -2*rs ] ); 

	translate([0,length-rs,rs] ) 		rotate([0,90,0]) cylinder(h=rs,r=rs,$fn=quality);
	translate([0,rs,rs] ) 			    rotate([0,90,0]) cylinder(h=rs,r=rs,$fn=quality);
	translate([0,rs,width-rs] ) 		rotate([0,90,0]) cylinder(h=rs,r=rs,$fn=quality);
	translate([0,length-rs,width-rs] )  rotate([0,90,0]) cylinder(h=rs,r=rs,$fn=quality);

	translate([rs,rs,rs] )              rotate([0,0,0]) cylinder(h=width-2*rs,r=rs,$fn=quality);
	translate([rs,length-rs,rs] )       rotate([0,0,0]) cylinder(h=width-2*rs,r=rs,$fn=quality);

	translate([rs,rs,rs] )              rotate([-90,0,0]) cylinder(h=length-2*rs,r=rs,$fn=quality);
	translate([rs,rs,width-rs] )        rotate([-90,0,0]) cylinder(h=length-2*rs,r=rs,$fn=quality);
}


module roundedBox(h,d,radius)
{
	translate([0,radius,radius]) 		sphere(r=radius,$fn=50);
	
	translate([0,h-radius,d-radius])    sphere(r=radius,$fn=50);

	translate([0,radius,radius])
		cylinder(h=d-2*rs, r=radius, $fn=50);
}

module hook(radiusDoorHandle,cutOffAngle)
{
    translate([thickness+radiusDoorHandle,-thickness,0]) rotate([0,0,-cutOffAngle])
        translate([0,radiusDoorHandle,0])
            roundedBox(thickness,width,rs);

    difference() {
        union(){

            difference()
            {
                translate([0,-thickness,0] )cube([radiusDoorHandle+thickness,2*radiusDoorHandle+thickness,width]);
                union() {
                    translate([thickness+radiusDoorHandle,2*radiusDoorHandle,-1]) cylinder(h=width+2, r=radiusDoorHandle+rs,$fn=quality);
                    translate([thickness+radiusDoorHandle,-thickness,-1]) cylinder(h=width+2, r=radiusDoorHandle+rs,$fn=quality);
                }
            }
            // upper radius (for smooth touch)
            difference() {
                translate([thickness+radiusDoorHandle,2*radiusDoorHandle,0])
                    rotate_extrude($fn=quality)
                        translate([radiusDoorHandle+rs,0,0]) rotate([0,0,90]) profile();
                union() {
                    translate([thickness+radiusDoorHandle,radiusDoorHandle-thickness,-1]) 		
                        cube([radiusDoorHandle+thickness,radiusDoorHandle+thickness+1,width+2]);	
                    translate([1,2*radiusDoorHandle,-1])     
                        cube([2*(radiusDoorHandle+thickness),radiusDoorHandle+thickness+1,width+2]);
                }
           }
            difference() {
                translate([thickness+radiusDoorHandle,-thickness,0])
                    rotate_extrude( $fn=quality)
                        translate([radiusDoorHandle + rs,0,0]) rotate([0,0,90]) profile();
                translate([1,-(radiusDoorHandle+2*thickness+2),-1]) 
                    cube([2*(radiusDoorHandle+thickness),radiusDoorHandle+thickness+2,width+2]);
            }
        }
        translate([thickness+radiusDoorHandle,-thickness,-1]) rotate([0,0,-cutOffAngle])	   
            cube([radiusDoorHandle+thickness,radiusDoorHandle+thickness,width+2]);	
    }
}


rotate([0,-90,0]) {
    translate([0,-yOffset,-0])
        roundedHalfBox();

    hook(radiusDoorHandle=20/2,cutOffAngle=80);
        
    difference() 
    {
        hull() 
        {
            translate([thickness+10,-thickness+2.3,0]) rotate([0,0,-90])
                translate([0,10,0])
                    roundedBox(thickness,width,rs);

            translate([thickness+17,-thickness+12.5,0]) rotate([0,0,-90])
                translate([0,10,0])
                    roundedBox(thickness,width,rs);

            translate([thickness-5,-thickness+12.5,0]) rotate([0,0,-90])
                translate([0,10,0])
                    roundedBox(thickness,width,rs);
        }

        translate([thickness+20/2,-thickness,-1]) cylinder(h=width+2, r=20/2+rs,$fn=quality);
    }
}