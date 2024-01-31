module todelinjal(hoyde=topphoyde) {
    //rotate([0,0,20]) 
    {
        // 10mm index Marks
        for (i=[0:10:hoyde]) {
            translate([-2,i-.2]) {
                square([6, 0.4]);
            }
        }
        // 10mm text
        start = oppnedlinjal ? hoyde-1 : 10;
        stopp = oppnedlinjal ? 10 : hoyde-1;
        trinn = oppnedlinjal ? -10 : 10;
        echo(str("start er ", start, " og stopp er ", stopp, " og trinn er ", trinn));
        for (i=[start:trinn:stopp]) {
            echo(i);
            translate([5,i-1]) {
                text(str(i), size=2);
            }
            translate([-6,i-1]) {
                text(str(i), size=2);
            }
        }
        // 1mm index marks
        for (i=[0:1:hoyde]) {
            translate([0, i-.1]) {
                square([2, 0.2]);
            }
        }
    }
}
