/*
 * Module terning_6 tar følgende parametre:
 *
 *  *side       Sidelengde - obligatorisk (mm)
 *   print      Trykk verdi på side (true/false)
 *   depth      Trykkdybde - standard 2% av side
 *
 */

module terning_6(side, print = true, depth = 2) {

    terning_x = side;
    terning_y = terning_x;
    terning_z = terning_x;
    curvage = sqrt(2);

    intersection() {
        translate([terning_x/2,terning_y/2,terning_z/2]) {
            sphere(d=terning_x*curvage);
        }
        cube([terning_x,terning_y,terning_z]);
    }

}

/*
 * Module terning_6 tar følgende parametre:
 *
 *  *side       Sidelengde - obligatorisk (mm)
 *   print      Trykk verdi på side (true/false)
 *   depth      Trykkdybde - standard 2% av side
 *
 */

module terning_4_daabloe(side) {
}

terning_6(side=10);