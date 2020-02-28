wall_thickness=1.5;


module cup()
{
    difference ()
    {
        cylinder(h = 19, r = 37/2);
        translate([0,0,wall_thickness])
        cylinder(h = 19-wall_thickness+3, r= 37/2-wall_thickness);
    }
}

handle_length = 80;
handle_width = 37;

module handle()
{
cube([handle_length, 37, wall_thickness], center=true); 
translate([handle_length/2, 0,0])
    cylinder(h=wall_thickness, r = handle_width/2,center=true);   
}


cup();
translate([handle_length/2, 0,wall_thickness/2])
      handle();
