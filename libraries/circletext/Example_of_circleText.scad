//circleText library example

use <circleText.scad>;

MySnappyString="I thought what I'd do was, I'd pretend I was one of those deaf-mutes";
Radius=55;
fontsize=6.;
Gap=1;
Tilt=45.;//degrees
font=str("Comic Sans MS:style=Normal");
Thickness=6;


//Usage example
CircleText(MySnappyString=MySnappyString,
Radius=Radius,
fontsize=fontsize,
Gap=Gap,
Tilt=Tilt,
font=font,
Thickness=Thickness);