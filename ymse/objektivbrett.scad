$fn = $preview ? 16 : 64;

x=70;
y=70;
d=50;
z=2;
riller=60;
rillelengde=7;
rillebredde=.5;
rillehoyde=.5;

linear_extrude(z) {
    difference() {
        translate([-x/2,-y/2]) {
            square([x,y]);
        }
        circle(d=d);
    }
}
for (i=[0:1:riller-1]) {
    rotate([0,0,i*(360/riller)]) {
        translate([d/2,-rillebredde/2,z]) {
            cube([rillelengde,rillebredde,rillehoyde]);
        }
    }
}