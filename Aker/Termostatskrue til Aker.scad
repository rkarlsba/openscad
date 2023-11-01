// Termostatskrue

use <gears.scad>
use <ymse.scad>


stor_d=25.5;
stor_r=stor_d/2;
stor_o=stor_d*pi();
ticks=72;
tick_spacing=360/ticks;
tick_height = 0.7;

h_stor = 5.0;
h_stor_glatt=2.2;
h_stor_rifler=h_stor-h_stor_glatt;

echo (str("Ticks is ", ticks, ", tick spacing is ", tick_spacing));
//polygon([for(i=[0:tick_spacing:360])[cos(i),sin(i)]*(i%2?stor_r:stor_r-tick_height)]);

cylinder(10,r=3,$fn=4);