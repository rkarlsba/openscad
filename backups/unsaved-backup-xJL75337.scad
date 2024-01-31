rute = [50,50,10];
storrute = [1,100,10];
r = 23.5;

difference() {
    cube(rute, center = true);
    //translate([-storrute[0],0,0]) 
    {
        rotate(r) {
            cube(storrute, center = true);
            rotate([0,0,90]) {
                cube(storrute, center = true);
            }
        }
    }
}