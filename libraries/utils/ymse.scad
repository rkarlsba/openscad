// vim:ts=4:sw=4:sts=4:et:ai

/*
 * avrundaboks() takes the following arguments
 *
 * x: width
 * y: depth
 * z: height
 * r: radius of corner
 *
 */
module avrundaboks(x,y,z,r) {
    hull() {
        translate([r,r,0])
            cylinder(h=z,r=r);
        translate([x-r,r,0])
            cylinder(h=z,r=r);
        translate([r,y-r,0])
            cylinder(h=z,r=r);
        translate([x-r,y-r,0])
            cylinder(h=z,r=r);
    }
}

/*
 * avrundahulboks() takes the same arguments as avrundaboks() plus the following:
 *
 * v: wall thickness
 * g: floor thickness
 *
 */
module avrundahulboks(x,y,z,r,v,g) {
    difference() {
        avrundaboks(x,y,z,r);
        translate([v,v,g])
            avrundaboks(x-v*2,y-v*2,z-g,r);
    }
}


/*
 * hexagon(), a single filled hexagon, takes the following arguments:
 *
 * l: The diameter
 */ 
module hexagon(l)  {
	circle(d=l, $fn=6);
}

/*
 * honeycomb() takes the following arguments:
 *
 * x: width
 * y: height/depth
 * dia: the hexacon's diameters (that is, circles with six parts, do the math)
 * wall: wall thickness.
 *
 * Diagram
 *          ______     ___
 *         /     /\     |
 *        / dia /  \    | smallDia
 *       /     /    \  _|_
 *       \          /   ____ 
 *        \        /   / 
 *     ___ \______/   / 
 * wall |            /
 *     _|_  ______   \
 *         /      \   \
 *        /        \   \
 *                 |---|
 *                   projWall
 *
 */
module honeycomb(x, y, dia, wall)  {
	smallDia = dia * cos(30);
	projWall = wall * cos(30);

	yStep = smallDia + wall;
	xStep = dia*3/2 + projWall*2;

	difference()  {
		square([x, y]);

		// Note, number of step+1 to ensure the whole surface is covered
		for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon(dia);
			}
			translate([xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2]) {
				hexagon(dia);
			}
		}
	}
}

/*
 * Where OpenSCAD comes with union(), difference() and intersection(),
 * respectively translating to OR, AND NOT/NOT AND and AND, it lacks XOR. This
 * is an implementation of it, combining intersection_for() and difference().
 *
 * xor() eats no arguments, only children
 *
 */
module xor() {
    difference() {
        for(i = [0 : $children - 1])
            children(i);
        intersection_for(i = [0: $children -1])
            children(i);
    }                                                                
}

