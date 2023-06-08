//Parametric Chain Mail V2
// - Allows rings to be flattened at the bottom for better printability
// - Better suited for OpenSCAD customizer
//
// by Bike Cyclist
// https://www.printables.com/social/114295-bike-cyclist
// https://www.thingiverse.com/bikecyclist
//
// Remix of
// https://www.printables.com/model/53234-parametric-chain-mail
// https://www.thingiverse.com/thing:2825924
// by Bike Cyclist

// Number of facets per 360 degrees (number)
$fn = 32;

//Relation of ring outer diameter to wire thickness (ratio)
ring_dia_to_th = 7;

//Wire thickness (mm)
th_wire = 2;

// How much of the wire is cut away to give a flat lower surface for easier printing (mm)
cut_flat = 0.5;

//Number of rings per row in X direction (number)
nx = 10;

//Number of rings per row in Y direction (number)
ny = 20;

//Separation of rings in X direction (mm)
d_min = 1;

//Angle of rings to XY plane (degrees)
a = 40;

//Coefficient for separation of rings in Y direction (ratio)
c_dy = 0.69;

//Derived Parameters
dia_ring_o = th_wire * ring_dia_to_th;
dia_ring = dia_ring_o - th_wire;

dx = dia_ring_o + d_min;
dy = c_dy * 2 * (th_wire + d_min * cos (a));

echo (dia_ring_o);

//Create sheet of mail
color ("grey")
    translate ([-d_min/2, th_wire/2 + dia_ring * cos (a)/2 - dy, (th_wire + dia_ring * sin (a))/2])
        for (i = [0:nx - 1])
            translate ([i * dx, 0, 0])
                for (j = [1:ny])
                    translate ([(j%2 + 1) * dx/2, j * dy, 0])
                        difference ()
                        {
                            
                            rotate ([(j%2 - 1) * (2 * a) + a, 0, 0])
                                rotate_extrude ()
                                    translate ([dia_ring/2, 0, 0])
                                        circle (th_wire/2);
                            
                            translate ([0, 0, -dia_ring_o/2 - dia_ring/2 * sin(a) - th_wire/2 + cut_flat])
                                cube ([dia_ring_o, dia_ring_o, dia_ring_o], center = true);
                        }