$fn = $preview ? 16 : 64;

font="Copperplate Normal";
name="Sicko";

difference() {
    cube([54,20,3]);
    translate([1.4, 1, 1]) {
        linear_extrude(2)
            text(name,font=font,size=15.3);
        translate([15.7,10.4,0])
            cube([0.5,3,1]);
        translate([4,0,0])
            cube([42,1,1]);
    }
}