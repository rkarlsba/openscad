// vim:ts=4:sw=4:sts=4:et:ai

$fn=64;

module circletext(mytext,textsize=20,myfont="Arial",radius=100,thickness=1,degrees=360,top=true) {
    chars=len(mytext)+1;
    for (i = [1:chars]) {
    rotate([0,0,(top?1:-1)*(degrees/2-i*(degrees/chars))])
        translate([0,(top?1:-1)*radius-(top?0:textsize/2),0])
            //linear_extrude(thickness)
                text(mytext[i-1],halign="center",font=myfont,size=textsize);
    }
}

height = 2.5;
inner_d = 20;
outer_d = 57.5;
kuttekant = 0.5;

difference() {
    cylinder(h=height,d=outer_d-kuttekant*2);
    cylinder(h=height,d=inner_d+kuttekant*2);
}

//circletext("My text goes here",textsize=20,degrees=160,top=true);
//circletext("Text can be underneath as well",textsize=15,degrees=180,top=false);
