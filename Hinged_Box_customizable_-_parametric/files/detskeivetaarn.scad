// pisa

x=50;
y=30;
z=55;

bleed=.5;
walls=4;
var=walls*.75;

module blokk(size, bleed) {
    x = size[0];
    y = size[1];
    
    for (z = [0:size[2]]) {
        translate([0,0,z])
            linear_extrude(1)
                square([x+bleed*2,y+bleed*2]);
                //square([size[0]+bleed*2,size[1]+bleed*2]);
    }
}

module ramme(size, walls, bleed) {
    translate([bleed,bleed]) {
        difference() {
            translate([-bleed,-bleed])
                square([size[0]+bleed*2,size[1]+bleed*2]);
            translate([walls,walls]) {
                square([size[0]-walls*2,size[1]-walls*2]);
            }
        }
    }
}
//polygon([[0,0], [x,0], [x,y], [0,y]]);

module test() {
    translate([0,-10])
        polygon([[1,1],[2,2],[3,4]]);
}

module skeiv(randlevel) {
    for (yy = [0:ysteps:y]) {
        echo(yy);
    }
}


//ramme(size=[x,y,z], walls=walls, bleed=bleed);
blokk(size=[x,y,z], bleed=bleed);