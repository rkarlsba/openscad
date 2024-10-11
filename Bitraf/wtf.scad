// Deler per sirkel
$fn = 200;

// Variabler
vegg = 4;
id = 28;        // indre diameter
od = id+vegg*2; // ytre diameter
h = 30;         // høyde

// Magick goes here!!!!
linear_extrude(h) {
    difference() {
        circle(d=od);
        circle(d=id);
    }
}
