//-------------------------------------------------------------------------------------
// Ear Saver 
//
// This OpenScad file creates an Ear Saver for Masks. I'm hoping this will be useful
// for people who find the multitudes of Ear Savers too uncomfortable to use.
//
// My inspiration for creating this design was that I could not find anything like
// it on the web. I mean there are no OpenScad versions.
//
// Author:  Andre Pruitt
// Date:    4/18/2020
// Version: 2.0
//-------------------------------------------------------------------------------------

use <ymse.scad>

Ministeps=2;

// Over all length in mm
Length = 156-Ministeps*24; // [50:300]

// Width of the band in mm
Width =  10; // [1:13]

// Thickness of body
Thickness = .7;

// Number of hooks per arm
Hook_Count =  4-Ministeps; // [1:10]

// Distance between each hook
Hook_Spacing = 12; // [8:20]

/* [Oval Dimensions] */
// Length of the central oval  in mm. Best if set to Length/2
Oval_Length =  54; // [10:150]

// Height of the central oval in mm. Best if greater than Width * 2
Oval_Height =  25; // [1:100]

// The ratio between the outer part of the oval and the inner hole.
Ratio = .79; // [0.6:0.01:0.87]

// Should the oval have a whole in its middle
Fill = true;

// Handle logo
Logo_image = false;

Logo_font_face = "Apple Chancery";
Logo_font_face = "Caligraf Medium PERSONAL USE:style=Regular";
Logo_font_size = 10;
//Logo_text = "God jul";
//Logo_text = "Ifrah";
Logo_text = false;
// <Bools>

// Flank text with hearts?
Hearts = true;

// Do we have a logo?
draw_logo = (Logo_image != false || Logo_text != false || Hearts != false);

// Logo needs Fill
do_fill = (Fill || draw_logo);

if (Logo_image != false && Logo_text != false) {
    echo("Dette funker nok heller dårlig…");
}
// </Bools>

/* [Arm Rotation] */
// The amount each arm is rotated by in degrees
Rotation =  12; // [0:35]

/* [Render Quality] */
// The quality of the renderings
$fn = $preview ? 8 : 64;

LegLength = Length/2.0 - Oval_Length / 2.0 * Ratio + 2;

//------------------------------------------------------------------------------
// This module will rotate around a point of origin. It does this by first
// moving the origin point, rotating around that point and then moving back
// to where it was before.
//
// The angles parameter is a vector of angles of degrees [X, Y, Z]
// The orig parameter is a position vector [X, Y, Z] of the origin to rotate around
//------------------------------------------------------------------------------
module rotateAround(angles, orig) 
{
    translate(orig)
    rotate(angles)
    translate(-orig)
    children();
}

//-------------------------------------------------------------------------------------
// hook(x,y) - This module draws a single hook. It takes ab x offset and a y offset
//-------------------------------------------------------------------------------------
module hook(aXOffset = 35.3, aYOffset = 0)
{
  translate([aXOffset, aYOffset, 0])
  {
    translate([0,     9.8, 0]) cylinder(d = 5.5, h = Thickness*2);
    translate([0,    -9.8, 0]) cylinder(d = 5.5, h = Thickness*2);
    translate([-0.2, -9.8, 0]) cube([3, 20, Thickness]);
  }
}

module ear_saver() {
    //-------------------------------------------------------------------------------------
    // Draw the center portion of the Ear Saver. The outer dimensions are defined
    // by the Oval_Length and Oval_Height. The innder part of the ponytail hole
    // is Ratio times the size of outer dimensions. You can change this if 
    // you want more or less plastic. 
    //-------------------------------------------------------------------------------------
    difference()
    {
      // Outer oval
      resize([Oval_Length, Oval_Height, Thickness])
        cylinder(d=Oval_Length, h=Thickness);
      
      // Remove the inner oval
      if (do_fill == false)
      {
        translate([0, 0, -0.01]) 
          resize([Oval_Length * Ratio, Oval_Height * 0.625,]) 
            cylinder(d=Oval_Length * Ratio, h= 3);
      }
    }

    //-------------------------------------------------------------------------------------
    // Draw Right Leg and rotate it. The leg consists of the hooks and a 
    // bar that stretches from the Ponytail holder to the last hook.
    //-------------------------------------------------------------------------------------
    rotateAround(Rotation, [Oval_Length / 2.0 * Ratio, 0])
    {
      // Space the hooks along the arm
      for (tIndex = [0: Hook_Count-1])
      {
        hook(Length/2.0 - Hook_Spacing * tIndex);
      }

      // Draw the body of the arm
      translate([ Oval_Length / 2.0 * Ratio, -Width/2, 0]) 
         cube([LegLength, Width, Thickness]);
    }  

    //-------------------------------------------------------------------------------------
    // Draw Left Leg and rotate it. The leg consists of the hooks and a 
    // bar that stretches from the Ponytail holder to the last hook.
    //-------------------------------------------------------------------------------------
    rotateAround(-Rotation, [-Oval_Length / 2.0 * Ratio, 0])
    {
      // Draw the hooks along the arm
      for (tIndex = [0: Hook_Count - 1])
      {
        rotate([0, 0, 180])
          hook(Length/2.0 - Hook_Spacing * tIndex);
      }
      
      // Draw the body of the arm
      translate([-LegLength - Oval_Length / 2.0 * Ratio, -Width/2, 0]) 
        cube([LegLength, Width, Thickness]);  
    }
    
          
    if (draw_logo) {
        xadj = -13;
        yadj = -5;
        if (Logo_image != false) {
        } else if (Logo_text != false) {
            translate([xadj, yadj, Thickness]) {
                if (Hearts) {
                    translate([-Logo_font_size/2,0,0])
                        linear_extrude(Thickness)
                            flat_heart(Logo_font_size);
                }
                linear_extrude(Thickness)
                    text(Logo_text, font=Logo_font_face, size=Logo_font_size);
                if (Hearts) {
                    rightheartfixup=1.5; // just help it out :)
                    translate([-xadj*2+Logo_font_size/2+rightheartfixup,0,0])
                        linear_extrude(Thickness)
                            flat_heart(Logo_font_size);
                }
            }
        } else if (Hearts) {
            for (x = [-15:15:15]) {
            translate([x,-5,Thickness])
                linear_extrude(Thickness)
                    flat_heart(Logo_font_size);
            }
/*            translate([-xadj*2+Logo_font_size/2+rightheartfixup,0,Thickness])
                linear_extrude(Thickness)
                    flat_heart(Logo_font_size);*/
        }
    }
}

ear_saver();
// projection() ear_saver();
