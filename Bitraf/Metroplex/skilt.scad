
name="Metroplex";
name_sz=12;
//name_font="MLP \\- Magic is Friendship:style=Regular";
name_font="MLP:style=Regular";

nozzle="0,4mm";
nozzle_sz=6;
nozzle_font="MLP \\- Magic is Friendship:style=Regular";
//nozzle_font="Arial:style=Bold";

plate_t=2;
text_t=1.5;

border_pad=5;
border_t = 2;

round_d=5;

module round_cube(dim) {
    linear_extrude(dim[2])
    offset(round_d)
    translate([round_d, round_d])
    square([dim[0]-2*round_d, dim[1]-2*round_d]);
}



module background(size_x, size_y) {
    color("black")
        translate([-size_x/2,0,0])
            round_cube([size_x,
                  size_y,
                  plate_t]);

    color("pink")
        translate([-size_x/2,0,plate_t-.01])
        difference() {
            round_cube([size_x, size_y, text_t]);
            translate([border_t,border_t,0])
            round_cube([size_x - 2*border_t, size_y - 2*border_t, text_t + .02]);
        }
}



size_x = (len(name)+0.5)*name_sz + 2*border_pad;
size_y = 2*name_sz + 1.5*nozzle_sz + 2*border_pad;

background(size_x, size_y);

color("pink") {
    translate([0,nozzle_sz/2+border_pad,plate_t])
    linear_extrude(text_t) {
        translate([0,2*nozzle_sz])
        text(name, font = name_font, size=name_sz, halign="center");
        text(nozzle, font = nozzle_font, size=nozzle_sz, halign="center");
    }
}
