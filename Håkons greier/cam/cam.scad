// So what's the idea here..

/*
 * The camera has a foot thing that is not detachable. But we can pretend to be a computer screen and clip up.
 * We also want to lock the rotation of the camera, so that means we will slot in the thing that goes downward and push up.
 * Finally zip tie mounts on the sides.
 *
 * New idea: Sleeve that bumps against the tab on the bottom and the camera back on the top. Clip or zip tie around tab, and something clever for the front.
 * 
 *
 * Orientation: The camera is pointing to y+. The lens tends towards positive x.
 * We may center the lens on the x/y axis with the tripod hole thing we will create.
*/

// TODO:
// Screw holes for tripod mount, see the cisco stuff for the appropriate holes. Add .5mm+fudge to holes
// add some things on top for hooking up cables with zipties

GLITCH = 0.1;
$fn = 200;
fudge = (1+1/cos(180/$fn))/2;
 
include <threadlib/threadlib.scad>
include <../hawkenlib/hawkenlib.scad>

camera_x = 67.5;
camera_top_z = 3.5; // space until cable collision
camera_z = 22;

camera_lens_cx = 19;// center x of camera lens

camera_hinge_x = 51;
camera_hinge_y = 6; // 6mm cut for the hinge
camera_hinge_z = 9; // same as support height!

camera_support_x = 40;
camera_back_support_y = 55;
camera_tab_support_y = 50;
camera_support_z = 9 + .5; // +.5 to not destroy the camera while forcing it in.

camera_tab_x = 31;
camera_tab_y = 3; // this is a tight fit
camera_tab_z = 8;


ziptie_width = 4; // mine are 2.5
ziptie_height = 1.5; // mine are 1.1
camera_cable_dia = 3.5 + .5; // 3.5mm cable + .5mm for the printer
cable_support_len = ziptie_width*2;
cable_support_w = camera_cable_dia*2;
cable_support_h = camera_cable_dia/2 + ziptie_height/2;
//cable;

// lenghts


// support variables
support_tabclip_z = 1;
support_backwall_y = 1;
support_sidewall_x = 1;

// calculations
 
support_z = camera_top_z + camera_support_z + camera_tab_z + support_tabclip_z;
support_y = support_backwall_y + camera_back_support_y;
support_x = camera_hinge_x + 2*support_sidewall_x;

support_corners_r = 2;

support_tab_zs = support_tabclip_z;

tab_cutout_y = camera_back_support_y - camera_tab_support_y;

tab_hook_y = tab_cutout_y - camera_tab_y;
tab_hook_z = 1;

// y bottom base thing
bar_t = 3;

bar_len_hook = 50;
// from end of bar we need 100mm to get past the plate (100-bar_t)
// but we need only 30+10 for the hinge
bar_outside_len = 40-bar_t;

bar_to_plate_h = 70;

function hole_dia(x) = (x+0.2)*fudge;

//enderbar(altstyle=true);
//anglearm();
//camera_support(tripod=false, hinge=true);
camera_support_pimount();

module camera_support_pimount() {
    // 10mm long camera holder
    difference() {
        translate([-support_x/2,-12,0])
            camera_shell2d(12);

        // tab cutout
        translate([-camera_tab_x/2,-tab_cutout_y,support_tabclip_z])
            cube([camera_tab_x, tab_cutout_y+GLITCH, camera_tab_z+GLITCH]);
        
        // hinge cutout
        translate([-camera_hinge_x/2, -camera_hinge_y, support_z - camera_top_z - camera_hinge_z])
            cube([camera_hinge_x, camera_hinge_y+GLITCH, camera_hinge_z]);
        
        // support cutout
        translate([-camera_support_x/2,-camera_back_support_y, support_z - camera_top_z - camera_support_z])
            cube([camera_support_x, camera_back_support_y+GLITCH, camera_support_z]);
    }
    // retention tab
    translate([-camera_tab_x/2,0,support_tabclip_z])
        rotate([0,-90,180])
        linear_extrude(camera_tab_x)
        polygon([[0, tab_hook_y],
                [tab_hook_z, tab_hook_y/2],
                [0, 0]]);
    
    
    // Connector plate thing
    
