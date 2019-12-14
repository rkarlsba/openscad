// Parameterized OpenSCAD description of a plywood pen holder
// with 4 rastered and curved sides - Version March 9, 2013

// Formed wood is currently/was the theme of an exhibition
// "wood loop - auf biegen und brechen" at the
// Gewerbemuseum in Winterthur - 18. Nov. 2012 - 21. Apr. 2013

// Developed and tested with OpenSCAD - version 2013-01
// by Andr� F. from the Funlab Zurich, Switzerland - funlab.ch
// This code was developed using Notepad++ v6.3 replacing the
// standard built-in OpenSCAD editor.
// This object cannot be rendered in 3D
//=========================================================
// User modifiable settings: Dimensions in mm
// Installed laser cutter characteristic
//LaserBeamDiameter = 0.23;	    // Value applies to the funlab laser
//LaserBeamDiameter = 0.23;	    // Bitraf blå
//LaserBeamDiameter = 0.23;	    // Bitraf rød
LaserBeamDiameter = 0.31;	    // *cirkasånnher*
// Hint: A value 0 allows to verify the dimensions in a .dxf file e.g. in Autocad
// Material characteristic
MaterialThickness = 3.5;    // Material thickness
// Objects dimensions and other settings
Height = 115;				// Height of each of the 4 rastered and curved sides
Width = 65; 				// Width of each of the 4 rastered and curved sides
							// The resulting size of the pen holder will appear in the console
							// when Process = 1 set
ToothWidth = 5; 			// Conditions the computed number of teeth on the joint
StudW = 5;					// Width of bottom/top studs/teeth
Dis = 5; 					// Distance between the exported parts put in place for cutting
// Flexibility settings
Ratio = 0.5; 				// Ratio of flexible raster to side width. The flexible raster
							// is positioned in the middle of the width
SlotLength = 30;			// Conditions the number of raster slots for flexibility
SlotWidth = 0.5;			// Width of a raster slot
SlotDist = 2; 				// Distance between 2 rows of raster slots
// Type of operation to perform
Process = 0; 				// 0 = export parts in view of producing a .dxf file (F6)
							// 1 = verify all settings published in the console log
// Settings taking the LaserBeamDiameter into account and computed settings
// Do not change anything below this line....
//=========================================================
height = Height+LaserBeamDiameter;
width = Width+LaserBeamDiameter;
noOfSlots = floor(height/SlotLength); 			// Number of slots in a row
noOfRows = floor(Width*Ratio/(2*SlotDist));		// Pairs of slotrowA & slotrowB
flexiPart = SlotDist*(2*noOfRows+1);			// One more row for the symmetry
rigidPart = width-flexiPart;
slotWidth = SlotWidth - LaserBeamDiameter;
avail = rigidPart/2-MaterialThickness;			// Space vailable for stud
studPos = avail/2+MaterialThickness;			// Distance from the panel side to the stud's middle
									// then positioned at mid-distance between raster and teeth

// Bottom/top construction
//radius = 2*flexiPart/PI; 						// PI from MCAD/constants, theoretically correct formula
radius = 2*flexiPart/PI-MaterialThickness/2; 		// PI from MCAD/constants, in practice better value than above line
bottomWidth = rigidPart + 2*(radius+LaserBeamDiameter);
buildSize = floor(bottomWidth+2*MaterialThickness);

if (Process == 0) export(height,width);
else {
	echo(str("<b>flexipart noOfSlots: ",noOfSlots," - noOfRows: ",noOfRows,"</b>"));
	echo(str("<b>flexipart: ",flexiPart," mm - rigidpart: ",rigidPart," mm - radius: ",radius,"</b>"));
	
	echo(str("<b>Approx. pen holder dimensions WxDxH: ",buildSize," x ",buildSize," x ",Height,"</b>"));	
	if (avail-StudW < StudW)
		echo(str("<b><font color=red>Fragile! StudW= ",StudW,"mm excessive cut-out</font></b>"));
}

module export(h,w)
{	sideOffset = w + Dis;
	/* rasteredSide(h,w);										// 2 lines for testing
	   translate([0,w-MaterialThickness+0.5]) rasteredSide(h,w); */ // Substitute for the next statement

	for (i = [0 : 3]) translate([0,i*sideOffset]) rasteredSide(h,w);
	// Not obvious but very important correction when joining 2 toothed sides
	translate([-(h+bottomWidth)/2-Dis,(w-MaterialThickness)/2]) bottom();
	translate([	(h+bottomWidth)/2+Dis,(w-MaterialThickness)/2]) difference()
	{	bottom();
		hole();
	}
	/* The next line allows verifying the botton center alignment to the joint middle*/
	/* translate([	(h+bottomWidth)/2+Dis,(w-MaterialThickness)/2]) square([2*h,0.4],center=true); */
}
module tooth(w)					// Side begins with a tooth followed by a dent - Repeat noOfSteps
{	numTooth = round((w-LaserBeamDiameter)/ToothWidth);
	// Because of the symmetry the no. of parts must be odd
	numTooth2 = (numTooth%2 == 0)? numTooth-1 : numTooth;
	Step = (w-LaserBeamDiameter)/numTooth2;
	noOfSteps = floor(w/2/Step)-1;
	*echo(numTooth, numTooth2, Step, noOfSteps); 
	for (i = [0 : noOfSteps]) translate([2*Step*i,0])
		polygon([[0,0],[Step+LaserBeamDiameter,0],[Step+LaserBeamDiameter,MaterialThickness],
				 [2*Step,MaterialThickness],[2*Step,0]],[[0,1,2,3,4]]);
}

