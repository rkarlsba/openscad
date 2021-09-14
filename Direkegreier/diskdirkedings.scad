$fn = 32;
step=1;

lengde = 60;
bredde = 6;
avrunding = 1;

module pil(lengde = 60, bredde = 6, avrunding = 1) {
    hull() {
        translate([avrunding,avrunding]) {
            circle(r=avrunding);
        }
        translate([avrunding,bredde-avrunding]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding,avrunding]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding+bredde, bredde/2]) {
            circle(r=avrunding);
        }
        translate([lengde-avrunding,bredde-avrunding]) {
            circle(r=avrunding);
        }
    }
}

hull() {
    linear_extrude(step) {
        pil(lengde = lengde, bredde = bredde, avrunding = avrunding);
    }
    translate([0,step,step]) {
        linear_extrude(1) {
            pil(lengde = lengde-step, bredde = bredde-step*2, avrunding = avrunding);
        }
    }
}