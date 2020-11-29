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
 * General Purpose Handle Dual Point v1.0 (4 November 2020)
 */


/* [Screws] */

// Distance between the screws
Screw_Distance = 100; // [50:1:300]

// Screw hole diameter
Screw_Hole_Diameter = 5; // [2:0.5:10]

// Screw head hole diameter
Screw_Head_Hole_Diameter = 8.5; // [2:0.5:15]

// Material thickness (between screw head and base)
Screw_Material_Thickness = 5; // [2:0.5:15]

// Screw countersink angle (82 and 90 are common)
Screw_Countersink_Angle = 90; // [1:0.5:180]


/* [Handle] */

// Thickness of handle (X and Y axis)
Handle_Material_Thickness = 10; // [10:0.5:50]

// Height of handle (Z axis)
Handle_Height = 18; // [10:0.5:50]

// Handle end length (in addition to Handle_Material_Thickness)
Handle_End_Length = 17.5; // [0:0.5:100]


/* [Hand Hole] */

// Width of hand hole (X axis)
Hand_Hole_Width = 65; // [50:0.5:150]

// Depth of hand hole (Y axis)
Hand_Hole_Depth = 20; // [10:0.5:50]


/* [Bevel] */

// Radius of bevel
Bevel_Radius = 1.5; // [0:0.5:5]

// Should bevel be rounded?
Bevel_Rounded = false;


module handle() {
  $fn = 100;

  dimensionsX = ((Hand_Hole_Width / 2) + Handle_Material_Thickness + Handle_End_Length) * 2;
  dimensionsY = Hand_Hole_Depth + Handle_Material_Thickness;
  dimensionsZ = Handle_Height;

  echo(str("Dimensions: X: ", dimensionsX, "mm, Y: ", dimensionsY, "mm Z: ", dimensionsZ, "mm"));

  rotate([90, 0, 0]) {
    handleHalf();
    mirror([1, 0, 0]) {
      handleHalf();
    }
  }

  module handleHalf() {
    difference() {
      // handle240
      hull() {
        // upright profile
        mirror([1, 0, -1]) {
          linear_extrude(height = 1, convexity = 10) {
            handleProfile(0);
          }
        }

        // handle end
        translate([(Hand_Hole_Width) / 2, 0, 0]) {
          intersection() {
            cube([Handle_End_Length + Handle_Material_Thickness, Handle_Height, Hand_Hole_Depth + Handle_Material_Thickness]);

            hull() {
              // bottom profile
              mirror([0, 0, 1]) {
                linear_extrude(height = 1, convexity = 10) {
                  handleProfile(Hand_Hole_Depth - Handle_End_Length);
                }
              }

              translate([0, 0, Hand_Hole_Depth]) {
                intersection() {
                  cube([Handle_Material_Thickness, Handle_Height, Handle_Material_Thickness]);

                  rotate([-90, 0, 0]) {
                    rotate_extrude(convexity=10) {
                      handleProfile(Hand_Hole_Depth);
                    }
                  }
                }
              }
            }
          }
        }
      }
      
      // handle hole
      union() {
        r = min(Handle_Material_Thickness / 2, Hand_Hole_Depth, Hand_Hole_Width / 2);

        handHoleCorner(r);

        translate([0, 0, -0.5]) {
          linear_extrude(height = Hand_Hole_Depth - r + 0.5, convexity = 10) {
            projection() {
              handHoleCorner(r);
            }
          }
        }

        translate([(Hand_Hole_Width / 2) - r, 0, Hand_Hole_Depth - r]) {
          rotate([0, -90, 0]) {
            translate([-((Hand_Hole_Width / 2) - r), 0, 0]) {
              linear_extrude(height = (Hand_Hole_Width / 2) - r  + 0.5, convexity = 10) {
                projection() {
                  handHoleCorner(r);
                }
              }
            }
          }
        }

        translate([-0.5, -0.5, -0.5]) {
          cube([(Hand_Hole_Width / 2) - r  + 0.5, Handle_Height + 1, Hand_Hole_Depth - r + 0.5]);
        }
      }

      // screw hole
      translate([Screw_Distance / 2, Handle_Height / 2, 0]) {
        screwHole(Hand_Hole_Depth + Handle_Material_Thickness,
          Screw_Hole_Diameter,
          Screw_Head_Hole_Diameter,
          (Hand_Hole_Depth + Handle_Material_Thickness) - Screw_Material_Thickness,
          0,
          Screw_Countersink_Angle);
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

  module handHoleCorner(r) {
    translate([(Hand_Hole_Width / 2) - r, -0.5, Hand_Hole_Depth - r]) {
      // corner
      rotate([-90, 0, 0]) {
        cylinder(r = r + 0.01, h = Handle_Height + 1);
      }

      // bevel
      translate([0, 0.5, 0]) {
        rotate([90, -90, 180]) {
          innerBevel(r);
        }

        translate([0, Handle_Height, 0]) {
          rotate([90, 0, 0]) {
            innerBevel(r);
          }
        }
      }
    }
  }

  module innerBevel(r) {
    translate([0, 0, -1]) {
      cylinder(r = r + Bevel_Radius, h = 1);
    }

    cylinder(r = r, h = Bevel_Radius);

    rotate_extrude(convexity=10) {
      translate([r, 0, 0]) {
        difference() {
          polygon([
            [0, 0],

            [0, Bevel_Radius],

            [Bevel_Radius, 0],
          ]);

          if (Bevel_Rounded) {
            translate([Bevel_Radius, Bevel_Radius, 0]) {
              intersection() {
                circle(r=Bevel_Radius);

                translate([-Bevel_Radius, -Bevel_Radius, 0]) {
                  square([Bevel_Radius, Bevel_Radius]);
                }
              }
            }
          }
        }
      }
    }
  }

  /**
   * xTrim - Amount to trim from 'flat' end
   */
  module handleProfile(xTrim) {
    translate([0, Handle_Height / 2, 0]) {
      handleHalfProfile(xTrim);
      mirror([0, 1, 0]) {
        handleHalfProfile(xTrim);
      }
    }
  }

  module handleHalfProfile(xTrim) {
    xLen = Hand_Hole_Depth + Handle_Material_Thickness;

    polygon([
      [0, 0],

      [0, Handle_Height / 2],

      [xLen - xTrim - Bevel_Radius, Handle_Height / 2],
      [xLen - xTrim, (Handle_Height / 2) - Bevel_Radius],
      
      [xLen - xTrim, 0],
    ]);

    translate([xLen - xTrim - Bevel_Radius, (Handle_Height / 2) - Bevel_Radius, 0]) {
      if (Bevel_Rounded) {
        intersection() {
          square([Bevel_Radius, Bevel_Radius]);
          circle(r = Bevel_Radius);
        }
      }
    }
  }
}

handle();
