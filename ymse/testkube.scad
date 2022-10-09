cubesize=[20,20,20];
walls=[2,2,2];

difference() {
    cube(cubesize);
    translate(walls) {
        cube(cubesize-[walls[0]*2,walls[1]*2,walls[2]]);
//        cube(cubesize-walls*2);
    }
}