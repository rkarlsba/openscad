$fn=$preview ? 16 : 64;

inch=25.4; // Set to 1.0 if you're in inch-land
w=7;
l=5*inch;
h=inch/2;
hl=2*inch;
h2=inch/2;
pin_d=w/2;
pin_h=10;
clearance=0.2;
logotext="Varme tanker, god kaffe";
logospacing=1.2;
logoonly=false;
xlogo=true;
ylogo=true;
font="Copperplate Normal";
fontsize=5;

test=false;

separatepins=true;

pinsonly=false;
pincount=0;
idiot=false;

assert(!idiot, "IDIOT!!!!!!");

module logo(s="", stretch = 1) {
    s = (s=="") ? logotext : s;
    
    rotate([180,0,0]) {
        linear_extrude(height=2) {
            scale([stretch,1,1]) {
                text(s, font=font, size=fontsize, spacing=logospacing);
            }
        }
    }
}

module arm(length, height=h, up=0, cut_corners = 1, text=undef, extender=0) {
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

module drawpins(count=1) {
    echo("PIN: cylinder(d=", pin_d-clearance, ", h=", (pin_h-2)*2, ")");
    if (count > 0) {
        for ( pin = [0 : count-1] ) {
            translate([pin_d*pin*2,0,0]) {
                if (idiot) {
                    cylinder(d=pin_d-clearance/2, h=(pin_h-2));
                    translate([0,0,pin_h-2])
                        cylinder(d=pin_d-clearance*3, h=(pin_h-2));
                } else {
                    cylinder(d=pin_d-clearance, h=(pin_h-2)*2);
                }
            }
        }
    }
}

if (test) {
    if (!separatepins) {
        translate([(test ? 0 : l-hl),0,test ? 0 : h])
            arm(hl, h2);
        translate([(test ? 0 : l-hl)+w+h,w/2,(test ? 0 : h)+h2])
            cylinder(d=pin_d-clearance, h=pin_h-1);
        translate([(test ? 0 : l-hl)+w+h*2,w/2,(test ? 0 : h)+h2])
            cylinder(d=pin_d-clearance, h=pin_h-1);
    }
    
    translate([0,test ? -2 : 0,0]) {
        rotate([0,0,test ? 270 : 0]) {
            difference() {
                translate([0,(test ? 0 : l-hl),test ? 0 : h])
                    arm(hl, h2, up=1);
                translate([w/2,(test ? 0 : l-hl)+w+h,(test ? 0 : h)+h2-pin_h+1])
                    cylinder(d=pin_d+clearance, h=pin_h+1);
                translate([w/2,(test ? 0 : l-hl)+w+h*2,(test ? 0 : h)+h2-pin_h+1])
                    cylinder(d=pin_d+clearance, h=pin_h+1);
            }
        }
    }
    if (separatepins) {
        translate([10,5,0])
            drawpins(count=2);
    }
} else if (pinsonly) {
    drawpins(count=pincount);
} else if (logoonly) {
    if (xlogo)
        translate([25,6,0])
            logo("Varme tanker",1.6);
    if (ylogo)
        rotate([0,0,270])
            translate([-100,6,0])
                logo("God kaffe", 1.8);
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
            translate([25,6,0])
                logo("Varme tanker",1.6);
        if (ylogo)
            rotate([0,0,270])
                translate([-95,6,0])
                    logo("God kaffe", 1.8);
    }

    if (separatepins) {
        echo("HOLE: cylinder(d=", pin_d+clearance, ", h=", pin_h+1);
        difference() {
            translate([l-hl,0,h])
                arm(hl, h2);
            translate([l-hl+w+h,w/2,h+h2-pin_h+1])
                cylinder(d=pin_d+clearance, h=pin_h+1);
            translate([l-hl+w+h*2,w/2,h+h2-pin_h+1])
                cylinder(d=pin_d+clearance, h=pin_h+1);
        }
        
        translate([20,20,0])
            drawpins(count=pincount);
    } else {
        translate([l-hl,0,h])
            arm(hl, h2);
        translate([l-hl+w+h,w/2,h+h2])
            cylinder(d=pin_d-clearance, h=pin_h-1);
        translate([l-hl+w+h*2,w/2,h+h2])
            cylinder(d=pin_d-clearance, h=pin_h-1);
    }

    difference() {
        arm(l, up=1);
        if (ylogo)
            rotate([0,0,270])
                translate([-95,6,0])
                    logo("God kaffe", 1.8);
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