// Enkel boks - mål oppgitt er innvendige
// Skrevet av Roy Sigurd Karlsbakk <roy@karlsbakk.net>

h = 58;                 // Høyde
l = 84;                 // Lengde
b = 24;                 // Bredde
t = 3;                  // Tykkelse
pp = $preview ? .1 : 0; // Fiks for å få preview til å se vettugt ut

difference() {
    cube([b+t*2, l+t*2, h+t*2]);
    translate([t,t,t]) {
        cube([b, l, h+t+pp]);
    }
}