module dent(w) 					// Matching a row of teeth
{	numTooth = round((w-LaserBeamDiameter)/ToothWidth);
	numTooth2 = (numTooth%2 == 0)? numTooth-1 : numTooth;
	Step = (w-LaserBeamDiameter)/numTooth2;
	noOfSteps = floor(w/2/Step);
	*echo(numTooth, numTooth2, Step, noOfSteps);
	*square([LaserBeamDiameter,MaterialThickness]);
	translate([LaserBeamDiameter,0]) 					// Remove artefact at the beginning
	for (i = [0 : noOfSteps]) translate([2*Step*i,0])
		polygon([[0,0],[0,MaterialThickness],[Step-LaserBeamDiameter,MaterialThickness],
				 [Step-LaserBeamDiameter,0],[2*Step,0]],[[0,1,2,3,4]]);
	translate([w-LaserBeamDiameter,0]) square([LaserBeamDiameter,MaterialThickness]); // Remove the artefact at the end
}
module slotrowA(w)				// One interval less then the number of slots
{	SlotLength = (w-(noOfSlots-1)*2)/noOfSlots;
	for (i = [0 : noOfSlots-1]) translate([(SlotLength+2)*i,0])
		square([SlotLength,SlotWidth]);
}
module slotrowB(w)				// As many intervals as slots ; half slots at extremities
{	SlotLength = (w-noOfSlots*2)/noOfSlots;
	translate([-SlotLength/2,SlotDist])
	for (i = [0 : noOfSlots]) translate([(SlotLength+2)*i,0])
		square([SlotLength,SlotWidth]);
}
module rasteredSide(h,w) 		// 4 such parts needed. The rastered part is flexible
{	rasterMiddle = ((noOfRows*SlotDist)+SlotWidth/2);
	difference()	
	{	square([h,w],center=true);
		translate([-h/2,-w/2]) tooth(h);
	translate([-h/2,w/2-MaterialThickness]) dent(h);	// dent to match tooth on the joint
	translate([-height/2,-rasterMiddle])	// Locate slot raster in the middle of a side	
	for (i = [0 : noOfRows]) translate([0,i*SlotDist*2])
	{	slotrowA(h);
		if (i < noOfRows) slotrowB(h);
	}
	translate([-h/2, w/2-studPos])				 indent();
	translate([-h/2,-w/2+studPos])				 indent();
	translate([ h/2, w/2-studPos]) mirror([1,0,0]) indent();
	translate([ h/2,-w/2+studPos]) mirror([1,0,0]) indent();	
	}
}
module indent()		// indent and matching stud are positioned with their center
{	translate([MaterialThickness/2,0]) square([MaterialThickness,StudW-LaserBeamDiameter],center=true);
}
module roundcorners(c,r)			// Create 4 round corners: 4 quadrants of a circle
{	translate([ c, c]) circle(r);	// Upper right
	translate([ c,-c]) circle(r);	// Lower right
	translate([-c, c]) circle(r);	// Upper left
	translate([-c,-c]) circle(r);	// Lower left
}
module bottom()						// 2 such needed: 1 bottom and the cover with a hole
{	square([rigidPart,bottomWidth],center=true);
	square([bottomWidth,rigidPart],center=true);
	centerPos = bottomWidth/2-radius;
	roundcorners(centerPos,radius);
	translate([ bottomWidth/2,0])				      studpair();
	translate([-bottomWidth/2,0]) mirror([1,0,0])     studpair();
	translate([0, bottomWidth/2]) rotate(a=[0,0,90])  studpair();
	translate([0,-bottomWidth/2]) rotate(a=[0,0,-90]) studpair();
}
module hole()						// To subtract from a bottom to obtain a top
{	rad = radius-MaterialThickness;
	square([rigidPart-2*MaterialThickness+4,bottomWidth-2*MaterialThickness],center=true);
	square([bottomWidth-2*MaterialThickness,rigidPart-2*MaterialThickness+4],center=true);
	centerPos = bottomWidth/2-radius;
	roundcorners(centerPos,rad);
}
module stud()						// Matches with an indent on a side
{	translate([MaterialThickness/2,studPos-MaterialThickness/2]) 
		square([MaterialThickness,StudW+LaserBeamDiameter],center=true);
}
module studpair()					// Force symmetry without assigning values
{	stud();
	mirror([0,1,0]) stud();
}
