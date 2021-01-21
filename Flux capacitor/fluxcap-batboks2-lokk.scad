jall = $preview ? .5 : 0;
x=90;
y=39;
z=20;
walls=1.5;
textheight=0.5;

difference() {
    hull() {
        cube([x-walls-1,y-wallsq*2,walls/2]);
        translate([walls*2,walls,walls/2]) {
            cube([x-walls-1-walls*4,y-walls*4,walls/2]);
        }
    }
    translate([5,20,walls-textheight]) {
        linear_extrude(textheight+jall) {
            text("Flux");
        }
    }
    translate([5,8,walls-textheight]) {
        linear_extrude(textheight+jall) {
            text("capacitor");
        }
    }
}