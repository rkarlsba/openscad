include </Users/roy/driiiiit/Nextcloud/Dokumenter/Bitraf/Laserkutterting/lasercut-box-openscad/box.scad>

width = 95;
depth = 70;
height = 80;
thickness = 3;
extra = thickness + 2;
spacing = 1;
assemble = false;
kerf=.5;
roof=true;

if (assemble) {
    the_box();
    translate([-extra, -extra, height - 4 * thickness]) lid();
} else {
    difference() {
        the_box();
        
        translate([width*0.16,thickness+extra+15]) sprekk(lengde=width-35, bredde=4);
        translate([width*0.16,thickness+extra+30]) sprekk(lengde=width-35, bredde=4);
        translate([width*0.16,thickness+extra+45]) sprekk(lengde=width-35, bredde=4);
        translate([width*0.16,thickness+extra+60]) sprekk(lengde=width-35, bredde=4);

        translate([width*1.21,thickness+extra+22]) sprekk(lengde=width-35, bredde=4);
        translate([width*1.21,thickness+extra+37]) sprekk(lengde=width-35, bredde=4);
        translate([width*1.21,thickness+extra+52]) sprekk(lengde=width-35, bredde=4);
            
        usbport([width*2+depth/2+spacing*2,thickness+extra+15]);
        
        for (i = [-20:40:20]) translate([width*2+depth*0.5+spacing*2-i,thickness+extra+15]) circle(d = 7);
        for (i = [-10:20:10]) translate([width*2+depth*0.5+spacing*2-i,thickness+extra+30]) circle(d = 7);
        for (i = [-20:20:20]) translate([width*2+depth*0.5+spacing*2-i,thickness+extra+45]) circle(d = 7);
        for (i = [-10:20:10]) translate([width*2+depth*0.5+spacing*2-i,thickness+extra+60]) circle(d = 7);
        
        for (i = [-20:20:20]) translate([width*2+depth*1.5+spacing*2-i,thickness+extra+15]) circle(d = 7);
        for (i = [-10:20:10]) translate([width*2+depth*1.5+spacing*2-i,thickness+extra+30]) circle(d = 7);
        for (i = [-20:20:20]) translate([width*2+depth*1.5+spacing*2-i,thickness+extra+45]) circle(d = 7);
        for (i = [-10:20:10]) translate([width*2+depth*1.5+spacing*2-i,thickness+extra+60]) circle(d = 7);

        for (i = [-30:20:30]) translate([width*0.5-i,thickness+extra+92]) circle(d = 7);
        for (i = [-20:20:20]) translate([width*0.5-i,thickness+extra+107]) circle(d = 7);
        for (i = [-30:20:30]) translate([width*0.5-i,thickness+extra+122]) circle(d = 7);
    }
    if (!roof) {
        translate([0,height+depth+4*kerf]) {
            difference() {
                lid();
                for (i = [-30:20:30]) translate([width*0.5-i,thickness+extra+33]) circle(d = 7);
                for (i = [-40:20:20]) translate([width*0.5-i,thickness+extra+48]) circle(d = 7);
                for (i = [-30:20:30]) translate([width*0.5-i,thickness+extra+63]) circle(d = 7);
                for (i = [-40:20:20]) translate([width*0.5-i,thickness+extra+78]) circle(d = 7);
            }
        }
    }
}

module sprekk(lengde, bredde) {
    hull() {
        circle(d=bredde);
        translate([lengde,0]) circle(d=bredde);
    }
}

module usbport(center) {
    hull() {
        translate([center[0]-3.5,center[1]]) circle(d=7);
        translate([center[0]+3.5,center[1]]) circle(d=7);
    }
}

module the_box() {
    box(
        width = width,
        height = height,
        depth = depth,
        thickness = thickness,
        open = true,
        inset = 2 * thickness,
        assemble = assemble,
        roof = roof,
        spacing = spacing
    );
}

module lid() {
    box(
        width = width + 2 * extra,
        height = 6 * thickness,
        depth = depth + 2 * extra,
        thickness = thickness,
        open = true,
        inset = 4 * thickness,
        assemble = assemble,
        spacing = spacing
    );
}