diameter = 110;
length = 150;
height = 150;
thickness = 7;
angle = 4;
width = 20;

module strut()
{
    translate([0,0,-height])
    rotate([0,-45,0])
    {
        cube([sqrt(length*length + height*height), thickness, thickness]);
    }
};

union()
{
    translate([length,0,0])
    {
        difference()
        {
            cylinder($fa = 1, d = diameter, h = thickness);
            translate([0,0,-1])
            {
                cylinder($fa = 1, d = diameter-(2*width), h = thickness+2);
            }
        }
    };


    translate([0,-diameter/2,0])
    {
        difference()
        {
            cube([length, diameter, thickness]);
            translate([thickness,thickness,-1])
            {
                cube([length - thickness + 2, diameter - 2*thickness, thickness + 2]);
            }
        }
    };

    translate([thickness,-diameter/2,0])
    {
        strut();
    };

    translate([thickness,diameter/2-thickness,0])
    {
        strut();
    };

    translate([0, -diameter/2, -height])
    {
        cube([thickness,diameter,height]);
    };

}