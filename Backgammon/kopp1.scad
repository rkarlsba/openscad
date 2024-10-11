use <torus.scad>

diameter = 35;
width = 60;
height = 70;
thickness = 3;
bottom = 3;
edge = 3;

module _end() {
    hull() {
        circle(d = diameter);
        translate([width-diameter,0,0]) {
            circle(d = diameter);
        }
    }
}

module bue(thickness=thickness, diameter=diameter) {
    rotate([0,0,45]) {
        torus(r1 = thickness/2, r2 = diameter/2, angle=100, endstops=0);
    }
    rotate([0,0,125]) {
        torus(r1 = thickness/2, r2 = diameter/2, angle=100, endstops=0);
    }
}

module end(width=width, diameter=diameter) {    
    hull() {
        bue();
        translate([width-diameter,0,0]) {
            rotate([0,0,180]) {
              bue();
            }
        }
    }
}


module can(thickness=thickness, diameter=diameter, height=height, width=width) {
    hull() {
        echo(str("end(width=", width, ", diameter=", diameter, ");"))
        end(width=width, diameter=diameter);
        translate([0,0,height]) {
            end(width=width, diameter=diameter);
        }
    }
}

difference() {
    can();
    translate([thickness/2,thickness/2,thickness/2]) {
        can(diameter=diameter-thickness, width=width-thickness*2);
    }
}

//torus(r1=0.5, r2=4);
