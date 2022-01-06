
$fn = 32;
GLITCH=.01;


wt=1.64; // 1.5mm walls
slack = .2; // slack applies twice

id=17.04; // 16.68 on the most tight spot
od=id + 2*slack + 4*wt;
joint_dia = 12;
joint_d1 = 4.1;
joint_d2 = 2;


ziptie_w = 3.5;
ziptie_h = 1.5;

// 1:
// Back bar with connector for https://www.thingiverse.com/thing:2920060
//   Both down and to the hotend


// Design goals:
// - Zip tie mounts
// - Connects to the extruder mount
//   As for stock ender 3, there is only the BS cable mount. Here you probably
//   need a small spacer plate to get screw access

// Most important for interfacing:
// - Top connector is outer (stop=outer)
// - Bottom connector is inner (start=inner)
// - Both of them have a wall thickness of 1.64

//rotate([180,0,0])
    //inner_connector(45);
//outer_connector();

// As for the measurements of the bar:
// Hole distance is 31mm.
// About 14mm from outer screw to center of bar below
// About 70mm from inner screw to termination point
// About id (17mm) inner space
// And then half of the od extra

c_total_len = 14 + 70 + 31 + od/2;

//rotate([90,0,0])

difference() {
    channel();
    
    translate([-GLITCH/2, id+2*wt, joint_dia-ziptie_h-wt])
        cube([od+GLITCH, ziptie_w, ziptie_h]);

    translate([65,-GLITCH/2,joint_dia-ziptie_h-wt])
        cube([ziptie_w, od+GLITCH, ziptie_h]);

    translate([65+50,-GLITCH/2,joint_dia-ziptie_h-wt])
        cube([ziptie_w, od+GLITCH, ziptie_h]);
}

module channel() {
    
    // U channel first
    cube([c_total_len, id+2*wt, wt]);
    
    
    // screwholes in this one, M3. 4mm dia to be sure.
    difference() {
        // long wall
        translate([0,id+wt,wt])
            cube([c_total_len, wt, joint_dia-wt]);

        // holes for extruder plate mount
        translate([od/2 + 14,id+2*wt,joint_dia/2])
            rotate([90,0,0])
            cylinder(d=4, h=wt);
        translate([od/2 + 14 + 31,id+2*wt,joint_dia/2])
            rotate([90,0,0])
            cylinder(d=4, h=wt);
    }
    // short wall
    translate([od,0,wt])
            cube([c_total_len-od, wt, joint_dia-wt]);
    
    // end wall
    translate([0,wt,0])
        cube([wt, id, joint_dia]);

    translate([c_total_len+joint_dia/2,id/2+wt,joint_dia/2])
        rotate([0,0,-90])
        inner_connector();

    translate([od/2,wt-joint_dia,joint_dia/2])
        mirror([0,1,0])
        outer_connector();
}





module outer_connector_half() {
    difference() {
        union() {
            // Circle
            translate([od/2-wt,0,0])
                rotate([0,90,0])
                cylinder(d=joint_dia,h=wt);
            // Extension, inner
            translate([od/2-wt,-joint_dia,-joint_dia/2])
                cube([wt,joint_dia,joint_dia]);
        }
        // Pin
        translate([od/2-wt,0,0])
            rotate([0,90,0])
            cylinder(d1=joint_d1+2*slack,d2=joint_d2+2*slack,h=wt);
    }
    // Extension, outer
    owt=wt+slack;
    
    
}

module outer_connector() {
    outer_connector_half();
    mirror([1,0,0])
        outer_connector_half();
}

module inner_connector_half(theta) {
    // Circle
    translate([id/2,0,0])
        rotate([0,90,0])
        cylinder(d=joint_dia,h=wt);
    // Pin
    translate([id/2+wt,0,0])
        rotate([0,90,0])
        cylinder(d1=joint_d1,d2=joint_d2,h=wt+slack);
    // Extension, inner
    translate([id/2+wt/2,-joint_dia/2,0])
        cube([wt,joint_dia,joint_dia], center=true);
    // Extension, outer
    owt=wt+slack;
    
    difference() {
        translate([id/2+wt+owt/2,-joint_dia/2,0])
            cube([owt,joint_dia,joint_dia], center=true);
        translate([id/2+wt,0,0])
            rotate([0,90,0])
            cylinder(d=joint_dia, h=owt+GLITCH);
        
        rotate([-theta,0,0])
            translate([id/2+wt,0,-joint_dia/2])
            cube([owt+GLITCH,joint_dia,joint_dia]);
        rotate([theta,0,0])
            translate([id/2+wt,0,-joint_dia/2])
            cube([owt+GLITCH,joint_dia,joint_dia]);
    }
}

module inner_connector(theta=45) {
    inner_connector_half(theta);
    mirror([1,0,0])
        inner_connector_half(theta);
}