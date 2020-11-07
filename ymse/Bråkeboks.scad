$fn=32;

content = "Juuuuuuul";
font = "Palatino";
font_size = 12;

module dert(trans=[0,0,0]) {
    translate(trans) {
        difference() {
            cylinder(h = 1, r = 5);
            cylinder(h = 1, r = 4);
        }
    }
}


union() {
    /*
    dert([10,10,0]);
    dert([50,10,0]);
    dert([10,50,0]);
    dert([50,50,0]);
    */
    translate([0,0,0]) {
        difference() {
            cube([60,60,30]);
            translate([2,2,2]) {
                cube([56,56,28]);
            }
            for (y=[10:5:50]) {
                for (x=[10:5:50]) {
                    translate([x,y,0]) {
                        cylinder(h =  2, r = 1);
                    }
                }
            }
        }
    }
}

translate([65,0,0]) {
    difference() {
        union() {
            cube([60,60,2]);
            translate([2,2,2]) {
                cube([56,56,3]);
            }
        }
        translate([30,30,2]) {
            cylinder(h = 6, r = 23);
        }
        translate([30,30,0]) {
            translate([-8,20,0])   cube([16,1,2]);
            translate([-12,18,0])   cube([24,1,2]);
            translate([-14,16,0])   cube([28,1,2]);
            translate([-16,14,0])   cube([32,1,2]);
            translate([-17.5,12,0]) cube([35,1,2]);
            translate([-19.2,10,0])   cube([38.4,1,2]);
            translate([-20.2,8,0])    cube([40.4,1,2]);
            translate([-21,6,0])    cube([42,1,2]);
            translate([-21.6,4,0])    cube([43.2,1,2]);
            translate([-22,2,0])    cube([44,1,2]);
            
            translate([-22.3,0,0])    cube([44.6,1,2]);
            
            translate([-22,-2,0])    cube([44,1,2]);
            translate([-21.6,-4,0])    cube([43.2,1,2]);
            translate([-21,-6,0])    cube([42,1,2]);
            translate([-20.2,-8,0])    cube([40.4,1,2]);
            translate([-19.2,-10,0])   cube([38.4,1,2]);
            translate([-17.5,-12,0]) cube([35,1,2]);
            translate([-16,-14,0])   cube([32,1,2]);
            translate([-14,-16,0])   cube([28,1,2]);
            translate([-12,-18,0])   cube([24,1,2]);
            translate([-8,-20,0])   cube([16,1,2]);
            
        }        
    }
}