$fn=32;

content = "Juuuuuuul";
font = "Palatino";
font_size = 12;
box_x = 100;
box_y = 100;
box_z = 50;
wall_width = 2;

module dert(trans=[0,0,0]) {
    translate(trans) {
        difference() {
            cylinder(h = 1, r = 5);
            cylinder(h = 1, r = 4);
        }
    }
}


union() {
    translate([0,0,0]) {
        difference() {
            cube([box_x,box_y,box_z]);
            translate([wall_width,wall_width,wall_width]) {
                cube([box_x-wall_width*2,box_y-wall_width*2,box_z]);
            }
            for (y=[10:5:box_y-10]) {
                for (x=[10:5:box_y-10]) {
                    translate([x,y,0]) {
                        cylinder(h =  2, r = 1);
                    }
                }
            }
            translate([box_x-10,10,10]) {
                rotate([90,0,0]) {
                    cylinder(h=10,r=3);
                }
            }
        }
    }
}

translate([box_x+5,0,0]) {
    difference() {
        union() {
            cube([box_x,box_y,2]);
            translate([2,2,2]) {
                cube([box_x-4,box_y-4,3]);
            }
        }
        translate([box_x/2,box_y/2,2]) {
            cylinder(h = 6, r = box_x/2-7);
        }
/*
        difference() {
            translate([box_x/2,box_y/2,0]) {
                for (i=[-30:2:30]) {
                    val=cos(i*3)*90;
                    echo(val);
                    translate([i*2,-val,0]) {
                        cube([1,val*2,1]);
                    }
                }
            }
        }
*/

        difference() {
            translate([box_x/2,box_y/2,0]) {
                translate([-8,30,0])     cube([16,1,2]);
                translate([-12,28,0])     cube([24,1,2]);
                translate([-15.5,26,0])     cube([31,1,2]);
                translate([-19,24,0])     cube([37,1,2]);
                translate([-21,22,0])     cube([42,1,2]);
                translate([-23.5,20,0])     cube([47,1,2]);
                translate([-25,18,0])    cube([50,1,2]);
                translate([-26.5,16,0])    cube([53,1,2]);
                translate([-27.8,14,0])    cube([55.6,1,2]);
                translate([-28.9,12,0])  cube([57.8,1,2]);
                translate([-29.2,10,0])  cube([58.6,1,2]);
                translate([-29.7,8,0])   cube([59.4,1,2]);
                translate([-30.5,6,0])     cube([61,1,2]);
                translate([-31.1,4,0])   cube([62.2,1,2]);
                translate([-31.6,2,0])     cube([63.2,1,2]);
                
                translate([-31.6,0,0])     cube([63.2,1,2]);
                
                translate([-31.6,-2,0])     cube([63.2,1,2]);
                translate([-31.1,-4,0])   cube([62.2,1,2]);
                translate([-30.5,-6,0])     cube([61,1,2]);
                translate([-29.7,-8,0])   cube([59.4,1,2]);
                translate([-29.2,-10,0])  cube([58.6,1,2]);
                translate([-28.9,-12,0])  cube([57.8,1,2]);
                translate([-27.8,-14,0])    cube([55.6,1,2]);
                translate([-26.5,-16,0])    cube([53,1,2]);
                translate([-25,-18,0])    cube([50,1,2]);
                translate([-23.5,-20,0])     cube([47,1,2]);
                translate([-21,-22,0])     cube([42,1,2]);
                translate([-19,-24,0])     cube([39,1,2]);
                translate([-15.5,-26,0])     cube([31,1,2]);
                translate([-12,-28,0])     cube([24,1,2]);
                translate([-8,-30,0])     cube([16,1,2]);    
            }
            translate(100,20,0) {
                cylinder(h=10,r=30);
            }
        }
    }
}