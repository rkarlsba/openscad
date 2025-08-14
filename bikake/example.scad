/**
 * Simple example of Honeycomb library usage
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * 
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

include <honeycomb.scad>

height =7;

linear_extrude(height) {
	honeycomb(105, 80, 12, 2.5);
}
