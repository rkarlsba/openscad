nozzlesize = 0.4;
linewidth = nozzlesize;
height = nozzlesize;
x = 120;
y = 150;
y_step = 5;

module flat_prusatest() {
    square([x,linewidth]);
    translate([x-linewidth,linewidth])
        square([linewidth,y_step]);

    for (i = [1:2:14]) {
        translate([0,y_step*i]) {
            square([x,linewidth]);
            square([linewidth,y_step]);
        }

        translate([0,y_step*(i+1)]) {
            square([x-linewidth,linewidth]);
            translate([x-linewidth,0])
                square([linewidth,y_step]);
        }
    }
}

linear_extrude(height) flat_prusatest();