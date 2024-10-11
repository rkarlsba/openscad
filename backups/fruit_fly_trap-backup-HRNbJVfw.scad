card = [100,150];
finger_width = 3;
finger_space = finger_width;
finger_length = 7;
edge_space = 9;

module teeth(upsidedown=false) {
    translate([0, upsidedown ? 0 : -finger_length]) {
        i = 0;
        for (x = [edge_space : finger_width+finger_space : card[0]-edge_space]) {
            echo(str("x = ", x, ", card[1]-edge_space = ", card[1]-edge_space));
            translate([x,0]) {
                square([finger_width, finger_length]);
            }
        }
    }
}

module card() {
    difference() {
        square(card);
        union() {
            teeth(true);
            translate([0,card[1]]) {
                teeth();
            }
        }
    }
}

card();