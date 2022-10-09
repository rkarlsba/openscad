px0=0;
px1=25;
px2=px1+5;
px2a=px2+5;
px3=65;
px4=px3+5;
py0=0;
py1=10;
py2=17;
py2a=py2+10;
py3=20;
py4=25;
py5=60;
py6=py5+5;

width=40;
sheight=40;
srad=5;

rotate([90,0,0]) {
    difference() {
        translate ([0,width,0]) {
            rotate ([90,0,0]) {
                linear_extrude(width) {
                    polygon(points=[[px1,py0],[px4,py1],
                                [px4,py4],[px3,py4],
                                [px3,py3],[px2a,py2],[px2,py2a],
                                [px2,py6],[px0,py6],
                                [px0,py5],[px1,py5]],convexity = 0);
                    cylinder(1,2,2,center=true); 
                }
            }
        }
        rotate([0,0,0]) {
            translate([px1-5-srad,width/2,py6-sheight]) {
                cylinder(sheight,srad,srad);
                sphere(srad);
            }

  
            translate([px1-5-srad,width/2,py6-3]) {
                cylinder(3,srad+3,srad+3);
            }
        }
    }
}

rotate([180,0,0]) {
    translate([px1-5-srad,width/2,py6-sheight]) {
        cylinder(sheight,srad,srad);
        sphere(srad);
    }
    translate([px1-5-srad,width/2,py6-3]) {
        cylinder(3,srad+3,srad+3);
    }
}

