module torus(r1=1, r2=2, angle=360, endstops=0, $fn=50){
    if(angle < 360){
        intersection(){
            rotate_extrude(convexity=10, $fn=$fn)
            translate([r2, 0, 0])
            circle(r=r1, $fn=$fn);
            
            color("blue")
            wedge(h=r1*3, r=r2*2, a=angle);
        }
    }else{
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

module flat_heart() {
  square(20);

  translate([10, 20, 0])
  circle(10);

  translate([20, 10, 0])
  circle(10);
}

module makeheart() {
    function heart(t) = [ 19 * pow(sin(t), 3), 14 * cos(t) - 6 * cos(2 * t) - 2.2 * cos(3 * t) - cos(4 * t) ];
    polygon([ for (t = [0 : 360 ]) heart(t) ]);
}

linear_extrude(height = 6) {
    scale([1.3,1.3,1]) {
        makeheart();
    }
}

difference() {
    translate([0,10,0]) {
        torus(r1=1, r2=6, $fn=128);
    }
    translate([-10,0,-5]) {
        cube([20,20,5]);
    }
}

//linear_extrude(height = 12) 
//flat_heart();