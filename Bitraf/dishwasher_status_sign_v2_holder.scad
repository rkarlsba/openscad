/* 2022-05-12 holder for dishwasher status sign v2 */
/* by Torfinn Ingolfsen */

// History:
// 2022-05-12 initial version
//
// fasten with double sided tape on the front of the dishwasher
// so that the top side is clearly visible
//
sign_length = 100; // the gadget is going to be 110 mm wide
sign_height = 20; // and 20 mm high
side_thickness = 2;

module endpiece()
{
    side_size = sign_height / 2 + side_thickness;
    echo(side_size = side_size);
    t_height = (sqrt(3) / 2) * side_size;
    echo(t_height = t_height);
    linear_extrude(height = side_thickness, center = false, twist = 0, convexity = 10) polygon(points = [[0,0], [side_size, 0], [side_size / 2, t_height], [0,0]]);
}

//color("red") translate([0,0, sign_length + side_thickness]) endpiece();
color("red") translate([0,0, sign_length]) endpiece();
// width, depth, height
//   x  ,   y  ,  z
cube([sign_height, side_thickness, sign_length + side_thickness]);
translate([side_thickness / 2, 0, 0]) {
    rotate([0,0,60]) {
        cube([sign_height, side_thickness, sign_length + side_thickness]);
    }
}

color("blue") endpiece();
