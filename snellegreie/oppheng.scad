$fn = $preview ? 20 : 60;

dybde = 105;
bredde = 10;
orig_hoyde_lav = 10;
orig_hoyde_hoy = 25;

hoyde_lav = orig_hoyde_lav-5;
hoyde_hoy = orig_hoyde_hoy;

hylletykkelse = 5;
hyllehoyde_lav = hoyde_lav +7;
hyllehoyde_hoy = hoyde_hoy +7;
hyllepolserad = 4;
hyllepolseforing = [-hyllepolserad/2,1];

veggfestepkt = [
    [0, 0, 0],                                              // 0
    [bredde, 0, 0],                                         // 1
    [bredde, dybde+hylletykkelse, 0],                       // 2
    [0, dybde+hylletykkelse, 0],                            // 3
    [0, hoyde_lav, hoyde_hoy],                              // 4
    [bredde, hoyde_lav, hoyde_hoy],                         // 5
    [bredde, dybde+hylletykkelse, hoyde_lav],               // 6
    [0, dybde+hylletykkelse, hoyde_lav],                    // 7
    [0, dybde+hylletykkelse, hoyde_lav+hylletykkelse],      // 8
    [bredde, dybde+hylletykkelse, hoyde_lav+hylletykkelse], // 9
];

veggfesteplater = [
    [0, 1, 2, 3],
    [4, 5, 1, 0],
    [7, 6, 5, 4],
    [5, 6, 2, 1],
    [6, 7, 3, 2],
    [7, 4, 0, 3],
];

polyhedron( veggfestepkt, veggfesteplater );

// pølsefest
translate([0,hylletykkelse-hyllepolseforing[0],hoyde_hoy+hyllepolseforing[1]]) {
    rotate([0,90,0]) 
    cylinder(h=bredde,d=hyllepolserad);
}

translate([0,dybde+hylletykkelse+hyllepolseforing[0],hoyde_lav+hyllepolseforing[1]]) {
    rotate([0,90,0]) 
    cylinder(h=bredde,d=hyllepolserad);
}

linear_extrude