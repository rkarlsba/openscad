// vim:ts=4:sw=4:sts=4:et:ai
wall_width      = .6;
diamiter        = 25;
handle_diamiter = 4;
handle_sides    = 8;
resolution      = 8;

$fn=resolution;

module spool_bowl(){
    rotate([5,0,0]) scale([.7,1,.3]) difference() {
        sphere(d=diamiter);
        translate([-50,-50,0]) cube([100,100,100]);
    }
}

module spool_bowl_taken(){
    rotate([5,0,0]) scale([.7,1,.3]) difference() {
        sphere(d=diamiter);
    }
}

module handle(){
    diamiter = diamiter*.3;
    translate([0,-diamiter/2,(-diamiter/2)+handle_diamiter/2]) rotate([90,45,0]){
        cylinder(d=handle_diamiter, h=50, $fn=handle_sides);
    }
}

difference(){
    union(){
        spool_bowl();
        handle();
    }
    scale([diamiter/(diamiter+(wall_width*2)),diamiter/(diamiter+(wall_width*2)),diamiter/(diamiter+(wall_width*2))]) spool_bowl_taken();
}
