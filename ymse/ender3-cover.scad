x = 4*25.4;
y = 68;
height = 12;
thickness = 1.5;
xspace = 6;
yspace = 2;
font="Hoefler Text:style=Italic";
textsize=13;

intx = x + xspace;
inty = y + yspace;

difference() {
    cube([intx, inty, height]);
    translate([thickness,0,thickness]) {
        cube([intx-thickness*2, inty-thickness, height-thickness]);
    }
    translate([10,10,0]) {
        difference() {
            cube([intx-20,inty-20,0.4]);
            translate([1,1,0]) {
                cube([intx-22,inty-22,0.4]);
            }
            
        }
    }
    translate([87,40,0]) {
        linear_extrude(0.4) {
            mirror([1,0,0])
                text("Drøm", size=textsize, font=font);
        }
    }
    translate([60,20,0]) {
        linear_extrude(0.4) {
            mirror([1,0,0])
                text("søtt...", size=textsize, font=font);
        }
    }
}