tykkelse=2;
x=105;
y=26;
z=40;
disktype=3.5;

// internt;
ty=tykkelse;

module boks() {
    difference() {
        cube([x+ty*2,y+ty*2,z]);
        
        translate([ty,ty,ty]) {
            cube([x,y,z]);
        }
    }
}

module storboks(antall) {
    for (t = [0:antall-1]) {
        translate([0, y*t+t*2, 0]) {
            boks();
        }
    }
}

storboks(6);