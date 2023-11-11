topphoyde = 62;
bunnhoyde = 12;
toppbredde = 60;
bunnbredde = 120;
tegn_figur=0;
tegn_linjal=1;
speil=1;
tykkelse=2;
trede=0;
oppnedlinjal=1;

/*
ytterkant = [
    [0, 0], [60, 0], 
    [60, 41.4], [58, 41.4],
    [57.3, 40], [56.6, 41.4],
    [45, 41.4], [17.3, 13.5],
    [0, 13.5], 
];

innerkant = [
    [0, 0], [14, 0],
    [14, 15.25]
];
*/
ytterkant = [
    [0, 0], [bunnbredde/2, 0], 
    [bunnbredde/2, topphoyde], [bunnbredde/2-2, topphoyde],
    [bunnbredde/2-2.7, topphoyde-1.4], [bunnbredde/2-3.4, topphoyde],
    [toppbredde/2, topphoyde],
    [0, bunnhoyde],
];

innerkant = [
    [0, 0], [14, 0],
    [14, 25]
];

module trekant() {
    translate([-bunnbredde/2,0]) {
        polygon(ytterkant);
    }
    translate([bunnbredde/2,0]) {
        if (speil) {
            mirror([1,0,0]) {
                polygon(ytterkant);
                echo("todetrekant?");
            }
        }
    }
}

module tredetrekant() {
    linear_extrude(tykkelse) {
        trekant();
        if (speil) {
            mirror([0,0,0]) {
                tredetrekant();
                echo("tredetrekant?");
            }
        }
    }
}

// denne trenger hjelp
module tredelinjal(hoyde=topphoyde,oppned=oppnedlinjal) {
    // 10mm index Marks
    for (i=[0:10:hoyde]) {
        translate([i-.2,0,0.9]) {
            cube([0.4, 4, 1.1]);
        }
    }
    // 10mm text
    start = oppnedlinjal ? hoyde-1 : 10;
    stopp = oppnedlinjal ? 10 : hoyde-1;
    for (i=[start:10:stopp]) {
        echo(i);
        translate([i-.8,8,0.9]) {
            linear_extrude(1.1) {
                rotate([0,0,270])
                text(str(i), size=2);
            }
        }
    }
    // 1mm index marks
    for (i=[0:1:hoyde]) {
        translate([i-.1,0,0.9]) {
            cube([0.2, 2, 1.1]);
        }
    }
}

// denne trenger hjelp
module todelinjal_drit(hoyde=topphoyde) {
    //rotate([0,0,20]) 
    {
        // 10mm index Marks
        for (i=[0:10:hoyde]) {
            translate([-2,i-.2]) {
                square([6, 0.4]);
            }
        }
        // 10mm text
        for (i=[start:10:stopp]) {
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

module todelinjal(hoyde=topphoyde) {
    // Variables
    start = oppnedlinjal ? hoyde : 10;
    stopp = oppnedlinjal ? 10 : hoyde;
    trinn = oppnedlinjal ? -10 : 10;

    // 10mm index Marks
    for (i=[start:trinn:stopp]) {
        translate([-2,i-.2]) {
            square([6, 0.4]);
        }
    }
    // 10mm text
    start = oppnedlinjal ? hoyde-2 : 10;
    stopp = oppnedlinjal ? 10 : hoyde-1;
    echo(str("start er ", start, " og stopp er ", stopp, " og trinn er ", trinn));
    for (i=[start:trinn:stopp]) {
        echo(i);
        translate([0,oppnedlinjal ? hoyde : 0]) {
            translate([5,oppnedlinjal ? -i-1 : i-1]) {
                text(str(i), size=2);
            }
            translate([-6,oppnedlinjal ? -i-1 : i-1]) {
                text(str(i), size=2);
            }
        }
    }
    // 1mm index marks
    for (i=[0:1:hoyde]) {
        translate([0, i-.1]) {
            square([2, 0.2]);
        }
    }
}


if (tegn_figur) {
    if (trede) {
        difference() {
            tredetrekant();
            if (tegn_linjal) {
                linjal();
            }
        }
    } else {
        trekant();
    }    
}
if (tegn_linjal) {
    echo("Tegner todelinjal");
    todelinjal();
}
