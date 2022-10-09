//$fn=47;
$fn=32;

round_d=1;

center_hole_d=12.2;
center_t=5 + .01;
center_d=25;


main_plate_t=7 + .01;
main_plate_d=40;

screw_hole_d=3.5;

arm_start_x = 18;
arm_size_x = 10.1;
arm_size_y = 40;
arm_hole_elev = 3.5;
arm_hole_d = 3.4;
arm_hole_x = 23.05;

fan_mount_plate_t = 5;
fan_duct_len = 40;
fan_outer_d = 40;
fan_wall_t = 1.5;
fan_inner_d = fan_outer_d-2*fan_wall_t;
fan_offset_y = 50;
fan_offset_z = -10;
fan_rotation = 45;
fan_screw_hole_d = 4.3;

fan_outlet_w = 20;
fan_outlet_h = 10;

// adjusted for safeties
hotend_fan_duct_e3d_h = 28;
hotend_fan_duct_e3d_w = 22 + .5;
hotend_fan_duct_wall_t = 1.5;
hotend_fan_duct_mount_y = -50;
hotend_fan_duct_mount_z = -hotend_fan_duct_e3d_h/2;

hotend_fan_mount_zshift = -4;


probe_holder_w = 20;
probe_holder_offset = 30;
probe_holder_z = -20;
probe_d = 12.5;

// shamefully stolen
module copy_mirror(vec=[0,1,0])
{
    children();
    mirror(vec) children();
} 

module effector_arm() {
    difference() {
        translate([arm_start_x,-arm_size_y/2,0])
            rotate([90,0,90])
            linear_extrude(arm_size_x)
            translate([round_d, round_d])
            offset(round_d)
            square([arm_size_y-2*round_d, main_plate_t-2*round_d]);
        
        // some cuts here
        // inside 1+2
        copy_mirror([0,1,0])
            translate([13.1, 15, 0])
            rotate([0,0,-22.5])
            cube([5, 10, main_plate_t]);
        // outside 1
        copy_mirror([0,1,0])
            translate([29.7, 10, 0])
            rotate([0,0,22.5])
            cube([15, 15, main_plate_t]);

        // chamfer edge
        translate([26,-arm_size_y/2,7])
            rotate([0,45,0])
            cube([5,arm_size_y,5]);

    }
}

module effector_arm_cut() {
    // screw hole
    translate([arm_hole_x,arm_size_y/2,arm_hole_elev])
        rotate([90,0,0])
        cylinder(d=arm_hole_d, h=arm_size_y);
    // square nut holders
    copy_mirror([0,1,0])
        translate([arm_hole_x, 11.5, arm_hole_elev])
        nut_cutout();
}

module nut_cutout() {
    // center on all axis
    // allow top down insertion
    
    /* Square nut:
    square_nut_sz = 6.5;
    square_nut_t = 3;

    translate([-square_nut_sz/2,
               -square_nut_t/2,
               -square_nut_sz/2])
    cube([square_nut_sz, square_nut_t, square_nut_sz+2]);
    */
    
    // Hex nut:
    hex_nut_t = 3;
    hex_nut_d = 6.3; // 6 was a little hard to deal with
    // actual nut
    rotate([90,0,0])
        translate([0,0,-hex_nut_t/2])
        cylinder(d=hex_nut_d, h=hex_nut_t, $fn=6);
    // opening
    translate([-hex_nut_d/2, -hex_nut_t/2,0])
    cube([hex_nut_d, hex_nut_t, hex_nut_d/2+2]);
}

module rotate_copy(rotations) {
    for(r = rotations)
        rotate([0,0,r])
        children();
}

module probe_holder() {
    translate([-probe_holder_w/2,
               probe_holder_offset-probe_holder_w/2,
               probe_holder_z])
    linear_extrude(-probe_holder_z)
        translate([round_d, round_d])
        offset(round_d)
        square([probe_holder_w-2*round_d,
                probe_holder_w-2*round_d]);
}
module probe_holder_cut() {
    // main hole
    translate([0,probe_holder_offset,probe_holder_z])
    cylinder(d=probe_d, h=main_plate_t - probe_holder_z);
    
    // nut is 19mm x 3.5mm
    translate([0,probe_holder_offset, probe_holder_z+7])
    cylinder(d=19, h=40, $fn=6);
    
    translate([-probe_holder_w/2, arm_start_x+arm_size_x, probe_holder_z+main_plate_t])
    cube([probe_holder_w,
          probe_holder_w,
          -probe_holder_z]);
}

module fan_duct(outlet_w = 10, outlet_h = 5) {
    outlet_outer_w = outlet_w + 2*fan_wall_t;
    outlet_outer_h = outlet_h + 2*fan_wall_t;
    
    round_d = 3;
    
    hull() {
        cylinder(d=fan_outer_d, h=1);
        translate([-outlet_outer_w/2,-outlet_outer_h/2,fan_duct_len-1])
            linear_extrude(1)
            rounded_square([outlet_outer_w, outlet_outer_h]);
    }
    translate([-20+round_d,
               -20+round_d,
               0])
        linear_extrude(fan_mount_plate_t)
        offset(round_d)
        square([40-2*round_d,40-2*round_d]);
}

module fan_duct_cut(outlet_w = 10, outlet_h = 5) {

    hull() {
        cylinder(d=fan_inner_d, h=1);
        translate([-outlet_w/2,-outlet_h/2,fan_duct_len-1])
            linear_extrude(1)
            rounded_square([outlet_w, outlet_h]);
    }
    
