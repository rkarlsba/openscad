$fn=$preview?32:256;

// vim:ts=4:sw=4:sts=4:et:ai
outer_r = 5;
inner_r = 4;
height = 9;
tip_reduction = 2;
length=50;

module pinsett() {
    module a() {
        difference() {
            translate([0,0,0])
                cylinder ($fn = 360, $fa = 12, $fs = 2, r=outer_r, h=height-2);
            translate([0,0,-1])
                cylinder ($fn = 360, $fa = 12, $fs = 2, r=inner_r, h=height);
            translate([5,0,-1])
                cylinder ($fn = 360, $fa = 12, $fs = 2, r=inner_r, h=height);
        }  
    }

    a();
    scale ([2,2,1])
        a();
    translate([2.5,3,0])
        cube ([length,1,7]);
    translate([2.5,-4,0])
        cube ([length,1,7]);

    translate([5,-8,0])
        rotate ([0,0,5])
            cube ([50,1,7]);
    mirror ([0,1,0])
        translate([5,-8,0])
            rotate ([0,0,5])
                cube ([length,1,7]); 
    translate([length+4,3,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+4,-3,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+3,3.1,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+3,-3.1,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+2,3.2,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+2,-3.2,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+1,3.3,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length+1,-3.3,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length,3.4,0]) cylinder(d=1,h=height-tip_reduction);
    translate([length,-3.4,0]) cylinder(d=1,h=height-tip_reduction);
}


difference() {
    pinsett();
}
