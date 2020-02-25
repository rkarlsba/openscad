$fn=256;

// hva skal lages?
handtak=true;
underlag=true;

//radius=32;
radius=33.65;
height=100;
height2=10;
thickness=1;
start_a=0;
end_a=66;

//start_a=-31.5;
//end_a=31.5;

radius2=radius;
//radius3=31.1;
thickness2=5.0;

/*
difference() {
    cylinder(r=radius, h=height);
    cylinder(r=radius-thickness, h=height);
}
*/
module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}  
if (handtak) {
    translate([0,0,height/2-height2/2]) {
        difference() {
            sector(height2, radius2*2+thickness2, start_a, end_a);
            sector(height2, radius2*2, start_a, end_a);
            sector(height2, radius2*2+thickness2/2, start_a, start_a+5);
            sector(height2, radius2*2+thickness2/2, end_a-5, end_a);
        }
    }
}
if (underlag) {
    difference() {
        sector(height, radius*2, start_a, end_a);
        cylinder(h=height, r=radius-thickness);

    }
}
