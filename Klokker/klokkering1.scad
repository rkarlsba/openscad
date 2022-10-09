// klokkering

$fn=$preview ? 16 : 128;

ring_d = 220;
ring_h = 1.5;

polse_d = 10;

testring = 0;

// pølse
module polse() {
    wheel_radius = ring_d/2;
    tyre_diameter = polse_d;
    rotate_extrude(angle=360) {
        translate([wheel_radius - tyre_diameter/2, 0]) {
            circle(d=tyre_diameter);
        }
    }
}

// kutt
module kutt() {
    hull() {
        translate([0,0,-ring_h/3]) {
            cylinder(d=ring_d-7.5-2, h=ring_h);
        }
        translate([0,0,-ring_h/2]) {
            cylinder(d=ring_d-7.5, h=.1);
        }
        translate([0,0,-ring_h/3*3]) {
            cylinder(d=ring_d-7.5-2, h=ring_h);
        }
    }
}

// fjern_bunn
module fjern_bunn() {
    cylinder(d2=ring_d-polse_d, d1=ring_d-polse_d/2, h=polse_d*.6);
}

module klokkering() {
    difference() {
        polse();
//        kutt();
        fjern_bunn();
    }
}

klokkering();
//fjern_bunn();

assert(0, "Denne er for liten!");
