use <star-puzzle.scad>

rotate([-45, 0, 0]) {
    if(i == 0) piece0();
    if(i == 1) piece1();
    if(i == 2) piece2();
    if(i == 3) piece3();
    if(i == 4) piece4();
    if(i == 5) piece5();
}
