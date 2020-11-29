/*
 * Copyright 2020 Code and Make (codeandmake.com)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*
 * Fully Customizable General Purpose Handles by Code and Make (https://codeandmake.com/)
 *
 * https://www.thingiverse.com/thing:4643658
 *
 * General Purpose Handle Single Point v1.0 (4 November 2020)
 */


/* [Screws] */

// Screw hole diameter
Screw_Hole_Diameter = 5; // [2:0.5:10]

// Screw head hole diameter
Screw_Head_Hole_Diameter = 8.5; // [2:0.5:15]

// Material thickness (between screw head and base)
Screw_Material_Thickness = 5; // [2:0.5:15]

// Screw countersink angle (82 and 90 are common)
Screw_Countersink_Angle = 90; // [1:0.5:180]


/* [Stem] */

// Thickness of stem (X and Y axis)
Stem_Material_Thickness = 5.75; // [3:0.25:20]

// Height of stem (Z axis)
Stem_Height = 10; // [5:0.5:50]


/* [Handle] */

// Width of grip (X and Y axis)
Handle_Grip_Width = 8; // [5:0.5:80]

// Height of handle (Z axis)
Handle_Height = 10; // [10:0.5:80]

// Should the handle be square?
Square_Handle = false;


/* [Base] */

// Should a base be added?
Base_Enabled = false;

// Width of base lip (X and Y axis)
Base_Lip_Width = 8;// [5:0.5:80]

// Height of base lip (Z axis)
Base_Lip_Height = 10;// [5:0.5:80]


/* [Bevel] */

// Radius of bevel
Bevel_Radius = 1.5; // [0:0.5:5]

// Should bevel be rounded?
Bevel_Rounded = false;


module handle() {
  $fn = 100;

  stemRadius = (max(Screw_Hole_Diameter, Screw_Head_Hole_Diameter) / 2) + Stem_Material_Thickness;

  dimensionsX = max((stemRadius + Handle_Grip_Width) * 2, (stemRadius + Base_Lip_Width) * 2);
  dimensionsY = max((stemRadius + Handle_Grip_Width) * 2, (stemRadius + Base_Lip_Width) * 2);
  dimensionsZ = (Base_Enabled ? Base_Lip_Height : 0) + Stem_Height + Handle_Grip_Width + Handle_Height;

  echo(str("Dimensions: X: ", dimensionsX, "mm, Y: ", dimensionsY, "mm Z: ", dimensionsZ, "mm"));

  difference() {
    if (Square_Handle) {
      intersection() {
        squareHandleSingleExtrude();

        rotate([0, 0, 90]) {
          squareHandleSingleExtrude();
        }
      }
    } else {
      rotate_extrude(convexity=10) {
        profile();
      }
    }

    screwHole(Base_Lip_Height + Stem_Height + Handle_Grip_Width + Handle_Height,
      Screw_Hole_Diameter,
      Screw_Head_Hole_Diameter,
      (Base_Lip_Height + Stem_Height + Handle_Grip_Width + Handle_Height) - Screw_Material_Thickness,
      0,
      Screw_Countersink_Angle);
  }

