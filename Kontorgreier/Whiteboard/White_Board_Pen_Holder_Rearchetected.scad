//White Board Pen Holder
//Copyright 2016 Douglas Peale

// This is a pen, eraser & spray bottle holder ment to sit on the glass partition between office cubicals.

// I wanted all of the edges filleted, and I wanted everything adjustable.
// The best tool I found for filleting was using minkowski() with a sphere at the radius of the fillet.
// There are two issues with this: minkowski with a sphere only works to round the convex corners of the object, concave corneres will still be sharp.
// And minkowski is a really expensive operation in time and memory.
// I solved the first problem by running the minkowski operation on the objects I created to create the holes, with a sphere twice the radius of the fillet I wanted.
// After the holes were created, and a second minkowski was run with a sphere of the radius I wanted for the fillet, the remaining concave radius in the holes was exactly the radius I wanted.
// I then added fillets to the concave edges between the hole walls.
// I minimized the second part of the problem by breaking the object into smaller pieces before running the minkowski operation. 
// Some parts were repetative, so I was able to do the minkowski on one part and copy it multiple times.
// Due to the complexity of minkowski being O(n^2), cutting an object in half cuts the memory usage by at least 2. so even if the function has to be run twice, and takes the same amount of total time
// not having the program exit with an out of memory error is a win.
//
// minkowski expands the object by the size of the object your are minkowskiing with, so I had to shrink everything by the fillet radius before running the minkowski.
// Shrinking the object runs the risk of the wall thickness going to zero, so there is a test that limits the size of the fillet radius so that nothing gets deleted.
//
// This is my second project using openSCad, and this editor fights against my previous code writing style, so I'm afraid my code does not look too clean.
//
// Note that I did not create a completely general solution. The filleting will fail if the bottle is too big, or the relative size of bottle & pen get too close togather, or too far apart.
// it does seem to work well around the reasonable values for bottle & pen size though.


//Get smooth curves
//Don't make this too big! minkowski is O(n^2)
$fn=64;

    //set to 1 to turn off the final munkowski (runs much faster)
Debug=0;

//Parameters
Clearance=1;
EraserWidth=52+Clearance;
EraserHeight=32+Clearance;
BottleRadius=17.5+Clearance/2;
PenRadius=10+Clearance/2;
GlassThickness=10.5+Clearance;
HoleDepth=40;
ExteriorWallThickness=2;
ObjectSpacing=4;
NumberOfPens=6;
FilletRadius=0; //Setting this to other than zero will fillet the corners, but on my system, that takes 30 minutes. Set larger than zero at your own risk.
FilletFacets=4*4;
BridgeThickness=10;

//Calculated Values

    //X distance between bottle and pen such that the two holse are ObjectSpacing apart.
PenToBottle=pow(pow(BottleRadius + PenRadius + ObjectSpacing, 2) - pow(BottleRadius - PenRadius, 2), 0.5);

    //Make sure walls don't dissappear
ActualExteriorWallThickness=(ExteriorWallThickness<ObjectSpacing)?ExteriorWallThickness:ObjectSpacing;
temp=(FilletRadius*2>=ActualExteriorWallThickness)?ActualExteriorWallThickness/2-.01:FilletRadius;
ActualFilletRadius=(FilletRadius>0)?temp:0;

    //How far to move things in the Y direction so there is room for the slot for the glass cubical partition wall.
YOffset=ActualExteriorWallThickness+GlassThickness/2;

    //X offsets to varius parts of the object
EndOfEraserBlock=EraserWidth+ActualExteriorWallThickness;
BottleOffset=EraserWidth+ActualExteriorWallThickness+ObjectSpacing+BottleRadius;
EndOfBottleBlock=EndOfEraserBlock+ObjectSpacing+2*BottleRadius;
FirstPenOffset=EndOfBottleBlock-BottleRadius+PenToBottle;


//combine the object with a mirror of itself, then cut out the channel that fits over the glass partition.
// This is done after the minkowski because I want sharp edges here.
difference()
{
    union(){
        halfblock();
        scale([1,-1,1])halfblock();
    }
    translate([-.5,-GlassThickness/2,-.5])
         cube([ActualExteriorWallThickness*2+ObjectSpacing*(NumberOfPens)*2*PenRadius+-PenRadius+BottleRadius+PenToBottle+1,GlassThickness,HoleDepth+ExteriorWallThickness-BridgeThickness+.5]);
}


