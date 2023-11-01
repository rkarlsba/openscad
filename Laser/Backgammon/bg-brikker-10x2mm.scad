brikkedia = 10;
mellomrom = 2;
brikker_x = 5;
brikker_y = 4;
box_x=(brikkedia+mellomrom)*(brikker_x+1)*2;
box_y=(brikkedia+mellomrom)*(brikker_y+1)*2;
bord=0.2;
hoyde=2.6;
d=3;

if (d == 2) {
    translate([0,0]) {
        difference() {
            square([box_x,box_y]);
            translate([bord,bord]) {
                square([box_x-bord*2,box_y-bord*2]);
            }
        }
    }
}

if (d == 2) {
    translate([(brikkedia+mellomrom),(brikkedia+mellomrom)*2]) {
        for (x=[0:brikkedia+mellomrom:(brikkedia+mellomrom)*(brikker_x-1)]) {
            for (y=[0:brikkedia+mellomrom:(brikkedia+mellomrom)*(brikker_y-1)]) {
                //echo(str("x er ", x))
    //            echo (str("x er ",x," og y er ",y));;
                translate([x*2,y*2]) {
                    circle(d=brikkedia);       
                }
            }
        }
    }
} else if (d == 3) {
    linear_extrude(hoyde) {
        translate([(brikkedia+mellomrom),(brikkedia+mellomrom)]) {
            for (x=[0:brikkedia+mellomrom:(brikkedia+mellomrom)*(brikker_x-1)]) {
                for (y=[0:brikkedia+mellomrom:(brikkedia+mellomrom)*(brikker_y-1)]) {
                    //echo(str("x er ", x))
        //            echo (str("x er ",x," og y er ",y));;
                    translate([x,y]) {
                        circle(d=brikkedia);       
                    }
                }
            }
        }
    }
}