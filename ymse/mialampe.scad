fn=128;
//fn=16;
hoyde=200;
bredde_nede=100;
bredde_oppe=40;
tykkelse=1;
kuppelbredde=180;
strekk=1.4;

// stamme
module stamme () {
    difference() {
        cylinder(h=hoyde, d1=bredde_nede, d2=bredde_oppe, $fn=fn);
        translate([0,0,-tykkelse]) {
            cylinder(h=hoyde, d1=bredde_nede-tykkelse, d2=bredde_oppe-tykkelse, $fn=fn);
        }
    }
}

module kuppel() {
    module kuppelgreie(moderator=0) {
        k=kuppelbredde+moderator;
        difference() {
            sphere(d=k, $fn=fn);
            translate([-k/2,-k/2,-k]) {
                cube([k,k,k]);
            }
        }
    }
    scale([1,1,1/strekk]) {
        difference() {
            kuppelgreie();
            translate([0,0,-tykkelse]) {
                kuppelgreie(-tykkelse);
            }
        }
    }
}

stamme();
// kuppel
translate([200,0,0]) {
    kuppel();
}