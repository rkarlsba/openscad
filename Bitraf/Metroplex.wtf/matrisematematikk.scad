a = [1,2,3];
b = [2,3,4];
c = 2;
h = [c,c,c];
mh = -h;

x = a+b;
y = x+c;


echo(str("\na is ", a, "\nb is ", b, "\nc is ", c, 
         "\nh is ", h, "\nmh is ", mh,
         "\nx is ", x, "\ny is ", y, "\n"));






/*
heatblock_size = [12,20,11];
heatblock_location = [-6,-6,-42];
si_sock_thickness = 2;
si_sock_helper = [si_sock_thickness,si_sock_thickness,si_sock_thickness];
si_sock_size = heatblock_size+si_sock_helper;
si_sock_enabled = 0;





    // heatblock
    color("gray") {
        translate() {
            cube(preview_heatblock_size); 
        }
    }

    // silicone sock for heatblock
    if (si_sock_enabled) {
        color("orange") {
            translate([-6,-6,-42]) {
                difference() {
                    cube([12,20,11]);
                    translate([silicone_sock_thickness, 
                               silicone_sock_thickness, 
                               silicone_sock_thickness]) {
                        difference() {
                            cube([12,20,11]);
                        }
                    }
                }
            }
        }
    }
*/