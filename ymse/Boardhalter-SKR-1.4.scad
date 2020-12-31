use <ymse.scad>

$fn = $preview ? 12 : 64;

foot_x = 40;
foot_y = 25;
foot_z = 55;
foot_slack = 1;
slipper = 8;
radius = 5;

slipper_x = foot_x+slipper*2;
slipper_y = foot_y+slipper*2;

foot = "/Users/roy/Nextcloud/Dokumenter/Bitraf/3D-greier/CR10S-Standalone/Den\ tyske/files/Fuss_4mm.stl";

flatfix = 5;
difference() {
    translate([0,0,-flatfix]) 
//        roundedcube(size=[foot_x+slipper*2,foot_y+slipper*2,flatfix+slipper], radius=radius);
        roundedcube(size=[slipper_x,slipper_y,flatfix+slipper], radius=radius);
    translate([0,0,-flatfix])
        cube(size=[slipper_x,slipper_y,flatfix]);
    translate([slipper,slipper,slipper/2]) {
        linear_extrude(slipper/2) {
           // roundedsquare(size=[foot_x+foot_slack,foot_y+foot_slack],radius=radius);
        }
    }
//        cube(size=[slipper_x,slipper_y,flatfix]);
}

mirror([0,1,0])
    translate([slipper,-foot_x-slipper,foot_z+slipper]) {
        import(foot);
}
