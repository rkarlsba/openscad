diameter = 105;
length = 150;
thickness = 7;
angle = 4;


difference()
{
    rotate_extrude(angle = 90+angle, convexity = 100, $fa = 1)
    {
        translate([length/2,0,0])
        union()
        {

            {
                translate([length/2,0,0])
                circle($fa = 1, d = diameter);
            }
            square(size = [length,diameter], center = true);
        }
    }
    
    {
        translate([thickness,thickness,0])
        rotate_extrude(angle = 90+angle, convexity = 2, $fa = 1)
        {
            translate([length/2,0,0])
            union()
            {

                {
                    translate([length/2,0,0])
                    circle($fa = 1, d = diameter-thickness);
                }
                square(size = [length,diameter-thickness], center = true);
            }
        } 
    }
}

module screwear()
{
    union()
    {
        cube( [thickness*2,thickness*1.5,thickness/2], center = true );
        translate([0,thickness/1.5])
        {
            cylinder($fa = 1, r = thickness, h = thickness/2, center = true);
        }
    }
}