  module profile() {
    difference() {
      union() {
        if(Base_Enabled) {
          polygon(points=[
            // inner bottom corner
            [0,0],

            // inner top corner
            [0, Base_Lip_Height + Stem_Height + Handle_Grip_Width + Handle_Height],

            // outer handle top corner
            [stemRadius + Handle_Grip_Width - Bevel_Radius, Base_Lip_Height + Stem_Height + Handle_Grip_Width + Handle_Height],
            [stemRadius + Handle_Grip_Width, Base_Lip_Height + Stem_Height + Handle_Grip_Width + Handle_Height - Bevel_Radius],

            // outer handle bottom corner
            [stemRadius + Handle_Grip_Width, Base_Lip_Height + Stem_Height + Handle_Grip_Width],

            // outer top stem corner
            [stemRadius, Base_Lip_Height + Stem_Height],

            // outer bottom stem corner
            [stemRadius, Base_Lip_Height + min(Base_Lip_Width - Bevel_Radius, Bevel_Radius)],
            [stemRadius + min(Base_Lip_Width - Bevel_Radius, Bevel_Radius), Base_Lip_Height],

            // outer top base corner
            [(stemRadius + Base_Lip_Width) - Bevel_Radius, Base_Lip_Height],
            [(stemRadius + Base_Lip_Width), Base_Lip_Height - Bevel_Radius],

            // outer bottom base corner
            [stemRadius + Base_Lip_Width, 0]
            ]);
        } else {
          polygon(points=[
            // inner bottom corner
            [0, 0],

            // inner top corner
            [0, Stem_Height + Handle_Grip_Width + Handle_Height],

            // outer handle top corner
            [stemRadius + Handle_Grip_Width - Bevel_Radius, Stem_Height + Handle_Grip_Width + Handle_Height],
            [stemRadius + Handle_Grip_Width, Stem_Height + Handle_Grip_Width + Handle_Height - Bevel_Radius],

            // outer handle bottom corner
            [stemRadius + Handle_Grip_Width, Stem_Height + Handle_Grip_Width],

            // outer top stem corner
            [stemRadius, Stem_Height],

            // // outer bottom stem corner
            [stemRadius, 0]
            ]);
        }

        if (Bevel_Rounded) {
          // outer handle top corner
          translate([stemRadius + Handle_Grip_Width - Bevel_Radius, (Base_Enabled ? Base_Lip_Height : 0) + Stem_Height + Handle_Grip_Width + Handle_Height - Bevel_Radius, 0]) {
            circle(r = Bevel_Radius);
          }

          if(Base_Enabled) {
            // outer top base corner
            translate([(stemRadius + Base_Lip_Width) - Bevel_Radius, Base_Lip_Height - Bevel_Radius, 0]) {
              intersection() {
                circle(r = Bevel_Radius);
                square(size=[Bevel_Radius, Bevel_Radius]);
              }
            }
          }
        }
      }

      if (Base_Enabled && Bevel_Rounded) {
        translate([stemRadius + min(Base_Lip_Width - Bevel_Radius, Bevel_Radius), Base_Lip_Height + min(Base_Lip_Width - Bevel_Radius, Bevel_Radius), 0]) {
          circle(r = min(Base_Lip_Width - Bevel_Radius, Bevel_Radius));
        }
      }
    }
  }

  module squareHandleSingleExtrude() {
    rotate([90, 0, 0]) {
      linear_extrude(height = max((stemRadius + Handle_Grip_Width) * 2, (stemRadius + Base_Lip_Width) * 2), convexity = 10, center = true) {
        profile();
        mirror([1, 0, 0]) {
          profile();
        }
      }
    }
  }

  module screwHole(holeDepth, holeDiameter, headDiameter, boreDepth, aboveHoleBoreDepth, sinkAngle) {
    boreDiameter = (holeDiameter > 0 ? max(holeDiameter, headDiameter) : 0);
    countersinkAdjacent = (boreDiameter / 2) / tan(sinkAngle / 2);

    translate([0, 0, -0.001]) {
      // screw hole
      cylinder(holeDepth + 0.002, holeDiameter / 2, holeDiameter / 2, false);

      // countersink
      if (sinkAngle > 0) {
        translate([0, 0, holeDepth - countersinkAdjacent - boreDepth]) {
          cylinder(countersinkAdjacent + 0.002, 0, (boreDiameter / 2), false);
        }

        // above hole and bore
        translate([0, 0, holeDepth - boreDepth]) {
          cylinder(boreDepth + aboveHoleBoreDepth + 0.002, boreDiameter / 2, boreDiameter / 2, false);
        }
      } else {
        // full bore
        cylinder(holeDepth + aboveHoleBoreDepth + 0.002, boreDiameter / 2, boreDiameter / 2, false);
      }
    }      
  }
}

handle();
