    // Legger inn denne som 15mm, siden det finnes disker som er så høye.
module disk(trans = [0,0,0], height=15) {
    translate(trans) {
        cube([69.85,100.45,height]);
    }
}

// Standarddybde er 203.2mm, men det er det kanskje greit å skjære av i blant.
module ramme(trans = [0,0,0], depth = 203.2) {
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
        disk(trans = [2,1,2]);
        disk(trans = [2,1,22]);
        disk(trans = [73.85,1,2]);
        disk(trans = [73.85,1,22]);
    }
}

// Hvis vi har 9mm høye disker (vanlig)
module 6disk(trans = [0,0,0]) {
    translate(trans) {
        disk(height = 9, trans = [2,1,2]);
        disk(height = 9, trans = [2,1,15]);
        disk(height = 9, trans = [2,1,28]);
        disk(height = 9, trans = [73.85,1,2]);
        disk(height = 9, trans = [73.85,1,15]);
        disk(height = 9, trans = [73.85,1,28]);
    }
}

// Hvis vi har 5mm høye disker (vanlig på SSD-er)
module 8disk(trans = [0,0,0]) {
    translate(trans) {
        disk(height = 5, trans = [2,1,2]);
        disk(height = 5, trans = [2,1,12]);
        disk(height = 5, trans = [2,1,22]);
        disk(height = 5, trans = [2,1,31]);
        disk(height = 5, trans = [73.85,1,2]);
        disk(height = 5, trans = [73.85,1,12]);
        disk(height = 5, trans = [73.85,1,22]);
        disk(height = 5, trans = [73.85,1,31]);
    }
}

ramme(depth = 120);
4disk();