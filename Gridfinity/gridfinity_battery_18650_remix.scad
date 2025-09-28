include <gridfinity_modules.scad>

Battery_diameter = 18;
Battery_height = 65;

// Space between each cell in the x axis
Battery_spacing_x = 6;
// Space between each cell in the y axis
Battery_spacing_y = 9;

// How far the first battery is from the edge of the holder in the x axis
Battery_offset_x = 6;
// How far the first battery is from the edge of the holder in the y axis
Battery_offset_y = 6;
// How high up the batteries sit in the holder
Battery_offset_z = 6;

// The gap between the battery and the holder in x and y
Battery_clearance = 1.5;

// Number of batteries that can fit in the x axis
Batteries_x = 5;
// Number of batteries that can fit in the y axis
Batteries_y = 3;

// in the format of Gridfinity units
Gridfinity_x = 3;
// in the format of Gridfinity units
Gridfinity_y = 2;
// in the format of Gridfinity units
Gridfinity_z = 4;

// Enable for magnets
Magnet_holes = true;

// Render batteries in the preview, disable when creating STL
Render_batteries = false;


///////

gridfinityBlock(Gridfinity_x, Gridfinity_y, Gridfinity_z, Magnet_holes);

if (Render_batteries) {
    battery_bundle();
}

module gridfinityBlock(x, y, z, holes) {
    difference() {
        grid_block(x, y, z, holes ? 4 : 0);
        batteryGroup(Battery_clearance);  
    }
}

module batteryGroup(batteryGap = 0){
    for (xi = [0:Batteries_x - 1]) {
        for (yi = [0:Batteries_y - 1]) {
            
            xPos = xi * (Battery_diameter + Battery_spacing_x) - Battery_offset_x;
            yPos = yi * (Battery_diameter + Battery_spacing_y) - Battery_offset_y;
            
            translate([xPos,yPos, Battery_offset_z]) 
            color("LightBlue") 
            cylinder(h=Battery_height, d=Battery_diameter + batteryGap, $fn=32);
        }
        
    }  
}
