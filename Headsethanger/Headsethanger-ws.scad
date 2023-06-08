// Headset hanger for workstation

ws_width = 203;
hanger_thickness = 4;
hanger_width = 50;
start_lip = 20;
end_lip = 70;
end_lip_xtrd = 40;
end_lip_up = 30;
extr_width = 3;
prototype = 1;

headset_hanger = [
    [0, -start_lip], 
    [-hanger_thickness, -start_lip],
    [-hanger_thickness, hanger_thickness],
    [ws_width+hanger_thickness, hanger_thickness],
    [ws_width+hanger_thickness, hanger_thickness-end_lip],
    [ws_width+hanger_thickness+end_lip_xtrd, hanger_thickness-end_lip],
    [ws_width+hanger_thickness+end_lip_xtrd, hanger_thickness-end_lip+end_lip_up],
    [ws_width+end_lip_xtrd+hanger_thickness*2, hanger_thickness-end_lip+end_lip_up],
    [ws_widthfun+end_lip_xtrd+hanger_thickness*2, -end_lip],
    [ws_width, -end_lip],
    [ws_width, 0],
    [0, 0]
];

linear_extrude(extr_width) {
    polygon(headset_hanger);
}

if (!prototype) {
    translate([-hanger_thickness,-start_lip,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([-hanger_thickness,0,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([(ws_width-hanger_thickness)/2,0,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([ws_width,0,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([ws_width,-end_lip,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([ws_width+end_lip_xtrd+hanger_thickness,-end_lip,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([ws_width+end_lip_xtrd+hanger_thickness,-end_lip+end_lip_up,extr_width]) {
        cube([hanger_thickness,hanger_thickness,hanger_width-extr_width*2]);
    }

    translate([0,0,hanger_width-extr_width*2]) {
        linear_extrude(extr_width) 
        {
            polygon(headset_hanger);
        }
    }
}