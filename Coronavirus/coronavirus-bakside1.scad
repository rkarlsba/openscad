$fn=$preview?16:256;

radius=45;
model_3d=true;

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
    }
}

//font="Baskerville:style=Bold";
font="Copperplate:style=Regular";
font="Helvetica:style=Normal";
tekst="Mot coronavirus hjelper denne lite, men på den kan din kopp få hvile.";
fontsize=4.5;

difference() {
    virus(knotter=9);
    circletext(tekst,textsize=fontsize,myfont=font,degrees=350,radius=radius*.82,top=true);
}
