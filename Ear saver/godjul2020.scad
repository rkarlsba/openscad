fontface="Apple Chancery";
//fontface="Savoye LET";
//fontface="Zapfino";
fontsize=8;

linear_extrude(1) {
    translate([-22,0]) {
        text("God jul", font=fontface, size=fontsize);
        translate([22.6,-4.7])
            text("2020", font=fontface, size=fontsize-3);
    }
}