$fn=16;
boxsize=[35,35];
framewidth=1;
frames=11;
borderwidth=7;

module hnefatafl(size,borderwidth) {
}

module frame(size,borderwidth,fill) {
    difference() {
        square(size);
        translate([borderwidth/2,borderwidth/2])
            square(size[0]-borderwidth,size[1]-borderwidth);
    }
    if (fill == "cross") {
        echo("cross on");
    }
}

module board(boxsize,count) {
    for (x=[0:frames-1]) {
        for (y=[0:frames-1]) {
            translate([boxsize[0]*x,boxsize[1]*y]) {
                fill = (x==5&&y==5) ? "cross" : "";
                frame(boxsize, framewidth,fill);
            }
        }
    }
}

board(boxsize,frames);
// translate([boxsize,boxsize*1]) frame([boxsize,boxsize], framewidth);

/*
for (x=[0:frames-1]) {
    for (y=[0:frames-1]) {
        translate([boxsize[0]*x,boxsize[1]*y]) {
            frame(boxsize, framewidth);
        }
    }
}
*/