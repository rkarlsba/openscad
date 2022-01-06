$fn = 64;


shell_t = 3;


tx = 93;
ty = 64;

// 6003ZZ x 10
translate([35.5/2+shell_t,ty-35.5/2-shell_t,0])
    rotate(180)
    bearing_cylinder(35,10,10);
    
// 6204Z x 5
translate([tx-47.5/2-shell_t,ty-47.5/2-shell_t,0])
    rotate(180)
    bearing_cylinder(47, 14, 5);

//color("gray")
//    cube([tx,ty,shell_t]);

// 608ZZ x 10
translate([35,22.5/2+shell_t,0])
bearing_cylinder(22, 7, 10);
// MR126-ZZ x 10
translate([13,16,0])
rotate(-45)
bearing_cylinder(12, 4, 10);
// MR85-ZZ x 20
translate([53,8.5/2+shell_t,0])
rotate(45)
bearing_cylinder(8, 2.5, 20);

module bearing_cylinder(b_od, b_h, n) {
    // 0.5mm for a loose fit
    b_od2 = b_od + .5;

    difference() {
        // height: bearings + shell
        // width: bearing + 2 shell widths
        cylinder(h=b_h*n + shell_t,
                d=b_od2+2*shell_t);
        
        // inner space
        translate([0,0,shell_t])
        cylinder(h=b_h*n,
                d=b_od2);
        
        // opening
        translate([-b_od2*.8/2,-b_od2/2-shell_t,shell_t])
        cube([b_od2*.8,
              b_od2/2+shell_t,
              b_h*n]);
    }
}
