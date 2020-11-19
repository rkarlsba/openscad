/*
 * =================================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond 15 August 2018.
 *
 *   Slightly improved by Roy Sigurd Karlsbakk
 *   <roy@karlsbakk.net> 19 November 2020.
 *
 *   Small note from Roy: Being 158cm tall, I have
 *   completely ignored height in my work here and
 *   focused only on length, so not all may work.
 * =================================================
 *
 * Simple module to draw a tetrahedron.
 */
$fn = $preview ? 8 : 64;

// Does not work... doh!
*sphere(d=10, $fn=3);

/*
 * Actually, this makes length = length+sphere_rad*2, since each
 * length starts at the center of the sphere. Live with it! I'm
 * not going to fix that.
 *   Roy
 */
length = 150;
sphere_rad=4;

/*
 * - If holey is true, An identical tetrahedron will be subtracted
 *   from the original to save weight/filament.
 * - If holey_test is set, a slice will cut off tetrahedron to show
 *   its inner guts.
 * - holey_thickness defines the thickness of the walls in millimeters
 *   (no inches or feet on my watch!).
 */
holey = true;
holey_test = false;
holey_thickness = 10;

if (holey_test) {
    difference() {
        translate([-length / 2, -length * sqrt(3) / 6, 0]) {
            draw_tetrahedron(length=length, sphere_rad=sphere_rad, holey=holey);
        }
        translate([-length,0,0])
            cube([length*2,length,length]);
    }
} else {
    translate([-length / 2, -length * sqrt(3) / 6, 0]) {
        draw_tetrahedron(length=length, sphere_rad=sphere_rad, holey=holey);
    }
}
height = 10;
*translate([-height / sqrt(3), -height / 3, 0]) {
	tetrahedron(height = height, sphere_rad);
}


/**
 * Tetrahedron
 * Specify either the length or the height.
 * If both are specified, length take precedence.
 *
 * If sphere_rad is > 0, it defines the radius of the pshere
 * in each corner, nicely rounding it off. It also extends
 * length by sphere_rad*2, since I'm a lazy bastard and haven't
 * fixed that yet.
 *   Roy
 */
module tetrahedron(length=0, height=0, sphere_rad=0) {
	// https://en.wikipedia.org/wiki/Equilateral_triangle
	//   sin(60) = sqrt(3)/2
	height = length == 0 ? height : sqrt(3) / 2 * length;
	length = length == 0 ? 2 * height / sqrt(3) : length;
    
    if (sphere_rad > 0) {
        hull() {
            translate([0,0,0]) sphere(sphere_rad);
            translate([length,0,0]) sphere(sphere_rad);
            translate([length/2,height,0]) sphere(sphere_rad);
            translate([length/2, height/3, height]) sphere(sphere_rad);
        }
    } else {
        polyhedron(
            points = [
                // 3 points of the base
                [0, 0, 0],
                [length, 0, 0],
                [length/2, height, 0],

                // Summit
                // https://en.wikipedia.org/wiki/Equilateral_triangle
                //   The radius of the inscribed circle is height/3
                [length/2, height/3, height]
            ],
            faces = [
                [0, 1, 2], // Base
                [0, 2, 3], // Left face
                [1, 3, 2], // Right face
                [0, 3, 1]  // Front face
            ]
        );
    }
}

module draw_tetrahedron(length=0, height=0, sphere_rad=0, holey=false) {
    if (holey) {
        difference() {
            tetrahedron(length, height, sphere_rad);
            translate([holey_thickness,holey_thickness/2,holey_thickness]) {
                tetrahedron(length-holey_thickness*2, sphere_rad);
            }
        }
    } else {
        tetrahedron(length, height, sphere_rad, holey);
    }
}