    // There's a 6mm hinge with 3(+.15)mm hole.
    // Over which there is a plate extending 12mm back and 15mm wide
    hinge_w = 5;
    hinge_d = 6;
    hinge_sd = 3.15;
    plate_w = 15;
    plate_d = 12;
    
    angle_h=0;
    angle_v=0;

    // hinge part
    rotate([angle_v,0,0])
        translate([0,-hinge_d/2,-hinge_d/2])
        rotate([0,90,angle_h])
        translate([0,0,-hinge_w/2])
        difference() {
            // 6mm cylinder
            union() {
                cylinder(d=hinge_d, h=hinge_w);
                translate([-hinge_d/2,-hinge_d/2,0])
                cube([hinge_d/2, hinge_d, hinge_w]);
            }
            // 3mm screw (+.15 for clearance)
            translate([0,0,-.05])
                cylinder(d=hinge_sd, h=hinge_w+.1);
        }
        
    // angled plate, 15mm wide
        
    // so that 
    back_plate_mm = plate_d*tan(angle_v);
    
    translate([-plate_w/2,0,0])
        rotate([0,90,0])
        linear_extrude(plate_w)
        polygon([
            // front point
            [0,0],
            // back down point
            [0,-plate_d],
            // back up point
            [back_plate_mm,-plate_d]]);
    
    // connector for the pi mount
}

module anglearm(arm_len=100) {
    translate([hinge_t,hinge_extra+hinge_dia/2,hinge_dia/2])
        rotate([90,0,0])
        hinge_b();
    
    translate([hinge_t-camera_lens_cx,-hinge_extra-hinge_dia/2+arm_len,hinge_dia/2])
        rotate([-90,0,0])
        hinge_b();
    
    linear_extrude(hinge_dia)
    polygon([
    [0,hinge_extra+hinge_dia/2],
    [hinge_t*2,hinge_extra+hinge_dia/2],
    [hinge_t*2-camera_lens_cx, arm_len-hinge_dia/2-hinge_extra],
    [-camera_lens_cx, arm_len-hinge_dia/2-hinge_extra],
    ]);
}

module enderbar(altstyle=false) {
    bar_w = 40;
    screw_head_d = 2;
    
    alt_t = 3.8; // 3.5 actually, but we need it to fit
    alt_h = 6;
    
    // base plate
    cube([bar_w, bar_len_hook, bar_t]);
    // hooks
    translate([10,0,bar_t])
        rotate([0,-90,-90])
        linear_extrude(bar_len_hook)
        creality_hook2d();
    translate([30,0,bar_t])
        rotate([0,-90,-90])
        linear_extrude(bar_len_hook)
        creality_hook2d();

    if(altstyle) {
        translate([0,bar_len_hook+alt_t,0])
        difference() {
            // screw plate. 10 to screw centers, 15 to allow dia of 10
            cube([bar_w, bar_t, alt_h+bar_t]);
        }
    } else {
        translate([0,bar_len_hook,0])
        difference() {
            // screw plate. 10 to screw centers, 15 to allow dia of 10
            cube([bar_w, bar_t, 15+bar_t]);
            
            // screws are m5, heads are 8.5mm, 3.5mm deep
            translate([10,0,10+bar_t])
                rotate([-90,0,0])
                cylinder(d=hole_dia(5), h=bar_t);
            translate([30,0,10+bar_t])
                rotate([-90,0,0])
                cylinder(d=hole_dia(5), h=bar_t);
            translate([10,bar_t-screw_head_d,10+bar_t])
                rotate([-90,0,0])
                cylinder(d=hole_dia(8.5), h=screw_head_d);
            translate([30,bar_t-screw_head_d,10+bar_t])
                rotate([-90,0,0])
                cylinder(d=hole_dia(8.5), h=screw_head_d);
        }
    }
    // outside that
    translate([0,bar_len_hook,0])
    cube([bar_w, bar_outside_len+bar_t, bar_t]);

    // hook system
    translate([bar_w/2,bar_len_hook+bar_t+bar_outside_len-hinge_dia/2,bar_t])
        hinge_a();
}

hinge_extra = .6;
hinge_dia = 10;
hinge_t = 5;

module hinge_b() {

