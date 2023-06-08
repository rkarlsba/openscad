//Parametric Chain Mail
$fn = 32;

//Parameters
ring_dia_to_th = 7;     //Relation of ring outer diameter to wire thickness
th_wire = 2;            //Wire thickness

nx = 10;                 //Number of rings per row in X direction
ny = 20;                //Number of rings per row in Y direction

d_min = 1;              //Separation of rings in X direction
a = 40;                 //Angle of rings to XY plane
c_dy = 0.69;            //Coefficient for separation of rings in Y direction

//Derived Parameters
dia_ring_o = th_wire * ring_dia_to_th;
dia_ring = dia_ring_o - th_wire;

dx = dia_ring_o + d_min;
dy = c_dy * 2 * (th_wire + d_min * cos (a));

//Create sheet of mail
translate ([-d_min/2, th_wire/2 + dia_ring * cos (a)/2 - dy, (th_wire + dia_ring * sin (a))/2])
    for (i = [0:nx - 1])
        translate ([i * dx, 0, 0])
            for (j = [1:ny])
                translate ([(j%2 + 1) * dx/2, j * dy, 0])
                    rotate ([(j%2 - 1) * (2 * a) + a, 0, 0])
                        rotate_extrude ()
                            translate ([dia_ring/2, 0, 0])
                                circle (th_wire/2);