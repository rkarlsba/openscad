_w=175;
w_corr=-10;
w=_w+w_corr;
h=130;
d1=3;
d2=9.5;


front_poly = [
    [0,0], [w,0],
    [w,h-12], [w-12,h],
    [0,h], 
    
];

cut_poly =  [
    [0,0], [55,30],
    [w-55,30], [w,0],
];

if (0)
difference() {
    linear_extrude(height=2.5) {
        difference() {
            polygon(front_poly);
            translate([2.5,10.8]) circle(d=d1);
            translate([w-2.5,10.8]) circle(d=d1);
            translate([2.5,h-4.5]) circle(d=d1);
            translate([w-2.5,h-15.5]) circle(d=d1);
            translate([31,29]) circle(d=d2);
            translate([68,21.5]) circle(d=d2);
            translate([105,21.5]) circle(d=d2);
            translate([w-31,29]) circle(d=d2);
        }
    }
    translate([0, 0, 1.5]) {
        linear_extrude(height=1) {
            polygon(cut_poly);
        }
    }
}

if (1)
linear_extrude(height=1) {
    difference() {
        polygon(cut_poly);
        translate([w_corr/2,0,0]) {
            translate([68,21.5]) circle(d=d2);
            translate([105,21.5]) circle(d=d2);
        }
    }
}