    translate([0,0,hinge_extra+hinge_dia/2])
        rotate([90,0,90])
        translate([0,0,-hinge_t])
        linear_extrude(2*hinge_t)
        hinge2d();
}

module hinge_a() {

    translate([0,0,hinge_extra+hinge_dia/2])
    rotate([90,0,90])
    union() {
        translate([0,0,-2*hinge_t])
            linear_extrude(hinge_t)
            hinge2d();
        translate([0,0,hinge_t])
            linear_extrude(hinge_t)
            hinge2d();
    }
}

module hinge2d() {
    hole_dia = hole_dia(5);

    difference() {
        union() {
            translate([0,0,0])
            circle(d=hinge_dia);
            translate([-hinge_dia/2,-hinge_dia/2-hinge_extra])
                square([hinge_dia, hinge_dia/2+hinge_extra]);
        }
        circle(d=hole_dia);
    }

}

module cable_support() {
    difference() {
        // make box
        translate([-cable_support_w/2,0,0])
            cube([cable_support_w,cable_support_h,cable_support_len]);
        // make cable
        translate([0,cable_support_h,-GLITCH/2])
            cylinder(d=camera_cable_dia, h=cable_support_len+GLITCH);
        // make ziptie
        translate([-(cable_support_w+GLITCH)/2,-GLITCH,cable_support_len/2 - ziptie_width/2])
            cube([cable_support_w+GLITCH,ziptie_height+GLITCH,ziptie_width]);
    }
}

module tripod_screwhole() {
    holes_pitch=14;
    // anti rotation pin
    tripod_pin_dia = 4.5;
    tripod_pin_h = 4;
    
    screwhole_turns = 6;


    originy = -support_y/2;
    
    // 5% wider but the same length to keep the pitch correct.
    translate([0,originy,0])
        scale([1.05,1.05,1])
        bolt("UNC-1/4", turns=screwhole_turns);
    translate([0,originy+holes_pitch,-GLITCH])
        cylinder(d=tripod_pin_dia*fudge,h=tripod_pin_h+GLITCH);
}


// the product
module camera_support(tripod=true, hinge=false) {

    difference() {
        camera_support_base();
        if(tripod)
            tripod_screwhole();
        //cube([5,5,5]);
    }
    if(hinge)
        translate([0,-support_y/2,0])
        rotate([180,0,0])
        hinge_a();


    // add the tab that fastens the camera
    translate([-camera_tab_x/2,0,support_tabclip_z])
        rotate([0,-90,180])
        linear_extrude(camera_tab_x)
        polygon([[0, tab_hook_y],
                [tab_hook_z, tab_hook_y/2],
                [0, 0]]);
    // add cable support
    translate([0,cable_support_len-support_y,support_z])
        rotate([90,0,0])
        cable_support();
}

// the container where the camera sits
module camera_support_base() {
    difference() {
        translate([-support_x/2,-support_y,0])
            camera_shell2d(support_y);

        // tab cutout
        translate([-camera_tab_x/2,-tab_cutout_y,support_tabclip_z])
            cube([camera_tab_x, tab_cutout_y+GLITCH, camera_tab_z+GLITCH]);
        
        // hinge cutout
        translate([-camera_hinge_x/2, -camera_hinge_y, support_z - camera_top_z - camera_hinge_z])
            cube([camera_hinge_x, camera_hinge_y+GLITCH, camera_hinge_z]);
        
        // support cutout
        translate([-camera_support_x/2,-camera_back_support_y, support_z - camera_top_z - camera_support_z])
            cube([camera_support_x, camera_back_support_y+GLITCH, camera_support_z]);
    }
}

module camera_shell2d(length) {
    
    remove_corners_x = 9;
    remove_corners_z = 7;
    
    translate([0,0,support_z])
    rotate([-90,0,0])
        linear_extrude(length)
        offset(support_corners_r)
        offset(-support_corners_r)
        difference() {
            square([support_x, support_z]);
            // remove corner material
            translate([0,support_z-remove_corners_z])
                square([remove_corners_x, remove_corners_z]);
            translate([support_x-remove_corners_x,support_z-remove_corners_z])
                square([remove_corners_x, remove_corners_z]);
        }

}