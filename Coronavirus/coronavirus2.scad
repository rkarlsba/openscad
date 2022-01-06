$fn=$preview?16:256;

radius=45;

mr=radius/100;

//mode="lasercut";
mode="3dprinted";

// if 3dprinted, set this
textheight=1.2;
thickness=3;

module circletext(mytext,textsize=20,myfont="Arial",radius=100,thickness=1,degrees=360,top=true) {

    chars=len(mytext)+1;
    for (i = [1:chars]) {
        rotate([0,0,(top?1:-1)*(degrees/2-i*(degrees/chars))])
            translate([0,(top?1:-1)*radius-(top?0:textsize/2),0])
                //linear_extrude(thickness)
                    text(mytext[i-1],halign="center",font=myfont,size=textsize);
    }
}


module stubbe() {
    translate([-radius/6.7,radius,0]) hull() {
        translate([mr*6,0]) circle(r=mr*10);
        translate([mr*24,0]) circle(r=mr*10);
        translate([mr*15,mr*30]) scale([1,0.3,1]) circle(r=mr*27);
    }
}

module liten_stubbe() {
    translate([0,radius,0]) hull() {
        translate([mr,0]) scale([1,0.3,1]) circle(r=mr*10);
        translate([mr,mr*15]) scale([1,0.3,1]) circle(r=mr*10);
    }
    translate([0,radius,0]) {
        translate([mr,mr*15]) scale([1,0.2,1]) circle(r=mr*19);
    }

}

module eiker(antall) {
    eikebredde=radius/20;
    eikelengde=radius/10*9;
    navradius=radius/10*2;
    difference() {
        difference() {
            circle(r=radius*.9);
            for (i=[1:antall]) {
                a=(360/antall)*i;
                rotate([0,0,a]) {
                    translate([-eikebredde/2,0]) {
                        square([eikebredde,eikelengde]);
                    }
                }
            }
            circle(r=navradius);
        }
    }
}

module virus(knotter=8, tekst="", font="Arial", logo="", eiker=false, mode="lasercut", textheight=0, thickness=0) {
    if (mode == "lasercut") {
        difference() {
            union() {
                circle(r=radius);
                for (i=[1:knotter]) {
                    a=(360/knotter)*i;
                    rotate([0,0,a]) {
                        liten_stubbe();
                    }
                }
            }
            if (eiker) {
                eiker(knotter);
            }
            /*
            translate([-radius*.85,-radius*.1]) {
                text(tekst,size=radius*.3,font=font);
            }
            */
            if (tekst != "") {
                tekststr=radius*.17;
                circletext(tekst,myfont=font,textsize=tekststr,degrees=140,radius=radius-tekststr*1.8,top=true);
            }
            if (logo != "") {
                translate([-radius*.53,-radius*.8]) scale([radius/115,radius/115]) {
                    import(logo);
                }
            }
        }
    } else if (mode == "3dprinted") {
        if (textheight <= 0) { echo("really? textheight = ", textheight, "?"); }
        if (thickness <= 0) { echo("really? thickness = ", thickness, "?"); }
        linear_extrude(thickness) {
            union() {
                circle(r=radius);
                for (i=[1:knotter]) {
                    a=(360/knotter)*i;
                    rotate([0,0,a]) {
                        liten_stubbe();
                    }
                }
            }
        }
        translate([0,0,thickness]) {
            linear_extrude(textheight) {
                if (eiker) {
                    eiker(knotter);
                }
                /*
                translate([-radius*.85,-radius*.1]) {
                    text(tekst,size=radius*.3,font=font);
                }
                */
                if (tekst != "") {
                    tekststr=radius*.17;
                    circletext(tekst,myfont=font,textsize=tekststr,degrees=140,radius=radius-tekststr*1.8,top=true);
                }
                if (logo != "") {
//                    translate([-radius*.53,-radius*.8]) scale([radius/115,radius/115]) {
//                }
                    scale([0.65,0.65]) {
                        translate([-radius*.8,-radius*3]) {
                            import(logo);
                        }
                    }
                }
            }
        }
    } else {
        echo("Dunno what to do with mode '", mode);
    }
}
t="SARS-CoV-2";
//t="Covid-19";
f="Baskerville:style=Bold";
virus(knotter=9, tekst=t, font=f, logo="qtipd_Syringe.svg", mode=mode, textheight=textheight, 
    thickness=thickness);
//virus(knotter=12, logo="coffee.svg");
//virus(knotter=12, eiker=true);