// Create half of the object
module halfblock(){
    if((ActualFilletRadius>0.001)&&!Debug){
        minkowski(){
                eraserandbottle();
                sphere($fn=FilletFacets,r=ActualFilletRadius);
           }
       }else{
           eraserandbottle();
       }
            //Add objects to create middle part of row of pen holes
       if(NumberOfPens>1){
            for(i=[0:NumberOfPens-2]){
                translate([FirstPenOffset+i*(2*PenRadius+ObjectSpacing),0,0])minhalfsemgment(0);
                translate([FirstPenOffset+2*PenRadius+ObjectSpacing+i*(2*PenRadius+ObjectSpacing),0,0])scale([-1,1,1])minhalfsemgment(0);
            }
       }
        //Add last half of last pen hole
    translate([FirstPenOffset+(NumberOfPens-1)*(2*PenRadius+ObjectSpacing),0,0])minhalfsemgment(1);
    
}

    //extra calculations needed for fillet near eraser
RadiusToFilletCenter=BottleRadius+ActualExteriorWallThickness+FilletRadius;
XOffsetToFilletCenter=BottleRadius+ObjectSpacing-ActualExteriorWallThickness-FilletRadius;

TempBottleY2=pow(RadiusToFilletCenter,2)-pow(XOffsetToFilletCenter,2);

TempBottleX2Alt=pow(BottleRadius+ActualExteriorWallThickness+FilletRadius,2)-pow(2*FilletRadius,2);

OneBottleFillet=TempBottleY2>pow(ActualFilletRadius,2);

BottleFilletX=(OneBottleFillet)?BottleOffset-(BottleRadius+ObjectSpacing-ActualExteriorWallThickness-FilletRadius):BottleOffset-pow(TempBottleX2Alt,0.5);
BottleFilletY=(OneBottleFillet)?pow(TempBottleY2,0.5):FilletRadius;

BottleContactY=(BottleRadius+ActualExteriorWallThickness-FilletRadius)/RadiusToFilletCenter*BottleFilletY;
BottleContactX=(BottleRadius+ActualExteriorWallThickness-FilletRadius)/RadiusToFilletCenter*BottleFilletX;

    //Extra calculations needed for fillet between bottle & pens
DistanceBetweenBottleAndPen=PenRadius+ObjectSpacing+BottleRadius;
DistanceBetweenBottleAndFillet=BottleRadius+ActualExteriorWallThickness+FilletRadius;
DistanceBetweenPenAndFillet=PenRadius+ActualExteriorWallThickness+FilletRadius;


cosPB=PenToBottle/DistanceBetweenBottleAndPen;
cosPF=(pow(DistanceBetweenBottleAndPen,2)+pow(DistanceBetweenPenAndFillet,2)-pow(DistanceBetweenBottleAndFillet,2))/(2*DistanceBetweenPenAndFillet*DistanceBetweenBottleAndPen);

WayTooFarApart=DistanceBetweenBottleAndPen>(DistanceBetweenBottleAndFillet+DistanceBetweenPenAndFillet);
AngleIfTooFarApart=asin(FilletRadius/(PenRadius+ActualExteriorWallThickness+FilletRadius));
TempAngle=WayTooFarApart?AngleIfTooFarApart:acos(cosPF)+acos(cosPB);
TooFarApart=WayTooFarApart?WayTooFarApart:(DistanceBetweenPenAndFillet*sin(acos(cosPF)+acos(cosPB)))<FilletRadius;
AngleFromPenToFillet=TooFarApart?AngleIfTooFarApart:TempAngle;
echo(WayTooFarApart);
echo(acos(cosPB),acos(cosPF),AngleFromPenToFillet);

    //Location of fillet center relative to pen center
BPFilletX=cos(AngleFromPenToFillet)*(PenRadius+ActualExteriorWallThickness+ActualFilletRadius);
BPFilletY=sin(AngleFromPenToFillet)*DistanceBetweenPenAndFillet;
echo(BPFilletX,BPFilletY);

    //Z offset to bottom of plugs that create the holes
HoleZ=ActualExteriorWallThickness+ActualFilletRadius;

