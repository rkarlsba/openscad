$fn = $preview ? 8 : 24;
font = "Vegetable:style=Regular";

x=100;
y=70;
z=1;
s=2;
r=4;
w=0.25;

module royplate(x,y,z,r) {
    linear_extrude(z) {
        difference()
        {
            hull() {
                translate([r,r,0]) circle(r=r);
                translate([x-r,r,0]) circle(r=r);
                translate([r,y-r,0]) circle(r=r);
                translate([x-r,y-r,0]) circle(r=r);
            }
            translate([10,y-21,0]) {
                text("Her bor", size=12, font=font);
            }
            translate([15,12,0]) {
                text("Roy", size=21, font=font, spacing=1.3);
            }
        }
    }
}

module herborroy(x,y,z) {
    linear_extrude(z) {
        translate([10,y-21,0]) {
            text("Her bor", size=12, font=font);
        }
        translate([15,12,0]) {
            text("Roy", size=21, font=font, spacing=1.3);
        }
    }
}

/*
 * module hatch(x,y,w,s=w,a=0,z=2);
 * x == width
 * y == height
 * w == width of hatching
 * s == spacing between hatch lines (0 means same as w)
 * a == hatch angle
 * z == hatch height
 */
module hatch(x,y,w,s=0,a=0,z=2) {
    s = (s == 0) ? w : s;
    for (yy = [0 : (s+w) : y]) {
        //echo("translate([0,", yy, ",0]) cube([", x, ",", w, ",", z, "]);");
        translate([0,yy,0]) {
            cube([x,w,z]);
        }
    }
    
    for (xx = [0 : (s+w) : x]) {
        //echo("translate([", xx, ", 0,0]) cube([", w, ",", y, ",", z, "]);");
        translate([xx,0,0]) {
            cube([w,y,z]);
        }
    }
}

module avrundaramme(x,y,z,r) {
    linear_extrude(z) {
        hull() {
            translate([r,r,0]) circle(r=r);
            translate([x-r,r,0]) circle(r=r);
            translate([r,y-r,0]) circle(r=r);
            translate([x-r,y-r,0]) circle(r=r);
        }
    }
}

module ramme(bredde) {
    difference() {
        cube([x,y,z]);
        translate([bredde,bredde,0]) {
            cube([x-bredde*2,y-bredde*2,z]);
        }
    }
}


cube([x,y,z]);
translate([0,0,z]) {
    intersection() {
        cube([x,y,z]);
        translate([20,-50,0])
            rotate([0,0,30])
                hatch(x=200,y=200,w=w,s=s,z=z);
    }
    translate([0,0,z]) {
        herborroy(x,y,z);
        ramme(z);
    }
}

/*
avrundaramme(x,y,z,r);
*/
difference() {
    herborroy(x,y,z);
    avrundaramme(x,y,z,r);
}
