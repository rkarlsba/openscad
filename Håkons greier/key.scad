outer_shaft_d = 5;
outer_shaft_l = 17; // 18

ring_d = 7.5;
ring_t = 2;

main_shaft_d = 5;
main_shaft_l = 30;

key_handle_t = 5; //3;
key_handle_w = 20;
key_handle_h = 16;

tooth_t = 2.5 - .5;
tooth_h = 7.5;
tooth_len = 4;
tooth_mark_pos = 3.5;
tooth_mark_h = 2;
tooth_mark_d = 1.5;

tooth_a_pos = 2.5;
tooth_b_pos = 8.75; // should be: 8.5 but is actually something like 8.8


$fn = 64; // 64

module tooth(side=0, start) {
    mark_z = (side == 0) ? 0 : (tooth_len-tooth_mark_d);
    translate([0,-tooth_t/2,start])
    difference() {
        cube([tooth_h+outer_shaft_d/2, tooth_t, tooth_len]);
        
        translate([tooth_mark_pos+outer_shaft_d/2,0,mark_z])
        cube([tooth_mark_h, tooth_t, tooth_mark_d]);
    }
    
}

// teeth
tooth(0, tooth_a_pos);
tooth(1, tooth_b_pos);

// outer shaft
cylinder(d=outer_shaft_d, h=outer_shaft_l);
// ring, minus inconvenience
translate([0,0,-ring_t])
    difference() {
        cylinder(d=ring_d, h=ring_t);
        translate([-ring_d/2, -ring_d/2, 0])
            cube([ring_d,
                  (ring_d-outer_shaft_d)/2, ring_t]);
        translate([-ring_d/2, outer_shaft_d/2, 0])
            cube([ring_d,
                  (ring_d-outer_shaft_d)/2, ring_t]);
    }


// main shaft
translate([0,0,-main_shaft_l-ring_t])
    cylinder(d=main_shaft_d, h=main_shaft_l);
// key handle
translate([-key_handle_w/2,
           -key_handle_t/2,
           -main_shaft_l-ring_t-key_handle_h])
    difference(){
        cube([key_handle_w, key_handle_t, key_handle_h]);
        translate([3, 0, 3])
        cube([key_handle_w-6,
              key_handle_t,
              key_handle_h-6]);
    }