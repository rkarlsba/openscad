// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker

x = 60;
y = 40;
z = 20;
th = 1;
font = ".New York";

render(convexity=4) {
    difference() {
        cube([x,y,z]);
        union() {
            translate([x/20,y/1.5,z-th]) {
                linear_extrude(th) {
                    text(text="OpenSCAD", size=x/7.5, font=font);
                }
            }
            translate([x/40,y/5,z-th]) {
                linear_extrude(th) {
                    text(text=str(x, "x", y, "x", z), size=x/6, font=font);
                }
            }
        }
    }
}
