$fn=$preview?16:256;

radius=45;

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
    mr=radius/100;
    translate([-radius/6.7,radius,0]) hull() {
        translate([mr*6,0]) circle(r=mr*10);
        translate([mr*24,0]) circle(r=mr*10);
        translate([mr*15,mr*30]) scale([1,0.3,1]) circle(r=mr*27);
    }
}

module liten_stubbe() {
    mr=radius/100;
    translate([0,radius,0]) hull() {
        translate([mr,0]) scale([1,0.3,1]) circle(r=mr*10);
        translate([mr,mr*15]) scale([1,0.3,1]) circle(r=mr*10);
    }
    translate([0,radius,0]) {
        translate([mr,mr*15]) scale([1,0.2,1]) circle(r=mr*19);
    }

}

module virus(knotter=8, tekst="", font="Arial") {
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
        /*
        translate([-radius*.85,-radius*.1]) {
            text(tekst,size=radius*.3,font=font);
        }
        */
        tekststr=radius*.17;
        circletext(tekst,myfont=font,textsize=tekststr,degrees=140,radius=radius-tekststr*1.8,top=true);
        translate([-radius*.53,-radius*.8]) scale([radius/115,radius/115]) import("coffee.svg");
    }
}
t="SARS-CoV-2";
//t="Covid-19";
f="Baskerville:style=Bold";
virus(knotter=9, tekst=t, font=f);
