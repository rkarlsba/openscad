module bullet() {
    translate([30,80,26]) {
        import("/Users/roy/Downloads/bulletpuzzle/bulletsfinalpuzzle.stl");
    }
}

module b1() {
    difference() {
        bullet();
        cube([15,15,80]);
    }
}

b1();

