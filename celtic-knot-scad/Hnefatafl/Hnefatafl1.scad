/*
 * vim:ts=4:sw=4:sts=4:et:fdm=marker
 *
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
frames=13;
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
 *   circle: A circle
 */
module frame(size,borderwidth,infill="none") {
    /*
     * Draw the frame
     */
    difference() {
        square(size);
        translate([borderwidth/2,borderwidth/2])
            square(size[0]-borderwidth,size[1]-borderwidth);
    }
    /*
     * Draw infill if needed.
     */
    if (infill == "cross") {
        echo("cross on");
    } else if (infill == "dcross") {
        difference() {
            square(size);
            // I have really made a mess of my maths here, but hell, it looks ok :þ
            translate([borderwidth/2,-borderwidth]) {
                rotate(45) square([(size[0])*sqrt(2),borderwidth*2]);
            }
            translate([size[0]+borderwidth/2,borderwidth])
                rotate(135) square([(size[0])*sqrt(2),borderwidth*2]);
        }
        echo("dcross on");
    } else if (infill == "solid") {
        echo("solid fill");
    } else if (infill == "circle") {
        cdim = size[0]/2;
        translate([cdim,cdim]) {
            difference() {
                circle(size[0]/3);
                circle(size[0]/4);
            }
        }
    } else if (infill != "none") {
        echo("WARNING: Unknown infill: ", infill);
    }
}

/*
 * boxsize is the size of each frame
 * count is the number of frames per side 
 *   FIXME: Should be x and y to allow for asymmetric games like cờ tướng/xiangqi. 
 * type is the board type. The following are defined (so far)
 *   none:      default - just the lines
 *   chess:     Typically 8x8, alternating black/white
 *   hnefatafl: Typically 11x11, castles in each corner and the centre of the board
 */
module board(boxsize,count,type="none") {
    for (x=[0:frames-1]) {
        for (y=[0:frames-1]) {
            translate([boxsize[0]*x,boxsize[1]*y]) {
                if (type == "none") {
                    frame(boxsize, framewidth);
                } else if (type == "chess") {
                    // FIXME: alternate infill
                    frame(boxsize, framewidth, infill);
                } else if (type == "hnefatafl") {
//                    infill = (x==floor(count/2) && y==floor(count/2) || x==0&&y==0 || x==0 && y==count-1 || x==count-1 && y==0 || x==count-1&&y==count-1) ? "dcross" : "none";
                    if (x==floor(count/2) && y==floor(count/2) || // centre
                        x == 0 && y == 0 ||                       // left bottom
                        x == 0 && y == count-1 ||                 // right bottom
                        x == count-1 && y == 0 ||                 // left top
                        x == count-1 && y == count-1) {           // right top
                        frame(boxsize, framewidth, "dcross");
                    } else if (y == 0 && x >= floor(count/2)-2 && x <= floor(count/2)+2 ||
                               y == 1 && x == floor(count/2) ||
                               x == 0 && y >= floor(count/2)-2 && y <= floor(count/2)+2 ||
                               x == 1 && y == floor(count/2) ||
                               y == count-1 && x >= floor(count/2)-2 && x <= floor(count/2)+2 ||
                               y == count-2 && x == floor(count/2) ||
                               x == count-1 && y >= floor(count/2)-2 && y <= floor(count/2)+2 ||
                               x == count-2 && y == floor(count/2)) {
                        frame(boxsize, framewidth, "circle");
                    } else {
                        frame(boxsize, framewidth);
                    }
                } else {
                    echo("WARNING: Unknown type: ", type);
                }
            }
        }
    }
}

/*
 * The outer board calls board(), so see syntax above. It just adds a border around it. The
 * border patterns implemented are
 *   none:  This is work in progress :)
 */
module outer_board(boxsize,count,type="none",pattern="none") {
}

board(boxsize,frames,type="hnefatafl");
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