module eraserandbottle(){
    difference(){
    union(){
        
            //Cube to hold Eraser Hole
        translate([ActualFilletRadius,0,ActualFilletRadius])
            cube([EraserWidth+ActualExteriorWallThickness*2-2*ActualFilletRadius,EraserHeight+2*ActualExteriorWallThickness+GlassThickness/2-ActualFilletRadius,HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
              //Create Fillets between Bottle & Eraser
        difference(){
            union(){
                    
                difference() {
                    union(){
                        
                            //Fill for Eraser side of Fillet between Eraser & Bottle
                        translate([
                          EndOfEraserBlock+ActualExteriorWallThickness-ActualFilletRadius,
                          YOffset+BottleRadius-ActualFilletRadius,
                          ActualFilletRadius])
                            cube([
                               2*ActualFilletRadius,
                               min(BottleFilletY+ActualFilletRadius,EraserHeight+ActualExteriorWallThickness-BottleRadius),
                               HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                        
                            //Fill for Bottle Side of Fillet between Eraser & Bottle
                        translate([
                          BottleFilletX,
                          BottleRadius+ActualExteriorWallThickness+GlassThickness/2-ActualFilletRadius,
                          ActualFilletRadius])
                            cube([
                              2*ActualFilletRadius,
                              BottleContactY+ActualFilletRadius, 
                              HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                    }
                        //Cylinder that creates fillet between Bottle & Eraser
                    translate([
                      BottleFilletX,
                      BottleFilletY+BottleRadius+YOffset,
                      -.5])
                        cylinder(
                          $fn=FilletFacets,
                          h=HoleDepth+ActualExteriorWallThickness+1,
                          r=ActualFilletRadius*2);
                    if(!OneBottleFillet){
                        translate([
                          EndOfEraserBlock+ActualExteriorWallThickness+ActualFilletRadius,
                          BottleFilletY+BottleRadius+YOffset,
                          -.5])
                            cylinder(
                              $fn=FilletFacets,
                              h=HoleDepth+ActualExteriorWallThickness+1,
                              r=ActualFilletRadius*2);
                    }
                }
                
                        //Central part of block for Bottle Hole
                    translate([EndOfEraserBlock+ActualExteriorWallThickness-ActualFilletRadius,0,ActualFilletRadius])
                        cube([
                          BottleRadius*2+ObjectSpacing,
                          YOffset+BottleRadius-ActualFilletRadius,
                          HoleDepth+ActualExteriorWallThickness-ActualFilletRadius*2]);
                    
                        //Cylindrical part of block for bottle hole
                    translate([
                      EndOfEraserBlock+ObjectSpacing+BottleRadius,
                      BottleRadius+YOffset,
                      ActualFilletRadius])
                        cylinder(
                          h=HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius,
                          r=BottleRadius+ActualExteriorWallThickness-ActualFilletRadius);
                
                        //Fillet between bottle & pens
                    difference(){
                        union(){
                                //Block to be trimmed near pen
                            translate([
                              FirstPenOffset-BPFilletX,
                              YOffset+PenRadius-ActualFilletRadius,
                              ActualFilletRadius])
                                cube([
                                  cos(AngleFromPenToFillet)*(PenRadius+ActualExteriorWallThickness-ActualFilletRadius),
                                  sin(AngleFromPenToFillet)*(PenRadius+ActualExteriorWallThickness-ActualFilletRadius)+ActualFilletRadius,
                                  HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);

                                //Block to be trimmed near Bottle
                            translate([
                              EndOfBottleBlock+ActualExteriorWallThickness-ActualFilletRadius,
                              YOffset+PenRadius-ActualFilletRadius,
                              ActualFilletRadius])
                                cube([
                                  2*ActualFilletRadius,
                                  ActualFilletRadius+BPFilletY,
                                  HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                        }
                            //Fillet near pen
                        translate([
                          FirstPenOffset-BPFilletX,
                          YOffset+PenRadius+BPFilletY,
                          ActualFilletRadius-.5])
                            cylinder(
                              $fn=FilletFacets,
                              h=HoleDepth+ActualExteriorWallThickness+1,
                              r=ActualFilletRadius*2);
                            //Fillet near bottle
                        echo(TooFarApart);
                        if(TooFarApart){
                            translate([
                              EndOfBottleBlock+ActualExteriorWallThickness+ActualFilletRadius,
                              YOffset+PenRadius+ActualFilletRadius,
                              ActualFilletRadius-.5])
                                cylinder(
                                  $fn=FilletFacets,
                                  h=HoleDepth+ActualExteriorWallThickness+1,
                                  r=ActualFilletRadius*2);
                        }
                    }
                        //1st half of 1st pen block
                    difference(){
                        union(){
                                //Rectangular part of block that contains 1st half of 1st pen
                            translate([
                              EndOfBottleBlock+ActualExteriorWallThickness-ActualFilletRadius,
                              0,
                              ActualFilletRadius])
                                cube([PenToBottle-BottleRadius-ActualExteriorWallThickness+ActualFilletRadius,
                                  PenRadius+YOffset-ActualFilletRadius,
                                  HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                              //Cylintrical part of block that contains 1st half of first pen
                            translate([
                              FirstPenOffset,
                              YOffset+PenRadius,
                              ActualFilletRadius])
                                cylinder(
                                  h=HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius,
                                  r=PenRadius+ActualExteriorWallThickness-ActualFilletRadius);
                        }
                            //cube to remove half of cylinder of first half of 1st pen hole.
                        translate([
                          FirstPenOffset,
                          0,
                          ActualFilletRadius-.5])
                            cube([PenToBottle-BottleRadius-PenRadius+PenRadius,
                            2*PenRadius+YOffset+ActualExteriorWallThickness,
                            HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius+1]);

                    }
                }
            }
        }
            //cube to create Eraser hole
        translate([
          ActualExteriorWallThickness+ActualFilletRadius,
          GlassThickness/2+ActualExteriorWallThickness+ActualFilletRadius,
          HoleZ])
            minkowski(){
                cube([EraserWidth-2*ActualFilletRadius,EraserHeight-2*ActualFilletRadius,HoleDepth+1]);
                sphere($fn=FilletFacets,r=2*ActualFilletRadius);
            }
                //object to create bottle hole
        translate([BottleOffset,BottleRadius+YOffset,HoleZ])
            HolePlug(BottleRadius);
            // half plug to create half the hole in the 1st pen hole
        translate([EraserWidth+ActualExteriorWallThickness+ObjectSpacing+BottleRadius+PenToBottle,PenRadius+YOffset,ActualExteriorWallThickness+ActualFilletRadius])
            scale([-1,1,1])HalfPlug(PenRadius);
    }
}

//Calculate the location of the center of the Fillet between pens
Y2=pow(PenRadius+ActualExteriorWallThickness+ActualFilletRadius,2)-pow(PenRadius+ObjectSpacing/2,2);
PenFilletX=(Y2>pow(ActualFilletRadius,2))?PenRadius+ObjectSpacing/2:pow(pow(PenRadius+ActualExteriorWallThickness+ActualFilletRadius,2)-pow(2*ActualFilletRadius,2),0.5);  
PenFilletY=(Y2>pow(ActualFilletRadius,2))?pow(Y2,0.5):ActualFilletRadius;
StartBlock=PenFilletX*(PenRadius+ActualExteriorWallThickness-ActualFilletRadius)/(PenRadius+ActualExteriorWallThickness+ActualFilletRadius);

module minhalfsemgment(Last)  {
    if((ActualFilletRadius>0.01)&&!Debug){
        minkowski(){
            HalfPenSegment(Last);
            sphere($fn=FilletFacets,r=ActualFilletRadius);
        }
    }else{
        HalfPenSegment(Last);
    } 
}

module HalfPenSegment(Last){
    difference(){
      union(){
                // If not last, we need the filler & the fillet to fill the space between this half and the next
          if(Last<0.5){
                    //When two fillets are required, fill the flat space between them with this
                translate([PenFilletX,0,ActualFilletRadius])
                    cube([PenRadius+ObjectSpacing/2-PenFilletX,PenRadius+YOffset-ActualFilletRadius,HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                difference(){
                        //Fill block to be trimmed by fillet cylinder
                    translate([StartBlock,0,ActualFilletRadius])
                        cube([
                          PenFilletX-StartBlock,
                          PenRadius+YOffset+PenFilletY,
                          HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
                        //Fillet cylinder to be removed from above block
                    translate([PenFilletX,PenFilletY+YOffset+PenRadius,ActualFilletRadius-.5])
                        cylinder($fn=FilletFacets,h=HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius+1,r=2*ActualFilletRadius);
                }
          }
          
            //Create half a block to hold half a pen hole.
          translate([
                0,
                0,
                ActualFilletRadius])
            cube([PenRadius+ActualExteriorWallThickness-ActualFilletRadius,
                PenRadius+YOffset,
                HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius]);
          
            //Add on the round part of the pen hole block
          translate([
            0,
            YOffset+PenRadius,
            ActualFilletRadius])
              cylinder(
                h=HoleDepth+ActualExteriorWallThickness-2*ActualFilletRadius,
                r=PenRadius+ActualExteriorWallThickness-ActualFilletRadius);
        }
   
                //Create the hole for the pen
          translate([0,PenRadius+YOffset,HoleZ])
            HolePlug(PenRadius);
      }
}

    // Double up the half plug to get a whole plug, necessary to creat the bottle hole
module HolePlug(Radius){
    HalfPlug(Radius);
    scale([-1,1,1])HalfPlug(Radius);
      }

    // double up the quarter plug to create a half plug (needed for the HalfPenSegment
module HalfPlug(Radius){
    QuarterPlug(Radius);
    scale([1,-1,1])QuarterPlug(Radius);
}

    //minkowski the quarter of the plug if necessary.
module QuarterPlug(Radius){
    if(ActualFilletRadius>0.01)
    {
        minkowski(){
            QPlug(Radius);
            sphere($fn=FilletFacets,r=2*ActualFilletRadius);
        }
    }else{
        QPlug(Radius);
    }
}

    //Create only 1/4 of the hole plug to minimize the expense of minkowski
module QPlug(Radius){
    difference(){
        cylinder(h=HoleDepth+1,r=Radius-ActualFilletRadius);
        translate([-Radius-.01,-Radius-.01,-1])
            cube([Radius,2*Radius,HoleDepth+2]);
        translate([-Radius-.01,-Radius-.01,-1])
            cube([2*Radius,Radius,HoleDepth+2]);
    }
}