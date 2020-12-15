include <honeycomb/honeycomb.scad>

origbox_x = 70;
origbox_y = 90;
glippe = 1;
batbox_diff = 2;
batbox_x = origbox_x+batbox_diff*2;
batbox_y = origbox_y+batbox_diff*2;
batbox_z = 30;
batbox_tykkelse = 2;
bathole_w = 21;
bathole_h = 2.4;
batteribredde=25;
flappbredde=20;
flapptykkelse=1;
flapphoyde=10;

difference() {
    difference() {
        cube([batbox_x, batbox_y, batbox_z]);
        translate([batbox_tykkelse,batbox_tykkelse,batbox_tykkelse]) {
            cube([batbox_x-batbox_tykkelse*2, batbox_y-batbox_tykkelse*2, batbox_z-batbox_tykkelse]);
        }
    }
    /*
    translate([batbox_diff-glippe, batbox_diff-glippe, batbox_z-batbox_tykkelse]) {
        cube([origbox_x+glippe*2, origbox_y+glippe*2, batbox_tykkelse]);
    }
    */
}

translate([batbox_tykkelse*2+batteribredde,batbox_tykkelse,batbox_tykkelse]) {
    rotate([90,270,270])
        linear_extrude(batbox_tykkelse)
            honeycomb(batbox_z-batbox_tykkelse, batbox_y-batbox_tykkelse*2, 12, batbox_tykkelse);
}
/*
translate([batbox_tykkelse+batteribredde,batbox_tykkelse*2,batbox_tykkelse]) {
    cube([batbox_tykkelse,batbox_y-batbox_tykkelse*4, batbox_z-batbox_tykkelse*2]);
}

translate([batbox_tykkelse+batteribredde,batbox_tykkelse,batbox_z/3]) {
    cube([batbox_tykkelse, batbox_tykkelse, batbox_z/3]);
}

translate([batbox_tykkelse+batteribredde,batbox_y-batbox_tykkelse*2,batbox_z/3]) {
    cube([batbox_tykkelse, batbox_tykkelse, batbox_z/3]);
}
*/
translate([batbox_x/2-flappbredde/2,-flapptykkelse,batbox_z-flapphoyde/2]) {
    cube([flappbredde,flapptykkelse,flapphoyde]);
    translate([0,batbox_y+flapptykkelse*2,0])
        cube([flappbredde,flapptykkelse,flapphoyde]);
}

translate([-flapptykkelse,batbox_y/2-flappbredde/2,batbox_z-flapphoyde/2]) {
    cube([flapptykkelse,flappbredde,flapphoyde]);
    translate([batbox_x+flapptykkelse*2,0,0])
        cube([flapptykkelse,flappbredde,flapphoyde]);
}    

/*
translate([24.6+bathole_w/2+batbox_diff, 31.4+bathole_w/2+batbox_diff, batbox_z-batbox_tykkelse]) {
    cylinder(d=bathole_w,h=batbox_tykkelse);
}
*/