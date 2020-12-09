// POINTY STAR
// fully parameterized pointy star
//
// created by Moritz Walter 2014
// iamnotachoice.com
// released under GPLv3 http://www.gnu.org/licenses/gpl.html

boxheight=30;
cornerCount = 5;
starRadius = 50;
cornerWidth = 17;
cornerHeight = 15;
cornerFN = 4;
maniFix=0.01;
vegger=2;
lokk=false;
boks=true;

// experimental
useExperimentalTruncation=false;

// Boks
if (boks) {
    linear_extrude(boxheight)
        projection()
            halveStar();
}

// Lokk
if (lokk) {
    translate([0,0,boxheight]) {
        halveStar();
    }
}

module halveStar(){
	difference(){
		star();
		translate([0,0,-cornerHeight])
			cylinder(r=1.3*starRadius,h=2*cornerHeight,center=true,$fn=cornerCount);
	}
}

module star() {
	union(){
		for( i=[1:1:cornerCount] ) {
			rotate( [0,0,360/cornerCount * i] )
				truncatedCorner();
		}
		manifoldFix();
		scale([1,1,-1])
			manifoldFix();
	}
}

module manifoldFix(){
	translate([0,0,cornerHeight/2])
		cylinder(r1=cornerHeight, r2=0,h=cornerHeight+maniFix,center=true);
}

module truncatedCorner(){
	difference(){
		corner();
		translate([-starRadius/2,0,0] )
			cube([starRadius,starRadius,starRadius],center=true);
		if(useExperimentalTruncation){
			rotate([0,0,180/cornerCount])
				translate( [starRadius/2,cornerWidth,0] )
					cube([starRadius,2*cornerWidth,2*cornerHeight],center=true);
			rotate([0,0,-180/cornerCount])
				translate( [starRadius/2,-cornerWidth,0] )
					cube([starRadius,2*cornerWidth,2*cornerHeight],center=true);
		}

	}
}

module corner(){
	scale( [starRadius,cornerWidth,cornerHeight] )
		rotate([0,90,0])
			translate([0,0,0.5])
				cylinder( r1=1, r2=0, h=1, $fn = cornerFN, center=true );

}

module experimentalCorner(){
	for(i=[1:1:cornerSegmentCount]){
		// angle=90-i*90/cornerSegmentCount
		// lastAngle=90-(i-1)*90/cornerSegmentCount
		// x=cos(lastAngle)*starRadius
		// h=(cos(angle)-cos(lastAngle))*starRadius
		// r1=sin(lastAngle);
		// r2=sin(angle)

		// x=cos(90-(i-1)*90/cornerSegmentCount)*starRadius
		// h=(cos(90-i*90/cornerSegmentCount)-cos(90-(i-1)*90/cornerSegmentCount))*starRadius
		// r1=sin(90-(i-1)*90/cornerSegmentCount);
		// r2=sin(90-i*90/cornerSegmentCount)
		scale([1,cornerWidth,cornerHeight])
			translate([(cos(90-i*90/cornerSegmentCount)-cos(90-(i-1)*90/cornerSegmentCount))*starRadius/2+cos(90-(i-1)*90/cornerSegmentCount)*starRadius,0,0] )
				rotate( [0,90,0] )
					cylinder( h=(cos(90-i*90/cornerSegmentCount)-cos(90-(i-1)*90/cornerSegmentCount))*starRadius, r1=sin(90-(i-1)*90/cornerSegmentCount), r2=sin(90-i*90/cornerSegmentCount), $fn = cornerFN, center=true );
	}
}