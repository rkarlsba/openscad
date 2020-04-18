depth = 150;
thickness = 3;
up = 50;
down = 150;
diameter = 100;
width = 20;

module strut(dimension, length)
{
    cube([length, dimension, dimension]);
}



strut(thickness,depth);

translate([0,diameter,0])
{
    strut(thickness,depth);
}

// upper struts
translate([0,0,up])
rotate([0,atan2(up,depth),0])
{
    strut(thickness,sqrt(depth*depth+up*up));
}

translate([0,diameter,up])
rotate([0,atan2(up,depth),0])
{
    strut(thickness,sqrt(depth*depth+up*up));
}

// outer struts
translate([0,-up+thickness,0])
rotate([0,0,atan2(up,depth)])
translate([0,-thickness,0])
{
    strut(thickness,sqrt(pow(depth,2)+pow(up,2)));
}

translate([0,diameter+up,0])
rotate([0,0,-atan2(up,depth)])
{
    strut(thickness,sqrt(pow(depth,2)+pow(up,2)));
};


// inner struts
translate([0,thickness,0])
rotate([0,0,atan2(up,depth-diameter/2+thickness)])
translate([0,-thickness,0])
{
    strut(thickness,sqrt(pow(depth-diameter/2+thickness,2)+pow(up,2)));
}

translate([0,diameter-thickness,0])
rotate([0,0,-atan2(up,depth-diameter/2+thickness)])
{
    strut(thickness,sqrt(pow(depth-diameter/2+thickness,2)+pow(up,2)));
};


// lower struts

translate([0,0,-down+thickness])
rotate([0,atan2(-down,depth),0])
translate([0,0,-thickness])
{
    strut(thickness,sqrt(depth*depth+down*down));
}

translate([0,diameter,-down+thickness])
rotate([0,atan2(-down,depth),0])
translate([0,0,-thickness])
{
    strut(thickness,sqrt(depth*depth+down*down));
}



// the ring
translate([depth,diameter/2+thickness/2,0])
{
    difference()
    {
        cylinder($fa = 1, d = diameter+thickness, h = thickness);
        translate([0,0,-1])
        {
            cylinder($fa = 1, d = diameter-(2*width), h = thickness+2);
        }
    }
};


// backstruts
// horizontal
translate([thickness,-diameter/2,0])
rotate([0,0,90])
{
    strut(thickness,diameter + 2*up + thickness);
}

// vertical
translate([0,0,up+thickness])
rotate([0,90,0])
{
    strut(thickness,depth + up + thickness);
}

translate([0,diameter,up+thickness])
rotate([0,90,0])
{
    strut(thickness,depth + up + thickness);
}



/*
// backplate
translate([0,-(up+thickness/2),-(down+thickness/2)])
{
    cube([thickness, diameter + 2*up + 2*thickness, up+down+2*thickness]);
}
*/