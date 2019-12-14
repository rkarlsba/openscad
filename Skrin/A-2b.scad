include </Users/roy/src/git/lasercut-box-openscad/box.scad>

module side(width,height,depth,dividers,inset,open,assemble) {
    $fn = 50;
    thickness = 3.3;
    finger_width = thickness*2;

    // Top

    box(
        width = width, 
        height = height, 
        depth = depth, 
        dividers = dividers, 
        ears = thickness*3, 
        thickness = thickness, 
        open = open, 
        assemble = assemble, 
        labels = true, 
        explode = 0,
        finger_width = finger_width,
        inset = inset
    );
}

module doublesided(width,height,depth,dividers,inset,open,assemble) {
    side(width=width,height=height,depth=depth,dividers=dividers,inset=inset,
         open=open,assemble=assemble);
    /*
    translate(rotate([0,0,180])) {
        side(width=width,height=height,depth=depth,dividers=dividers,inset=inset,
             open=open,assemble=assemble);
    }*/
}

//depth=150;

doublesided(width=75,height=40,depth=150,open=true,asseble=true,inset=0);









