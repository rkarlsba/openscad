$fn = $preview ? 8 : 64;
// logo_file = "oslomet-logo-2134x1492.png";
// logo_file = "oslomet-logo-1067x746.png";
// logo_file = "oslomet-logo-533x373.png";
// logo_file = "oslomet-logo-267x186.png";
logo_file = "oslomet-logo.png";

intersection() {
    scale([0.1, 0.1, 10])
        surface(file=logo_file);
    translate([0,0,1])
        cube([50,30,1]);
}