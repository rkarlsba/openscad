// cube side length
side=20;
// font size percentage
ptext=side*0.7;
// letters depth
depth=1;

cube_xyz(side,ptext,depth);

module cube_xyz(i_side,i_ptext,i_depth) {
	insurance=0.1;
	
	difference() {
		cube(i_side,true);
		
		translate([(i_side/2)-i_depth,0,0])
            rotate(a=[90,0,90])
                linear_extrude(i_depth+insurance)
                    text("X",size=i_ptext,halign="center",valign="center");
		
		translate([0,((i_side/2)+insurance),0])
            rotate(a=[90,90,0])
                linear_extrude(i_depth+insurance)
                    text("Y",size=i_ptext,halign="center",valign="center");
		
		translate([0,0,(i_side/2)-i_depth])
            linear_extrude(i_depth+insurance)
                text("Z",size=i_ptext,halign="center",valign="center");
	}
}
