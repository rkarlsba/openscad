/*
difference() {
    import("/Users/roy/Downloads/Pen_Holder/penholder.stl");
    linear_extrude(height = 0.5) {
        text("Roys rare rot");
    }
}
*/
$fn=64;
difference() {
    import("/Users/roy/Downloads/Pen_Holder/penholder.stl");
    translate([23,7,0]) {
        linear_extrude(height = 1) {
            mirror([1,0,0]) text("Roys rare rot", size=5);
        }
    }
    translate([23,-4,0]) {
        linear_extrude(height = 1) {
            mirror([1,0,0]) text("roysrarerot.no", size=5);
        }
    }
}