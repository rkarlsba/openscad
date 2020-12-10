// vim:ts=4:sw=4:sts=4:et:ai
//
// Christmas tree - Customizer version
// by kowomike, published Nov 18, 2013
// original OpenSCAD file http://www.thingiverse.com/thing:186164
//
// added branch segments and curve to customize tree
// mark peeters Nov 29, 2013
// http://www.thingiverse.com/thing:194112

/* [basic parameters] */
// Number of "twigs", or radial fins
number=7; //[2:20]

//Tree diameter at base [mm]
base_diameter=60; //[25:200]

// Tree height [mm]
height=70; //[10:200]

// Wall thickness
wall=.5; //[0.25:thin (0.25 mm),0.5:standard (0.5 mm),1:thick (1 mm)]

// Twist angle [°] (>180 will be hard to print)
twist=55; //[0:360]

// Turning direction
direction=-1; //[-1:counterclockwise,1:clockwise]

// Add hanger
hanger=2; //[0:none,1:make hole in top,2:add ring on top]

baseplate=1; //[1:small,2:full circle]

/* [branches and curve] */
// Number of branches, also effects curve. (make 1 for no curve, make higher that 4 to see a nice cubic curve)
branches=6; //[1:12]

// Tree branch over hang (how for back to notch branches) Large overhand will make blobs - but that is not always bad) [mm]
overhang=5; //[0:10]

// Trunk size is given in millimeter at the base. Value is in percent of base diameter. Zero means it'll be ignored as in the original.
trunk=10;

// If trunk_thickness is > 0, make the trunk hollow and make its walls as thick as given [mm]. Otherwise, make trunk massive.
trunk_thickness=1;

/* [Hidden] */
radius=(base_diameter/2);
branchrad=(base_diameter/2)-overhang-2;

// hanger section
difference () {
    tree(number=number,radius=radius,height=height,wall=wall,twist=twist,dir=direction,trunk=trunk);
    
    if (hanger==1) {
        for (i=[0,90]) {
            translate ([0,0,height*0.94])
            rotate ([90,0,i])
            scale ([1,2,1])
            cylinder (r=radius*0.025,h=10,$fn=25,center=true);
        }
    }
    
    if (trunk_thickness > 0) {
        inner_trunkradius=radius-trunk_thickness;
        inner_trunkheight=height*(inner_trunkradius/radius);
//        echo("inner_trunkradius = ", inner_trunkradius, "inner_trunkheight = ", inner_trunkheight);
        cylinder(h=inner_trunkheight, r1=(radius/100*trunk)-trunk_thickness, r2=0);
    }
}

if (hanger==2) {
    translate([0,0,height+2])
    rotate([90,0,0])
    scale([1,1,1])
    rotate_extrude(convexity = 10, $fn = 100)
    translate([3, 0, 0])
    circle(r = 1, $fn = 100);   
}
// end hanger 

// start module tree
module tree (number=6, radius=30, height=100, wall=0.5, twist=-90, dir=direction, trunk=0) {
    module branches() {
        points=
            [
                [wall*0.5,0],
                [wall*0.5, radius-1], 
                [wall*0.4, radius-0.6], 
                [wall*0.2, radius], 
                [0, radius], 
                [wall*-0.2, radius], 
                [wall*-0.4, radius-0.6], 
                [wall*-0.5, radius-1], 
                [wall*-0.5, 0]
            ];
        
        intersection () {
            // Tree fins, 1st part for intersection
            for (i = [1:number]) {
                rotate ([0, 0, i*360/number])
                linear_extrude($fn=100, height = height,  convexity = 10, twist = twist*direction)
                polygon( points);
            }

            // Tree branches & curve, 2nd part for intersection
            union() {
                for (i = [1:(branches)]) {
                    translate([0, 0, height-i*(height/branches)]) 
                    cylinder (r1=2+(overhang*(i/branches))+(branchrad*((i*i)/(branches*branches))), r2=2+(branchrad*(((i-1)*(i-1))/(branches*branches))), h=height/branches);
                }
            }
        } 

        // Baseplate
        if (baseplate == 1) {
            for (i=[1:number]) {
                rotate ([0, 0, i*360/number])
                linear_extrude($fn=100, height = 0.5,  convexity = 10)
                scale ([5, 1, 1])
                polygon(points);
            }
        }

        if (baseplate == 2) {
            cylinder (r=radius, height=0.5, $fn=100);
        }
    }

    module trunk(r,h) {
        trunkradius = r;
        height=h;
        
        cylinder(h=height, r1=trunkradius, r2=0);
    }
    
    branches();
    if (trunk > 0) {
        trunk(r=radius/100*trunk,h=height);
    }
}

