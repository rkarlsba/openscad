fn=128;

height=50;
bottom_r=15;

difference() {
    cylinder(h=height,r1=bottom_r,r2=0,$fn=fn);
    cylinder(h=height*.9,r1=bottom_r*.9,r2=0,$fn=fn);
}