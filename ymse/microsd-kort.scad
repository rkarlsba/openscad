lokk = "/Users/roy/Downloads/Micro+SD+Card+Holder/files/microsdcardholdertopv1.stl";
logo = "/Users/roy/Nextcloud/Photos/MicroSD-Logo.svg";

difference() {
    translate([-75,75,0]) {
        rotate([90, 0, 0]) {
            import(lokk);
        }
    }
    translate([17,50,0]) {
    //    rotate([90, 0, 0]) {
        mirror([1,0,0]) {
            scale([4, 4]) {
                linear_extrude(0.7) {
                    import(logo);
                }
            }
        }
    }
}