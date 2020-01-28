$fn=64;

inch=25.4; // Set to 1.0 if you're in inch-land
w=7;
l=5*inch;
h=inch/2;
hl=2*inch;
h2=inch;
pin_d=w/2;
pin_h=10;
clearance=0.1;
logo="Ullevål B21";
font="Copperplate Normal";
fontsize=7;
test=true;

echo(test);

module logo() {
    rotate([90,0,0]) linear_extrude(height=2) text(logo, font=font, size=fontsize);
}

module arm(length, height=h, up=0, cut_corners = 1, text=undef) {
    difference() {
        if (up)  {
            difference() {
                translate([0,w,0]) cube([w,length-w,height]);
                if (cut_corners) translate([0,length,0]) rotate([0,0,-45]) cube([w*2,w*2,height]);
            }
        } else {
            difference() {
                translate([w,0,0]) cube([length-w,w,height]);
                if (cut_corners) translate([length,0,0]) rotate([0,0,45]) cube([w*2,w*2,height]);
            }
        }
    }
}


if (test) {
    translate([(test ? 0 : l-hl),0,test ? 0 : h]) arm(hl, h2);
    translate([(test ? 0 : l-hl)+w+h,w/2,(test ? 0 : h)+h2]) cylinder(d=pin_d-clearance, h=pin_h-1);
    translate([(test ? 0 : l-hl)+w+h*2,w/2,(test ? 0 : h)+h2]) cylinder(d=pin_d-clearance, h=pin_h-1);
    
    translate([0,test ? -2 : 0,0]) 
        rotate([0,0,test ? 270 : 0])
            difference() {
                translate([0,(test ? 0 : l-hl),test ? 0 : h]) arm(hl, h2, up=1);
                translate([w/2,(test ? 0 : l-hl)+w+h,(test ? 0 : h)+h2-pin_h+1]) cylinder(d=pin_d+clearance, h=pin_h+1);
                translate([w/2,(test ? 0 : l-hl)+w+h*2,(test ? 0 : h)+h2-pin_h+1]) cylinder(d=pin_d+clearance, h=pin_h+1);
            }
} else {
    // Corner
    difference() {
        translate([w,w,0]) cylinder(d=w*2,h=h);
        translate([w*2,w*2,0]) cylinder(d=w*2,h=h);
    }
    difference() {
        arm(l);
        translate([10,2,3]) logo();
    }

    translate([l-hl,0,h]) arm(hl, h2);
    translate([l-hl+w+h,w/2,h+h2]) cylinder(d=pin_d-clearance, h=pin_h-1);
    translate([l-hl+w+h*2,w/2,h+h2]) cylinder(d=pin_d-clearance, h=pin_h-1);

    difference() {
        arm(l, up=1);
        rotate([0,0,270]) translate([-59,2,3]) logo();
    }
    difference() {
        translate([0,l-hl,h]) arm(hl, h2, up=1);
        translate([w/2,l-hl+w+h,h+h2-pin_h+1]) cylinder(d=pin_d+clearance, h=pin_h+1);
        translate([w/2,l-hl+w+h*2,h+h2-pin_h+1]) cylinder(d=pin_d+clearance, h=pin_h+1);
    }
}

//arm(
// X
/*translate([w,0,0]) cube([l-w,w,h]);
translate([l-hl+w,0,h]) cube([hl-w,w,h]);
difference() {
    translate([l,0,0]) rotate([0,0,45]) cube([w*2,w*2,h2]);
}

translate([l-hl,0,h]) {
    difference() {
//        translate([w,0,0]) cube([hl-w,w,h]);
//        translate([l,0,0]) rotate([0,0,45]) cube([w*2,w*2,h]);
    }
}

// Y
difference() {
    translate([0,w,0]) cube([w,l-w,h]);
    translate([0,l,0]) rotate([0,0,-45]) cube([w*2,w*2,h]);
}

*/