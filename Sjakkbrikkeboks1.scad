// Settings
wall=1.5;
lid_top=wall*4;
bleed=.2;

box_x=75;
box_y=box_x;
box_z=box_x/2.5;

// What to print
print_box = 0;
print_lid = 1;

// internal s tuff
outer_x=box_x*2+wall*3;
outer_y=box_y+wall*2;
outer_z=box_z+wall;

echo("outer_x is ", outer_x, "and outer_y is ", outer_y, "and outer_z is ", outer_z);
echo("(outer_x + wall * 4) is ", (outer_x + wall * 4));
echo("Lid size, outer_x+wall*2+bleed*2 = ", outer_x+wall*2+bleed*2, 
  "outer_y+wall*2+bleed*2 = ", outer_y+wall*2+bleed*2);

if (print_box) {
    difference() {
        cube([outer_x,outer_y,outer_z]);
        translate([wall,wall,wall]) {
            cube([box_x,box_y,box_z+wall]);
        }
        translate([box_x+wall*2,wall,wall]) {
            cube([box_x,box_y,box_z+wall]);
        }
    }
}

if (print_lid) {
    translate([0, (outer_y + wall * 4),0]) {
        difference() {
            cube([outer_x+wall*2+bleed*2,outer_y+wall*2+bleed*2,lid_top]);
//            cube([outer_x+wall*2,outer_y+wall*2,lid_top]);
            translate([wall,wall,wall]) {
                cube([outer_x+bleed*2,outer_y+bleed*2,lid_top]);
            }
        }
    }
}
