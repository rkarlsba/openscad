$fn=64;
//$fn=16;

diameter=210;
width=12;
thickness=3;
hulldim=5;
logo="Ullevål B21";
font="Copperplate:style=Bold";
textheight=1.5;
fontsize=10;
fontspacing=1;
in_height=30;
pin_length=10;
pin_diameter=4;
clearance=0.1;

module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}  

module xor() {
  difference() {
    for(i = [0 : $children - 1])
      children(i);
    intersection_for(i = [0: $children -1])
      children(i);
  }                                
} 

module gitter(hann=true) {
    module pinner(hann=true) {
        translate([-diameter/2+width/2,width/2,0]) {
            xor() {
                cylinder(d=width,h=in_height);
                translate([0,0,hann ? in_height : in_height-pin_length])
                    cylinder(d=pin_diameter,h=pin_length);
            }
        }
        translate([diameter/2-width/2,width/2,0]) {
            xor() {
                cylinder(d=width,h=in_height);
                translate([0,0,hann ? in_height : in_height-pin_length])
                    cylinder(d=pin_diameter,h=pin_length);
            }
        }
        translate([0,diameter/2-width/2,0]) {
            xor() {
                cylinder(d=width,h=in_height);
                translate([0,0,hann ? in_height : in_height-pin_length])
                    cylinder(d=pin_diameter,h=pin_length);
            }
        }
        translate([(diameter/2-width/2)/sqrt(2)-5,(diameter/2-width/2)/sqrt(2)+4.5,0]) {
            xor() {
                cylinder(d=width,h=in_height);
                translate([0,0,hann ? in_height : in_height-pin_length])
                    cylinder(d=pin_diameter,h=pin_length);
            }
        }
        translate([-(diameter/2-width/2)/sqrt(2)+5,(diameter/2-width/2)/sqrt(2)+4.5,0]) {
            xor() {
                cylinder(d=width,h=in_height);
                translate([0,0,hann ? in_height : in_height-pin_length])
                    cylinder(d=pin_diameter,h=pin_length);
            }
        }
    }

    module innergitter() {
        difference() {
            sector(h=thickness,d=diameter,a1=0,a2=180);
            sector(h=thickness,d=diameter-width*2,a1=0,a2=180);
        }
        translate([-diameter/2+width,0,0])
            cube([diameter-width*2,width,thickness]);
        translate([-width/2,0,0])
            cube([width,diameter/2-width,thickness]);
        translate([-width/2,width,0])
            rotate([0,0,-45])
                cube([width,diameter/2-width,thickness]);
        translate([-width/2,width/2,0])
            rotate([0,0,45])
                cube([width,diameter/2-width,thickness]);
    }

    module monteringshull() {
        translate([-diameter*.3,width/2,0])
            cylinder(h=thickness,d=pin_diameter);
        translate([diameter*.3,width/2,0])
            cylinder(h=thickness,d=pin_diameter);
    }
    
    module logo(hann=true) {
        if (hann) {
            rotate([180,0,0])
                translate([-44,-10,-textheight])
                    linear_extrude(height=textheight)
                        text(logo, font=font, size=fontsize, spacing=fontspacing);
        } else {
            translate([-44,2,thickness-textheight])
                linear_extrude(height=textheight)
                    rotate([0,0,0])
                        text(logo, font=font, size=fontsize, spacing=fontspacing);
        }
    }


    difference() {
        innergitter();
        translate([-diameter/2,0,0])
            cylinder(d=width,h=in_height);
        translate([diameter/2,0,0])
            cylinder(d=width,h=in_height);
        logo(hann);
        if (!hann)
            monteringshull();
    }
    pinner(hann);
}


gitter(hann=true);

