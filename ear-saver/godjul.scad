fontface="Apple Chancery";
//fontface="Savoye LET";
//fontface="Zapfino";
fontsize=9.5;
test=false;

if (test) {
    width=44;
    translate([-width/2,fontsize*1.5])
        cube([width,2,1]);
}
linear_extrude(1) {
    translate([-21,-6.5]) {
        text("God jul", font=fontface, size=fontsize);
    }
}
