/*
Door stopper

Author:
- Daniel K. Schneider, TECFA, University of Geneva, April 2010

Copyright and credits:
- Attribution - Non-Commercial - Share Alike license.
  (http://creativecommons.org/licenses/by-nc-sa/3.0/)

Purpose:
- Stops doors from banging when it is windy :)
- Offer it as a 3D visiting card, publicity for programs, etc.

Usage:
- Add some text on top of the flat area. E.g. use Netfabb to create and to position the 3D letters, then merge with Meshlab (or buy Netfabb Pro).
- Add text underneath, or use the door_stopper_simple () module. Text underneath should stretch in both the x/y directions ! Else you will have too much overhang.
- I recommend using a fat, round font like Arial Rounded MT Bold
- For some kinds of buildings, you may have to adapt the openscad code, i.e. you can make it less high or higher...

Printing with the rapman / skeinforge
- Printing is *much* easier with PLA since it doesn't warp, but PLA is not as solid as ABS.
- ABS will probably warp, so:
-- take the print bed off and sand it again
-- make a really sticky and large raft (3mm thickness and 15 mm extra margin) and print it slowly !
-- even then, be prepared to file away the rounded bottom or if it warps just be bit, accept that it will be rounded since that hasn't much impact on door stopping ;)
-- use a fan maybe, but then raise all temperatures by 5 or more (depending on how much your ventilator will cool), e.g. 243 for the raft and 256 for the rest.
- Use a good infill if you want it solid, e.g. 25 %
- Flow rate: about 450

*/ 


// ------------------------- Pick your module
// Comment/uncomment one

// door_stopper ();
door_stopper_simple ();

// -------------------------- door stopper with text underneath 

module door_stopper ()
{
    height = 25  ;
    length = 135 ;
    width= 62 ;
    half_width  = width / 2;
    
    borders = 10; // 1 cm on each side

    bottom_cube_length = length - 4.5 * borders;
    bottom_cube_width = width - 2 * borders;
    bottom_cube_height = 6.0 ; // 3mm in / 3mm outsite
    bottom_z = 0;

    top_cube_length = length - 4 * borders;
    top_cube_width  = width - 2 * borders;
    top_cube_height = height ;  // make it big enough
    top_z = height/2 + 8 ; // adjust manually ;)

    tip_cut_pos = length/2 - 0.5;

    difference() {
	translate ([-length/2.0, 0, 0]) {
    	    polyhedron (	
	    		points = [[0, -half_width, height], [0, half_width, height], [0, half_width, 0], [0, -half_width, 0], [length, -half_width, 0], [length, half_width, 0]],
			triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}
	// bottom inset
	translate ([-1 * borders, 0, bottom_z]) {
	    # cube ([bottom_cube_length,
		     bottom_cube_width,
		     bottom_cube_height],
		    center=true) ;
	}
	// top inset
	translate ([-1 * borders, 0, top_z]) {
	    # cube ([top_cube_length,
		     top_cube_width,
		     top_cube_height],
		    center=true) ;
	}
	// cut of the tip a bit

	translate ([tip_cut_pos, 0, 0]) {
	    cube ([20,
		     width + 1,
		     height],
		    center=true) ;
	}
    }	    
}


// -------------------------- door stopper without text underneath 

module door_stopper_simple ()
{
    height = 20  ;
    length = 125 ;
    width= 40 ;
    half_width  = width / 2;
    
    borders = 10; // 1 cm on each side

    top_cube_length = length - 4 * borders;
    top_cube_width  = width - 2 * borders;
    top_cube_height = height ;  // make it big enough
    top_z = height/2 + 4 ; // adjust manually ;)

    tip_cut_pos = length/2 - 0.5;

    difference() {
	translate ([-length/2.0, 0, 0]) {
    	    polyhedron (	
	    		points = [[0, -half_width, height], [0, half_width, height], [0, half_width, 0], [0, -half_width, 0], [length, -half_width, 0], [length, half_width, 0]],
			triangles = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);
	}

	// top inset
	translate ([-1 * borders, 0, top_z]) {
	    # cube ([top_cube_length,
		     top_cube_width,
		     top_cube_height],
		    center=true) ;
	}
	// cut of the tip a bit

	translate ([tip_cut_pos, 0, 0]) {
	    # cube ([20,
		     width + 1,
		     height],
		    center=true) ;
	}
    }
}

