/* 2022-05-12 dishwasher status sign v2 */
/* by Torfinn Ingolfsen */

// History:
// 2022-05-12 initial version

// using a permanet marker, write on each side (in order)
// dirty
// running
// clean
//
// put sign in holder
//
sign_length = 100; // the gadget is going to be 100 mm wide
sign_height = 20; // and 20 mm high
side_thickness = 2;

// cribbed from a forum post
/*
isogonal.scad

        +
       /|\
      /o| \
   r /  |y \
    /   |   \
   +----+----+
   |  x      |
   |<-- l -->|
*/

module isogonal(length, number)
{
    angle = 360 / number;
    theta = angle / 2;
    x = length / 2;
    r = x / sin(theta);
    y = r * cos(theta);

    // hull() is better than for() and scale() method.
    hull()
    {
        for (i = [0 : number-1])
        {
                rotate([0, 0, angle*i]) translate([0, -y, 0])
                square([length, 1], center=true);
        }
    }
}

module d_sign(length, height, thickness)
{
    linear_extrude(height = length, center = false, twist = 0, convexity = 10)
    difference()
    {
        isogonal(height, 3);
        isogonal(height - thickness, 3);
    }
}

d_sign(sign_length, sign_height, side_thickness);