bredde=45;
dybde=9.5;
hoyde=18;
veggtykkelse=2;
slakk=1;

linear_extrude(bredde) {
    difference() {
        square([hoyde+veggtykkelse,veggtykkelse*2+dybde]);
        translate([0, veggtykkelse]) {
            square([hoyde,dybde]);
        }
        rotate([0, 0, 45]) {
            square([dybde*sqrt(sqrt(2)),dybde*sqrt(sqrt(2))]);
        }
    }
}
