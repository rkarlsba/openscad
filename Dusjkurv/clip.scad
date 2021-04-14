$fn=64;

difference() {
    union() {
        import("/Users/roy/Downloads/Shower_Pole_Utils_Tray/SUM_Clip_V1.5.stl");
    }
    translate([0,0,-4]) cube([40,2.2,25]);
}
