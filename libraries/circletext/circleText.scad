//circleText.scad (Ver.1.0) by Snaxxus 3/12/2019
//(GNU - GPL) then libraries are their own

//Indispensable libraries:

//by Alexander Pruss (https://www.thingiverse.com/arpruss/about)
// https://www.thingiverse.com/thing:3004457
//(Attribution 3.0 Unported (CC BY 3.0) )
use <fontmetrics.scad>;

//by Carl Davidson (https://www.thingiverse.com/16807/about)
//https://www.thingiverse.com/thing:526023
//(GNU - GPL)
use <string.scad>;



MySnappyString="I thought what I'd do was, I'd pretend I was one of those deaf-mutes";
Radius=55;
fontsize=6.;
Gap=1;
Tilt=45;//degrees
font=str("Comic Sans MS:style=Normal");
Thickness=3;
VFlipChars=false;
ForceFixedSpacing=3;

//Usage example
CircleText(
MySnappyString=MySnappyString,
Radius=Radius,
fontsize=fontsize,
Gap=Gap,
Tilt=Tilt,
font=font,
Thickness=Thickness,
VFlipChars=VFlipChars,
ForceFixedSpacing=ForceFixedSpacing
);


//Use This Module
module CircleText(
MySnappyString="Snappy Cat Dog Food",
Radius=75/2,
fontsize=6.,
Gap=1,
Tilt=45,
font=str("Comic Sans MS:style=Normal"),
Thickness=3,
VFlipChars=false,
ForceFixedSpacing=0
){   

    for(i = [0:len(MySnappyString)-1]){
        
        if (i==0){
        // echo("i==0");
            RotoText(
                Tilt=Tilt,
                ArcLenBefore=0,
                Character=MySnappyString[i],
                font=font,
                fontsize=fontsize,
                Thickness=Thickness,
                Radius=Radius,
                Gap=Gap,
                i=i,
                VFlipChars=VFlipChars,
                ForceFixedSpacing=ForceFixedSpacing
            );   
        }else if(i==1){
            // echo("i==1");
            length0 = ForceFixedSpacing==0 ? 
                measureText(
                  MySnappyString[0],
                  font=font,
                  size=fontsize):ForceFixedSpacing;
                // echo(length0);
            RotoText(
                Tilt=Tilt,
                ArcLenBefore=length0,
                Character=MySnappyString[1],
                font=font,
                fontsize=fontsize,
                Thickness=Thickness,
                Radius=Radius,
                Gap=Gap,
                i=i,
                VFlipChars=VFlipChars,
                ForceFixedSpacing=ForceFixedSpacing
            );   
        }else{
            // echo("i==",i);
            garbagestring=substr(MySnappyString,0, i);
            //echo(garbagestring);
            length0 = ForceFixedSpacing==0 ?
                measureText(
                    garbagestring,
                    font=font,
                    size=fontsize):i*ForceFixedSpacing;
            //echo(Tilt);
            RotoText(
                Tilt=Tilt,
                ArcLenBefore=length0,
                Character=MySnappyString[i],
                font=font,
                fontsize=fontsize,
                Thickness=Thickness,
                Radius=Radius,
                Gap=Gap,
                i=i,
                VFlipChars=VFlipChars,
                ForceFixedSpacing=ForceFixedSpacing
            );
        }
    }
}


module RotoText( 
    Tilt,
    ArcLenBefore,
    Character,
    font,
    fontsize,
    Thickness,
    Radius,
    Gap,
    i,
    VFlipChars,
    ForceFixedSpacing
){
    sizes= ForceFixedSpacing==0 ? measureText(Character,font=font,size=fontsize):ForceFixedSpacing;
   // sizes = measureText(Character,font=font,size=fontsize);
   // echo(ArcLenBefore);
   // echo("Gap",Gap);
   // echo(Character);
   // echo(sizes);
    
    //S = r θ
    //θ = S / R
    S=VFlipChars==false?ArcLenBefore+i*Gap:-ArcLenBefore-i*Gap;
    Th=S/Radius;
    rt=VFlipChars==false?0:-180;
    rotate([0,0,180*Th/PI]){
        translate([0,-Radius,0]){
            rotate([Tilt,0,0]){
                rotate([0,0,rt])linear_extrude(height = Thickness){
                    text(Character,size=fontsize,font=font,halign="center");
                }
            }
        }
    }
}

//circleText.scad by Snaxxus 3/12/2019
//(GNU - GPL) then libraries are their own
