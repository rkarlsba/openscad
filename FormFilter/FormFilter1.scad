feil = $preview ? .1 : 0;

fan_w = 140;
filter_w = 130;
fan_h = fan_w;
filter_h = filter_w;
filter_d = 40;
fan_d = 25;
vegg = 2;
trakt = (fan_w-filter_w)/2;
gitter = 2;

/* Using cylinder() with $fn=4 here instead of cube(), since 
 * cylinder() allows for [rd][12] */
rotate([0,0,45]) {
    /* Vifteholder */
    difference() {
        cylinder(r=fan_w/sqrt(2)+vegg, h=fan_d, $fn=4);
        translate([0,0,-feil]) {
            cylinder(r=fan_w/sqrt(2), h=fan_d+feil*2, $fn=4);
        }
    }

    /* Trakt */
    translate([0,0,fan_d]) {
        difference() {
            cylinder(r1=fan_w/sqrt(2)+vegg, r2=filter_w/sqrt(2)+vegg, h=trakt, $fn=4);
            translate([0,0,-feil]) {
                cylinder(r1=fan_w/sqrt(2), r2=filter_w/sqrt(2), h=trakt+feil*2, $fn=4);
            }
        }
    }
    
    /* Filterholder */
    translate([0,0,fan_d+trakt]) {
        difference() {
            cylinder(r=filter_w/sqrt(2)+vegg, h=filter_d, $fn=4);
            translate([0,0,-feil]) {
                cylinder(r=filter_w/sqrt(2), h=filter_d+feil*2, $fn=4);
            }
        }
    }
}

/* [xzy] */
x = filter_w;
y = filter_h;
z = gitter;

/* Gitter */
fen_x = 15; // fenestrations on x axis
fen_y = 15; // fenestrations on y axis
fen_size = 5; // size of fenestrations as a % of total axis size
fen_d = 2;

// calculate fenestration size
fen_size_x = fen_size * x / 100;
fen_size_y = fen_size * y / 100;

// calculate space remaining and then divide by number of windows needed + 1 
// to get the desired size of the struts
strut_x = (x - fen_x * fen_size_x) / (fen_x + 1);
strut_y = (y - fen_y * fen_size_y) / (fen_y + 1);

// take away windows from fenestrated surface
translate([-x/2, -y/2, fan_d+trakt-z]) {
    difference() {
        cube(size=[x, y, z]); // fenestrated surface
        for (i = [0:fen_x - 1]) {
            translate([i * (fen_size_x + strut_x) + strut_x, 0, 0])
            for (i = [0:fen_y - 1]) {
                translate([0, i * (fen_size_y + strut_y) + strut_x, -1])
                cube([fen_size_x, fen_size_y, z+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
            }
        }
    }
}