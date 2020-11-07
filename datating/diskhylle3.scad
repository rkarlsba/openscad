
disk35height = 26.1;
disk35widht = 101.3;
disk35length = 146;

module disk35(trans = [0,0,0], height=disk35height) {    
    translate(trans) {
        cube([height,disk35length,disk35widht]);
    }
}

// Standarddybde er 203.2mm, men det er det kanskje greit å skjære av i blant.
module ramme(trans = [0,0,0], length = disk35length, disker=1) {
    translate(trans) {
        difference() {
            cube([146.1,depth,41.3]);
            translate([0.5,0,0.5]) {
                cube([145.1,depth,40.3]);
            }
        }
    }
}

// Hvis vi har 15mm høye disker (ikke så vanlig)
module 4disk(trans = [0,0,0]) {
    translate(trans) {
        disk35(trans = [2,1,2]);
        disk35(trans = [2,1,22]);
        disk35(trans = [73.85,1,2]);
        disk35(trans = [73.85,1,22]);
    }
}


//ramme();
//4disk();
translate([10,0,0]) {
    disk35();
}
translate([disk35height+20,0,0]) {
    disk35();
}
translate([disk35height*2+30,0,0]) {
    disk35();
}
translate([disk35height*3+40,0,0]) {
    disk35();
}