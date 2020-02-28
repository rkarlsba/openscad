// vim:ts=4:sw=4:sts=4:et:ai


module szczypce() {
    module a() {
        difference() {
            translate([0,0,0])
                cylinder ($fn = 360, $fa = 12, $fs = 2,r=5,h=7);
            translate([0,0,-1])
                cylinder ($fn = 360, $fa = 12, $fs = 2,r=4,h=9);
            translate([5,0,-1])
                cylinder ($fn = 360, $fa = 12, $fs = 2,r=4,h=9);
        }  
    }

    a();
    scale ([2,2,1])
        a();
    translate([2.5,3,0])
        cube ([50,1,7]);
    translate([2.5,-4,0])
        cube ([50,1,7]);

    translate([5,-8,0])
        rotate ([0,0,5])
            cube ([50,1,7]);
    mirror ([0,1,0])
        translate([5,-8,0])
            rotate ([0,0,5])
                cube ([50,1,7]); 
}

difference() {
    rotate ([0,1.5,0])
        szczypce();
    translate([-10,-10,-3]) cube ([70,20,3]);    

}
    translate([-10,-10,-3]) cube ([70,20,3]);    
