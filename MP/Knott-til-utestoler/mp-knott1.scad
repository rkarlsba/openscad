$fn = 256;

module miniround(size, radius) {
    $fn=50;
    x = size[0]-radius/2;
    y = size[1]-radius/2;

    minkowski() {
        cube(size=[x,y,size[2]]);
        cylinder(r=radius);
        // Using a sphere is possible, but will kill performance
        //sphere(r=radius);
    }

}

// FIXME

/* Her bør det brukes hull() for å kombinere to sylindre i stedet for de
 * jallagreiene her. Jeg veit ikke om hull() fantes da jeg først skreiv dette,
 * men om det gjorde det, så kjente jeg i hvert fall ikke til det.
 */

// oval greie 13x17mm ytre dim, tykkelse på veggene 2,5mm, så indre dim 8x12mm
/*
miniround([40,30,2], 2);
translate([18,15,2]) {
    scale([1.3,1.0,1.0]) {
        difference() {
            cylinder(d=13,h=15);
            cylinder(d=9,h=15);
        }
    }
}
*/

//translate([50,0,0]) 
{
miniround([38,28,2], 2);
    translate([14,11,2]) {
        difference() {
            miniround([14.5-3.5,10.5-3.5,15], 2.5);
            translate([1.25,1.25,0]) {
                miniround([12-3.5,8-3.5,15], 2.5);
            }
        }
    }
}

/*
module rarellipse(x,y) {
    translate([x,15,2]) {
        cylinder(d=13,h=15);
    }
    translate([y,15,2]) {
        cylinder(d=13,h=15);
    }

    translate([(x+y)/2-x/4.3,x/2.1,2]) {
//        cube([6,13,15]);
        cube([x/3,13,15]);
    }
}
*/
/*
translate([50,0,0]) {
    miniround([40,30,2], 2);
    difference() {
        rarellipse(18,22);
        rarellipse(15.5,19.5);
    }
*/
    /*
    difference() {
        {
            translate([18,15,2]) {
                cylinder(d=13,h=15);
            }
            translate([22,15,2]) {
                cylinder(d=13,h=15);
            }

            translate([17,8.54,2]) {
                cube([6,13,15]);
            }
        }
        {
            translate([18,15,2]) {
                cylinder(d=9,h=15);
            }
            translate([22,15,2]) {
                cylinder(d=9,h=15);
            }
            translate([17,8.54,2]) {
                cube([6,13,15]);
            }
        }
    }
*/
//}