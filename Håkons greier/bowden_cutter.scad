
$fn = 200;
preview_fix = $preview ? 0.1 : 0;

slack =             0.3;
bowden_od =         4 + slack;
block_width =       20;
block_half_h =      5;
cut_width =         0.5;
cover_either_side = 5;
max_len =           50;

difference() {
    cube([block_width, max_len + cover_either_side, block_half_h*2]);
    
    // half block cut
    translate([-preview_fix,0,block_half_h+preview_fix])
        cube([block_width+preview_fix*2, max_len - cover_either_side, block_half_h]);
    
    // bowden cutout
    translate([block_width/2,0,block_half_h])
        rotate([-90,0,0])
            cylinder(d=bowden_od,h=max_len+cover_either_side+preview_fix);
    
    // knife cutout
    cutouts();
}

module cutouts() {
    offsets = [0, 10, 20, 30, 40, 50];
    
    for(idx = [0 : len(offsets)-1]) {
        translate([
            -preview_fix, 
            max_len - offsets[idx]-(cut_width/2),
            block_half_h-bowden_od/2
        ]) {
            cube([block_width+preview_fix*2, cut_width, block_half_h+bowden_od/2+preview_fix]);
        }
    }
}