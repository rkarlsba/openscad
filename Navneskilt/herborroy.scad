$fn = $preview ? 8 : 64;
font = "Vegetable:style=Regular";

x=100;
y=70;
h=2;
s=2;
w=0.25;

module roy(x,y,tykkelse,r=3) {
    linear_extrude(tykkelse) {
        difference()
        {
            hull() {
                translate([0,0,0]) circle(r=r);
                translate([x,0,0]) circle(r=r);
                translate([0,y,0]) circle(r=r);
                translate([x,y,0]) circle(r=r);
            }
            translate([8,y-20,0]) {
                text("Her bor", size=13, font=font);
            }
            translate([14,12,0])
                text("Roy", size=21, font=font, spacing=1.3);
        }
    }
}

/*
 * module hatch(x,y,w,s=w,a=0,h=2);
 * x == width
 * y == height
 * w == width of hatching
 * s == spacing between hatch lines (0 means same as w)
 * a == hatch angle
 * h == hatch height
 */
module hatch(x,y,w,s=0,a=0,h=2) {
    s = (s == 0) ? w : s;
    for (yy = [0 : (s+w) : y]) {
        //echo("translate([0,", yy, ",0]) cube([", x, ",", w, ",", h, "]);");
        translate([0,yy,0]) {
            cube([x,w,h]);
        }
    }
    
    for (xx = [0 : (s+w) : x]) {
        //echo("translate([", xx, ", 0,0]) cube([", w, ",", y, ",", h, "]);");
        translate([xx,0,0]) {
            cube([w,y,h]);
        }
    }
}

intersection() {
    cube([x,y,h]);
    translate([20,-50,0])
        rotate([0,0,30])
            hatch(x=200,y=200,w=w,s=s,h=h);
}

roy(x,y,h);
