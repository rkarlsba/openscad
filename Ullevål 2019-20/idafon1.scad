x=83.15;
y=163.43;
z=12.34;

module iPhone6s() {
    translate([x/2,y/2,z/2]) 
        import("/Users/roy/driiiiit/Nextcloud/Dokumenter/Bitraf/3D-greier/Thingiverse/iPhone_6s_Plus_Case_-_Improved/files/iPhone_6SP_Case.stl", convexity=3);
}

difference() {
    iPhone6s();
}