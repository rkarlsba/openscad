/*
 * openscad chessishboard - written to make a hnefatafl [hne:vatavl] (aka viking chess) board, but
 * as things goes, one keeps adding new stuff. This is work in progress, so please help out if something
 * doesn't work as well as it should.
 *
 * Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0.
 *
 * Written by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
 */

$fn=16;
boxsize=[35,35];
framewidth=1;
frames=11;
borderwidth=7;

module hnefatafl(size,borderwidth) {
}

/* 
 * Create a single frame and use some infill if wanted.
 * Types of infill supported
 *   none:   nothing at all
 *   solid:  fill the whole frame
 *   cross:  A vertical/horizontal cross
 *   dcross: A diagonal cross
 */
module frame(size,borderwidth,infill="none") {
    difference() {
        square(size);
        translate([borderwidth/2,borderwidth/2])
            square(size[0]-borderwidth,size[1]-borderwidth);
    }
    if (infill != "none") {
        if (infill == "cross") {
            echo("cross on");
        } else if (infill == "dcross") {
            echo("dcross on");
        } else if (infill == "solid") {
            echo("solid fill");
        } else {
            echo("WARNING: Unknown infill: " + fill);
        }
    }
}

/*
 * boxsize is the size of each frame
 * count is the number of frames per side 
 *   FIXME: Should be x and y to allow for games like cờ tướng. 
 * type is the board type. The following are defined (so far)
 *   none:      defailt - just the lines
 *   chess:     8x8, alternating black/white
 *   hnefatafl: 11x11, castles in each corner and the middle
 */
module board(boxsize,count,type="none") {
    for (x=[0:frames-1]) {
        for (y=[0:frames-1]) {
            translate([boxsize[0]*x,boxsize[1]*y]) {
                if (type == "none") {
                    frame(boxsize, framewidth);
                } else if (type == "chess") {
                    // FIXME: alternate fill
                    frame(boxsize, framewidth, fill);
                } else if (type == "hnefatafl") {
                    fill = (x==5 && y==5) ? "cross" : "";
                    frame(boxsize, framewidth, fill);
                } else {
                    echo("WARNING: Unknown type: " + type);
                }
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