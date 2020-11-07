micro_sd_x = 11;
micro_sd_y = 15;
micro_sd_z = 1;
padding = 3;

micro_sd_slots = 12;

module micro_sd_kort(extra_x = 0, extra_y = 0, extra_z = 0) {
    translate([-extra_x/2,-extra_y/2,-extra_z/2])
        cube([micro_sd_x+extra_x,micro_sd_y+extra_y,micro_sd_z+extra_z]);    
}

module micro_sd_blokk() {
    micro_sd_blokk_y = micro_sd_z*padding*(1.5+micro_sd_slots);
    micro_sd_blokk_x = micro_sd_x+padding*2;
    micro_sd_blokk_z = micro_sd_y+padding-padding;
    cube([micro_sd_blokk_x,micro_sd_blokk_y,micro_sd_blokk_z]);
}

difference() {
    micro_sd_blokk();
    translate([0,0,0]) {
        for (i=[1:1:micro_sd_slots]) {
            echo("i is ", i);
            translate([padding,i*padding,micro_sd_y+padding]) {
                rotate([270,0,0]) {
                    micro_sd_kort(0.2,0,0);
                }
            }
        }
    }
}