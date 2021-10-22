$fn = $preview ? 32 : 128;

avrunding=3;
y1=74;
x1=40;
y2=15;
x2=30;
x3=70;

module t1() {
    hull() {
        circle(r=avrunding);
        translate([0, y1])
            circle(r=avrunding);
        translate([x1,y1])
            circle(r=avrunding);
    }
}

module t2() {
    hull() {
        translate([x1,y1])
            circle(r=avrunding);
        translate([x1,y1+y2])
            circle(r=avrunding);
        translate([x1+x2,y1])
            circle(r=avrunding*2);
    }
}

module t3() {
    hull() {
        circle(r=avrunding);
        translate([x3,0])
            circle(r=avrunding);        
    }
}

translate([avrunding,avrunding]) {
    t1();
    t2();
    t3();
}
