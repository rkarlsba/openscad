//$fn=47;
$fn=64;

center_hole_d=12.5;
center_t=4;
center_d=28.2;


main_plate_t=6;
main_plate_d=43.6;

screw_hole_d=3.5;

// for each arm:
arm_main_w = 28;
arm_main_d = 10;
arm_small_d = 5;
arm_small_l = 6;
arm_main_elev=3.5;

module weird_part() {
    linear_extrude(arm_main_elev)
    polygon([
        [-arm_main_d/2,  0],
        [ arm_main_d/2,  0],
        [ arm_small_d/2, arm_small_l],
        [-arm_small_d/2, arm_small_l]]);
}

module effector_arm() {
    
    translate([15,-arm_main_w/2,0])
        cube([5,arm_main_w,main_plate_t]);

    translate([23,arm_main_w/2,arm_main_elev])
        rotate([90,0,0])
            cylinder(d=arm_main_d, h=arm_main_w);
    
    translate([18,-arm_main_w/2,0])
        cube([arm_main_d, arm_main_w, arm_main_elev]);
    
    // left
    translate([23,-arm_main_w/2,arm_main_elev])
        rotate([90,0,0])
            cylinder(d1=arm_main_d,
                    d2=arm_small_d,
                    h=arm_small_l);
    translate([23,arm_main_w/2,0])
        weird_part();
    
    // right
    translate([23,arm_main_w/2,arm_main_elev])
        rotate([-90,0,0])
            cylinder(d1=arm_main_d,
                    d2=arm_small_d,
                    h=arm_small_l);
    translate([23,-arm_main_w/2,0])
        rotate([0,0,180])
            weird_part();
    
}

module effector_arm_nut() {
    cube([7,7,2]);
    // cylinder(d=something, h=2, $fn=6);
}

module effector_arm_cut() {
    // Screw hole cutout
    translate([17.165,0,0])
        cylinder(d=screw_hole_d, h=main_plate_t);
    // cut below 0
    translate([18,-20,-arm_main_d])
        cube([arm_main_d, 40, arm_main_d]);

    // screw hole
    translate([23,20,arm_main_elev])
        rotate([90,0,0])
            cylinder(d=3, h=40);
}



module effector() {
    difference() {
        union() {
            // main plate
            cylinder(h=main_plate_t, d=main_plate_d);
            effector_arm();
            rotate([0,0,120])
                effector_arm();
            rotate([0,0,240])
                effector_arm();
        }
        union() {
            effector_arm_cut();
            rotate([0,0,120]) 
                effector_arm_cut();
            rotate([0,0,240]) 
                effector_arm_cut();

            // center hole
            cylinder(h=center_t, d=center_hole_d);

            // center cutout
            translate([0,0,center_t])
                cylinder(h=main_plate_t-center_t,
                         d=center_d);
            
            // upper cutout
            translate([0,0,main_plate_t])
                cylinder(h=main_plate_t, d=main_plate_d);
        }
    }
}
effector();