    //cylinder(d=37, h=fan_mount_plate_t);
    
    // screws
    translate([16,16,0])
        cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+5);
    translate([16,-16,0])
        cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+5);
    translate([-16,16,0])
        cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+5);
    translate([-16,-16,0])
        cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+5);

}

module rounded_square(dim, radi=round_d) {
    translate([radi, radi])
        offset(radi)
        square([dim[0] - 2*radi, dim[1] - 2*radi]);
}

module hotend_fan_duct() {
    round_d = 3;
    
    block_x = 25;
    block_y = 21;
    block_z = 4;
    translate([-block_x/2,-block_y,-block_z])
        cube([block_x,block_y,block_z]);
    rotate([-90,0,0]) {
        hull() {
            translate([0,
                        -hotend_fan_duct_mount_z-hotend_fan_mount_zshift,
                        hotend_fan_duct_mount_y])
                rotate([-fan_rotation,0,0])
                cylinder(d=fan_outer_d, h=fan_mount_plate_t);
            // Middle of the e3d
            translate([-hotend_fan_duct_e3d_w/2-hotend_fan_duct_wall_t,
                       -hotend_fan_duct_wall_t,-1])
                cube([hotend_fan_duct_e3d_w+2*hotend_fan_duct_wall_t,
                    hotend_fan_duct_e3d_h+2*hotend_fan_duct_wall_t,1]);
        }
        translate([0,
                -hotend_fan_duct_mount_z-hotend_fan_mount_zshift,
                hotend_fan_duct_mount_y])
            rotate([-fan_rotation,0,0])
            translate([round_d-20,round_d-20,])
            linear_extrude(fan_mount_plate_t)
            offset(round_d)
            square([40-2*round_d,40-2*round_d]);
    }

}
module hotend_fan_duct_cut() {
    rotate([-90,0,0]) {
        hull() {
            translate([ 0,
                        -hotend_fan_duct_mount_z-hotend_fan_mount_zshift,
                        hotend_fan_duct_mount_y])
                rotate([-fan_rotation,0,0])
                translate([0,0,-.1])
                cylinder(d=fan_inner_d, h=fan_mount_plate_t+.1);

            // Middle of the e3d
            translate([-hotend_fan_duct_e3d_w/2,0,-1])
                cube([hotend_fan_duct_e3d_w,
                    hotend_fan_duct_e3d_h,1]);
            
        }
        // the heatsink itself, but add 10mm downwards
        rotate([-90,0,0])
            cylinder(d=hotend_fan_duct_e3d_w, h=hotend_fan_duct_e3d_h+10);
    
        // screws
        translate([0,
                    -hotend_fan_duct_mount_z-hotend_fan_mount_zshift,
                    hotend_fan_duct_mount_y])
            rotate([-fan_rotation,0,0])
            translate([0,0,-.1]){
                
            translate([16,16,0])
                cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+.2);
            translate([16,-16,0])
                cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+.2);
            translate([-16,16,0])
                cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+.2);
            translate([-16,-16,0])
                cylinder(d=fan_screw_hole_d, h=fan_mount_plate_t+.2);
        }
    }
}

module effector() {
    difference() {
        union() {
            // main plate
            //cylinder(h=main_plate_t, d=main_plate_d);
            
            // sides
            rotate_copy([30, 150, 270])
                translate([0,-8.75,0])
                cube([21.2,17.5,main_plate_t]);

            // mains
            rotate_copy([0,120,240])
                translate([-14,0,0])
                cube([28,18,main_plate_t]);
 
            rotate_copy([90,210,330])
                effector_arm();
            
            probe_holder();
            
            rotate_copy([120,240])
                translate([0,fan_offset_y,fan_offset_z]) {
                    rotate([180-fan_rotation,0,0])
                        fan_duct(fan_outlet_w, fan_outlet_h);
                    translate([-15,-25.8,11.2])
                    rotate([-16,0,0])
                    cube([30,10.4,6]);
                }
            hotend_fan_duct();
        }
        union() {
            hotend_fan_duct_cut();
            rotate_copy([120,240])
                translate([0,fan_offset_y,fan_offset_z])
                rotate([180-fan_rotation,0,0])
                fan_duct_cut(fan_outlet_w, fan_outlet_h);


            probe_holder_cut();

            rotate_copy([90,210,330])
                effector_arm_cut();
            
            rotate_copy([90,210,330]) {
                translate([17.165,0,0]) {
                    cylinder(d=screw_hole_d, h=main_plate_t);
                    translate([0,0,-main_plate_t])
                    cylinder(d=6, h=main_plate_t);
                }
            }

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


module preview_examples() {
    // heatsink
    color("blue")
        translate([0,0,-28])
        cylinder(d=22, h=28);
    // break
    color("gray")
        translate([0,0,-31])
        cylinder(d=5, h=3);
    // block
    color("gray")
        translate([-6,-6,-42])
        cube([12,20,11]);
    // nozzle
    color("gray")
        translate([0,0,-42-5])
        cylinder(d2=9, d1=0.4, h=5);

}

if($preview)
    preview_examples();
effector();

/*
difference() {
    fan_duct(10, 5);
    fan_duct_cut(10, 5);
}*/

/*difference() {
    hotend_fan_duct();
    hotend_fan_duct_cut();
}*/