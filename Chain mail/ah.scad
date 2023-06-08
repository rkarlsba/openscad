
    r1=25;
    r2=27.25;
    r3=18.5;
    h1=2.5;
    h2=34;
    h3=5;
    sb=7; // stripsbredde
    
    /*
    module feste() {
        union() {
            cube([
    }
    */

module kropp() {
    profil = [
        [0,0],              // 0
        [r1,0],             // 1
        [r1,h1],            // 2
        [r2,h1+.8],         // 3
        [r2,h1+h2-2],       // 4
        [r3,h1+h2],         // 5
        [r3,h1+h2+h3],      // 6
        [0,h1+h2+h3]        // 7
    ];

    difference() {
        cylinder(r=30,h=h1+h2+h3);
        rotate_extrude($fn=180, angle=360, convexity = 2)
            polygon(profil);
        translate([-50,0,0]) cube([100,50,50]);
		
        
    }
}
module snap() {
	cube([16,12,2]);
	difference(){
		translate([0,0,2])rotate([0,10,0])cube([5,12,2]);
		translate([0,-1,2.5])rotate([0,-5,0])cube([8,14,2]);
	}
}
module kropp1 (){
kropp();

translate([31,-4,0]){
	translate([3,2,0])cylinder(h=h1+h2+h3,r=2,$fn=30);
	translate([-3,0,0])cube([10,4,12] );
	translate([-3,0,30])cube([10,4,12]);
	translate([-3,0,-30]) cube([4,10,-8]);
	translate([-61,14,(h1+h2+h3)/2+4])rotate([90,180,90])snap();
}
}

module kropp2(){
	rotate([0,0,180]) kropp();
	translate([28,-6,15])cube([10,15,12]);
}


translate([-34,2,0]) {difference() {
	kropp2();
	kropp1();
	translate([31,-4,0]){
	translate([3,2,0])cylinder(h=h1+h2+h3,r=2.2,$fn=30);}
}
}

rotate([0,0,20])translate([-34,2,0])kropp1();



