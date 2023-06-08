r=30;
h1=80;
h2=65;
h3=15;
w=2;

module boks(r,h,w=w) {
    rotate(30) {
        difference() {
            cylinder(r=r,h=h,$fn=6);
            translate([0,0,w*2]) {
                cylinder(r=r-w,h=h-w*2,$fn=6);
            }
        }
    }
}

boks(r=r,h=h1);
translate([r*sqrt(3),0,0]) {
    boks(r=r,h=h2);
}

translate([r*sqrt(3)/2,-r*sqrt(2)-.7,0]) {
    boks(r=r,h=h3);
}
