$fn=$preview ? 16 : 64;

inch=25.4; // Set to 1.0 if you're in inch-land
w=7;
l=5*inch;
h=inch/2;
hl=2*inch;
h2=inch/2;
pin_d=w/2;
pin_h=10;
clearance=0.1;
logotext="Ullevål kaffeslabberas";
logospacing=1.2;
xlogo=true;
ylogo=false;
font="Copperplate Normal";
fontsize=7;
test=false;

echo(test);

module logo() {
    rotate([90,0,0])
        linear_extrude(height=2)
            text(logotext, font=font, size=fontsize, spacing=logospacing);
}

module arm(length, height=h, up=0, cut_corners = 1, text=undef) {
    difference() {
        if (up)  {
            difference() {
                translate([0,w,0])
                    cube([w,length-w,height]);
                if (cut_corners)
                    translate([0,length,0])
                        rotate([0,0,-45])
                            cube([w*2,w*2,height]);
            }
        } else {
            difference() {
                translate([w,0,0])
                    cube([length-w,w,height]);
                if (cut_corners)
                    translate([length,0,0])
                        rotate([0,0,45])
                            cube([w*2,w*2,height]);
            }
        }
    }
}


if (test) {
    translate([(test ? 0 : l-hl),0,test ? 0 : h])
        arm(hl, h2);
    translate([(test ? 0 : l-hl)+w+h,w/2,(test ? 0 : h)+h2])
        cylinder(d=pin_d-clearance, h=pin_h-1);
    translate([(test ? 0 : l-hl)+w+h*2,w/2,(test ? 0 : h)+h2])
        cylinder(d=pin_d-clearance, h=pin_h-1);
    
    translate([0,test ? -2 : 0,0]) 
        rotate([0,0,test ? 270 : 0])
            difference() {
                translate([0,(test ? 0 : l-hl),test ? 0 : h])
                    arm(hl, h2, up=1);
                translate([w/2,(test ? 0 : l-hl)+w+h,(test ? 0 : h)+h2-pin_h+1])
                    cylinder(d=pin_d+clearance, h=pin_h+1);
                translate([w/2,(test ? 0 : l-hl)+w+h*2,(test ? 0 : h)+h2-pin_h+1])
                    cylinder(d=pin_d+clearance, h=pin_h+1);
            }
} else {
    // Corner
    difference() {
        translate([w,w,0])
            cylinder(d=w*2,h=h);
        translate([w*2,w*2,0])
            cylinder(d=w*2,h=h);
    }
    difference() {
        arm(l);
        if (xlogo)
            translate([10,2,3])
                logo();
    }

    translate([l-hl,0,h])
        arm(hl, h2);
    translate([l-hl+w+h,w/2,h+h2])
        cylinder(d=pin_d-clearance, h=pin_h-1);
    translate([l-hl+w+h*2,w/2,h+h2])
        cylinder(d=pin_d-clearance, h=pin_h-1);

    difference() {
        arm(l, up=1);
        if (ylogo)
            rotate([0,0,270])
                translate([-125,2,3])
                    logo();
    }
    difference() {
        translate([0,l-hl,h])
            arm(hl, h2, up=1);
        translate([w/2,l-hl+w+h,h+h2-pin_h+1])
            cylinder(d=pin_d+clearance, h=pin_h+1);
        translate([w/2,l-hl+w+h*2,h+h2-pin_h+1])
            cylinder(d=pin_d+clearance, h=pin_h+1);
    }
}
//