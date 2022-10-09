corr = $preview ? .1 : 0;

x=32.64;
//x2=26.46;
//x3=11.46;
//win_idx=10;
win_idx=9;
win_sz=10;
y=19.64;
z=13;
pad=.5;
walls=2;
lokk=1.5;
//bleed=0;
bleed=.45;

lag_bunn=0;
lag_lokk=1;

if (lag_bunn) {
    difference() {
        cube([x+pad+walls,y+pad+walls,z+pad+walls]);
        translate([walls/2,walls/2,walls]) {
            cube([x+pad,y+pad,z+pad+corr]);
        }
        rotate([90,0,90]) {
            translate([-corr,walls-corr,win_idx-corr]) {
                cube([walls+corr,z+pad+corr,win_sz+corr]);
            }
        }
    }
}

// lokk
if (lag_lokk) {
    translate([-lokk*lag_bunn,-30*lag_bunn,0]) {
        difference() {
            cube([x+pad+walls+lokk*2+bleed,y+pad+lokk*2+walls+bleed,pad+walls+lokk*2]);
            translate([lokk,lokk,lokk]) {
                cube([x+pad+walls+bleed,y+pad+walls+bleed,lokk+pad+walls+corr]);
            }
            // gløpper
            translate([walls*1.5,walls*3,-corr]) {
                cube([4,15.5,lokk+corr*2]);
            }
            translate([x-walls/4,walls*2,-corr]) {
                cube([4,16.5,lokk+corr*2]);
            }
            translate([x-walls/4-10,walls*2,-corr]) {
                cube([10,8.5,lokk+corr*2]);
            }
        }
    }
}