// Code written by "Shii" Sep 2016
// Code refubished and tweaked by Roy Sigurd Karlsbakk <roy@karlsbakk.net> September 2023

// Lita presskanne indre diameter: 64
lita_presskanne_id = 64;

// Mellomstor presskanne indre diameter: 82
mellomstor_presskanne_id = 82;

Slack=1.5;

// Inner Top Diameter
// Top_Inside_Diameter=lita_presskanne_id-Slack;
Top_Inside_Diameter=120;

// Total Height
Height=Top_Inside_Diameter;

// Top Ledge Width
Ledge=4;

// Tube Height
Tube_Height=45;

// Tube Outside Diameter
Tube_Outside_Diameter=22;

// Tube Bottom Cut Angle
Tube_Cut_Angle=30;

// Wall Thickness
Wall_Thickness=1;

/* [Hidden] */
// $fn = $preview ? 32 : 128;
$fn = 512;
Top_Height = Height - Tube_Height;
Top_Outside_Diameter = Top_Inside_Diameter + Wall_Thickness*2;
Ledge_Multiplicator = 2.6;

rotate([180,0,0]) translate([0,0,-Height]) {

  // Funnel top ring
  translate ([0,0,Height-Wall_Thickness*2]) difference(){
    cylinder(d = Top_Inside_Diameter+Ledge*2, h = Wall_Thickness*2);
    translate ([0,0,-0.1]) cylinder(d = Top_Inside_Diameter, h = Wall_Thickness*2+0.2);
  }
  
  // Funnel top ring lip
  translate ([(Top_Outside_Diameter+Ledge*3)/2,0,Height-Wall_Thickness*2]) difference(){
    union(){
      translate ([-Ledge*1.5-Wall_Thickness,-Ledge*Ledge_Multiplicator/2,0]) cube([Ledge*1.5+Wall_Thickness,Ledge*Ledge_Multiplicator,Wall_Thickness*2]);
      cylinder(d = Ledge*Ledge_Multiplicator, h = Wall_Thickness*2);
    }
    translate ([0,0,-0.1]) cylinder(d = Ledge*Ledge_Multiplicator-2*Ledge, h = (Wall_Thickness*2)+0.2);
  }

  // Funnel top
  translate ([0,0,Tube_Height]) difference(){
    union(){
      cylinder(d1 = Tube_Outside_Diameter, d2 = Top_Outside_Diameter, h = Top_Height-Wall_Thickness);
      translate ([0,Tube_Outside_Diameter/2,0]) rotate([-atan((Top_Outside_Diameter/2 - Tube_Outside_Diameter/2)/(Top_Height-Wall_Thickness)),0,0]) union(){
        cylinder(d = Wall_Thickness, h = Top_Height-Wall_Thickness);
        translate ([0,0,Top_Height-Wall_Thickness])sphere(d=Wall_Thickness);
      }
    }
    translate ([0,0,+0.1])cylinder(d1 = Tube_Outside_Diameter - Wall_Thickness*2, d2 = Top_Outside_Diameter - Wall_Thickness*2+0.2, h = Top_Height-Wall_Thickness);
    translate ([0,0,-0.1]) cylinder(d = Tube_Outside_Diameter - Wall_Thickness*2, h = 0.3);
  }
  
  // Funnel Tube
  difference(){
    union(){
      cylinder(d = Tube_Outside_Diameter, h = Tube_Height);
      translate ([0,Tube_Outside_Diameter/2,0])cylinder(d = Wall_Thickness, h = Tube_Height);
    }
    translate ([0,0,-0.1]) cylinder(d = Tube_Outside_Diameter - Wall_Thickness*2, h = Tube_Height+0.2);
    translate ([-Tube_Outside_Diameter/2,-Tube_Outside_Diameter/2,0]) rotate([Tube_Cut_Angle,0,0]) mirror([0,0,1]) cube([Tube_Outside_Diameter,Tube_Height*3,Tube_Outside_Diameter]);
  }
}
