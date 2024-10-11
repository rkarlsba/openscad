$fn = $preview ? 32 : 64;

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

// 2D
module bean(type=beanno, rot=0, coordinates=[0,0]) {
    translate(coordinates) {
        rotate([0,0,rot]) {
            scale([.05,.05]) {
                translate(coordinates) {
                    import(beans[type]);
                }
            }
        }
        if ($preview) {
            coo_s = str("[", coordinates[0], ",", coordinates[1], ",", coordinates[2], "]");
            translate([12,0,0]) mirror([1,0,0]) text(coo_s, size=2);
        }
    }
}

module gfx() {
    linear_extrude(theight) {
        translate([26+fontsize/2,-4-fontsize/6,-jall]) {
            mirror([1,0,0]) {
                text(text = "Kaffe", size=fontsize, font=font);
            }
        }
        bean(type=0, rot=30, coordinates=[-20,-54,-jall]);
        bean(type=1, coordinates=[-52,-4,-jall]);
        bean(type=2, rot=45, coordinates=[26,-34,-jall]);
        bean(type=0, rot=99, coordinates=[-5,-24,-jall]);
        bean(type=1, coordinates=[3,-54,-jall]);
        bean(type=2, rot=20, coordinates=[-41,-31,-jall]);
        bean(type=0, rot=3, coordinates=[5,32,-jall]);
        bean(type=1, coordinates=[-20,33,-jall]);
        bean(type=2, coordinates=[-31,26,-jall]);
        bean(type=2, rot=64, coordinates=[-26,6,-jall]);
        bean(type=0, rot=60, coordinates=[51,-15,-jall]);
        bean(type=2, rot=20, coordinates=[35,13,-jall]);
    }
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

            difference() {
                cylinder(d=inner_dim-bleed, h=height/2);
                cylinder(d=inner_dim-bleed-thickness*2+bleed, h=height/2);
            }
        }
        gfx();
    }
}

color ("black") lid();
// color ("red") gfx();