$fn = $preview ? 32 : 256;

// mode = "lid"; // "lid" or "graphics"
mode = "graphics"; // "lid" or "graphics"
jall = $preview ? .1 : 0;
bleed = 0.5;
height = 15;
theight = 0.2+jall*2;
thickness = 1.5;
tolerance = 1;
outer_dim = 112.5;
inner_dim = outer_dim-(thickness*2+tolerance); // 108.5;
font = "Papyrus:style=Regular";
fontsize = 21;
beans = [
    "/Users/roysk/Nextcloud/Inkscape/Kaffe/bean1.svg",
    "/Users/roysk/Nextcloud/Inkscape/Kaffe/bean2.svg",
    "/Users/roysk/Nextcloud/Inkscape/Kaffe/bean3.svg",
];
randseed = 98273684768;
beanspos_r = rands(-90, 90, 10000, randseed);

module bean(beanno, thickness=theight, rot=0) {
    linear_extrude(thickness) {
        rotate([0,0,rot]) {
            scale([.05,.05,.05]) {
                import(beans[beanno], dpi=96);
            }
        }
    }
}

module randbean(ex=[[-35,-10], [35,15]]) {
}

module graphics() {
    translate([26+fontsize/2,-4-fontsize/6,-jall]) {
        linear_extrude(theight) {
            mirror([1,0,0]) {
                text(text = "Kaffe", size=fontsize, font=font);
            }
        }
    }
    translate([-20,-40,-jall]) bean(0, rot=30);
    translate([-50,-14,-jall]) bean(1);
    translate([26,-34,-jall]) bean(2, rot=45);
    translate([-5,-24,-jall]) bean(0, rot=99);
    translate([3,-54,-jall]) bean(1);
    translate([-41,-40,-jall]) bean(2, rot=20);
    translate([5,32,-jall]) bean(0, rot=3);
    translate([-20,33,-jall]) bean(1);
    translate([-31,26,-jall]) bean(2);
    translate([51,-15,-jall]) bean(0, rot=60);
    translate([35,13,-jall]) bean(2, rot=20);
}

module lid() {
    difference() {
        union() {
            difference() {
                cylinder(d=outer_dim+thickness*2+bleed, h=height);
                translate([0,0,thickness]) {
                    cylinder(d=outer_dim+bleed, h=height-thickness+jall);
                }
            }

    //        if (0) 
            difference() {
                cylinder(d=inner_dim-bleed, h=height/2);
                // translate([0,0,thickness]) 
                {
                    cylinder(d=inner_dim-bleed-thickness*2+bleed, h=height/2);
                }
            }
        }
        graphics();
        /*
        union() {
            translate([26+fontsize/2,-4-fontsize/6,-jall]) {
                linear_extrude(theight) {
                    mirror([1,0,0]) {
                        text(text = "Kaffe", size=fontsize, font=font);
                    }
                }
            }
            translate([-20,-40,-jall]) bean(0, rot=30);
            translate([-50,-14,-jall]) bean(1);
            translate([26,-34,-jall]) bean(2, rot=45);
            translate([-5,-24,-jall]) bean(0, rot=99);
            translate([3,-54,-jall]) bean(1);
            translate([-41,-40,-jall]) bean(2, rot=20);
            translate([5,32,-jall]) bean(0, rot=3);
            translate([-20,33,-jall]) bean(1);
            translate([-31,26,-jall]) bean(2);
            translate([51,-15,-jall]) bean(0, rot=60);
            translate([35,13,-jall]) bean(2, rot=20);
        }
        */
    }
}

assert(mode == "lid" || mode == "graphics");

if (mode == "lid") {
    lid();
} else if (mode == "graphics") {
    graphics();
}