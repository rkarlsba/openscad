// POINTY STAR
// fully parameterized pointy star
//
// created by Moritz Walter 2014
// iamnotachoice.com
// released under GPLv3 http://www.gnu.org/licenses/gpl.html

cornerCount = 5;
starRadius = 50;
cornerWidth = 17;
cornerHeight = 15;
cornerFN = 4;
maniFix=0.01;
halve=true;

// experimental
useExperimentalTruncation=false;

boks(cornerCount, starRadius, cornerWidth, cornerHeight, cornerFN, maniFix, useExperimentalTruncation, 40, 3, 2);

module boks(cornerCount, starRadius, cornerWidth, cornerHeight, cornerFN, maniFix, useExperimentalTruncation, boxheight, floors, walls) {
    difference() {
        linear_extrude(boxheight) {
            projection() {
                echo("halveStar(", cornerCount, ", ", starRadius, ", ", cornerWidth, ", ", cornerHeight, ", ", cornerFN, ", ", maniFix, ", ", useExperimentalTruncation, ");");
                halveStar(cornerCount, starRadius, cornerWidth, cornerHeight, cornerFN, maniFix, useExperimentalTruncation);
            }
        }
        translate([0,0,floors]) {
            linear_extrude(boxheight-floors) {
                projection() {
                echo("halveStar(", cornerCount, ", ", starRadius-walls, ", ", cornerWidth-walls, ", ", cornerHeight, ", ", cornerFN, ", ", maniFix, ", ", useExperimentalTruncation, ");");
                    halveStar(cornerCount, 10, cornerWidth-walls, cornerHeight, cornerFN, maniFix, useExperimentalTruncation);
                }
            }
        }
    }
}

module lokk(cornerCount, starRadius, cornerWidth, cornerHeight, cornerFN, maniFix, useExperimentalTruncation) {
    translate([0,0,boxheight]) {
        halveStar();
    }
}


/*
if (halve){
	halveStar(cornerCount,starRadius,cornerWidth,cornerHeight,cornerFN,maniFix,useExperimentalTruncation);
} else{
	star(cornerCount,starRadius,cornerWidth,cornerHeight,cornerFN,maniFix,useExperimentalTruncation);
}
*/

module halveStar(cornerCount,starRadius,cornerWidth,cornerHeight,cornerFN,maniFix,useExperimentalTruncation) {
	difference() {
		star(cornerCount,starRadius,cornerWidth,cornerHeight,cornerFN,maniFix,useExperimentalTruncation);
		translate([0,0,-cornerHeight])
			cylinder(r=1.3*starRadius,h=2*cornerHeight,center=true,$fn=cornerCount);
	}
}

module star(cornerCount,starRadius,cornerWidth,cornerHeight,cornerFN,maniFix,useExperimentalTruncation) {
	union(){
		for( i=[1:1:cornerCount] ) {
			rotate( [0,0,360/cornerCount * i] )
				truncatedCorner(starRadius, useExperimentalTruncation);
		}
		manifoldFix(cornerHeight, cornerWidth, cornerHeight, maniFix);
		scale([1,1,-1])
			manifoldFix(cornerHeight, cornerWidth, cornerHeight, maniFix);
	}
}

module manifoldFix(cornerHeight, cornerWidth, cornerHeight, maniFix) {
	translate([0,0,cornerHeight/2])
		cylinder(r1=cornerHeight, r2=0,h=cornerHeight+maniFix,center=true);
}

module truncatedCorner(starRadius, useExperimentalTruncation){
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