use <ymse.scad>

$fn = $preview ? 12 : 64;

switchfoot = true;
hidefoot = true;
show_foot = (!hidefoot && $preview);
foot_x = 40;
foot_y = 25;
foot_z = 55;
foot_slack = 1;
slipper = 8;
radius = 5;

slipper_x = foot_x+slipper*2;
slipper_y = foot_y+slipper*2;

foot = "Fuss_4mm.stl";

flatfix = 5;
difference() {
    translate([0,0,-flatfix]) 
//        roundedcube(size=[foot_x+slipper*2,foot_y+slipper*2,flatfix+slipper], radius=radius);
        roundedcube(size=[slipper_x,slipper_y,flatfix+slipper], radius=radius);
    translate([0,0,-flatfix])
        cube(size=[slipper_x,slipper_y,flatfix]);
    translate([slipper-foot_slack/2,slipper-foot_slack/2,slipper/2]) {
        linear_extrude(slipper/2) {
            roundedsquare(size=[foot_x+foot_slack,foot_y+foot_slack-10],radius=radius);
            translate([0,5,0]) {
                square(size=[foot_x+foot_slack,foot_y+foot_slack-11]);

//                square(size=[foot_x+foot_slack,foot_y/2]);
            }
        }
    }
//        cube(size=[slipper_x,slipper_y,flatfix]);
    translate([slipper-foot_slack/2,foot_y+foot_slack*2.6,radius-foot_slack]) {
        rotate([55,0,0]) {
            cube([foot_x+foot_slack,10,10]);
        }
    }
    if (switchfoot) {
        translate([slipper-foot_slack/2,0,slipper/2+1.5]) {
            cube([5+foot_slack/2,slipper*2,2.5]);
            translate([0,7,0]) {
                rotate([0,0,315]) {
                    cube([5+foot_slack/2,slipper*2,2.5]);
                }
            }
        }
    }
}

if (show_foot) {
    mirror([0,1,0])
        translate([slipper,-foot_x-slipper,foot_z+slipper+1]) {
            import(foot);
    }
}