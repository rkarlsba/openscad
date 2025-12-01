$fn = 64;

font = "Zapfino:style=Regular";
fn = "pratchett-horse-enklere.svg";
tx1 = "T'aint what a horse looks like";
tx2 = "it’s what a horse be.";
d = 100;
s = .5;
ih = 2;
th = .6;
tz = 3;
t = ih*2;
sc = .35;
fsc = 1.05;

scale([1,s]) {
    cylinder(d1=d, d2=d-t, h=ih, $fn=256);
}
scale([fsc,fsc,1]) {
    translate([0,0,ih]) {
        linear_extrude(th) {
            translate([-39,8,0]) {
                // text(tx1, font=font, size=tz);
            }
            translate([-27,0,0]) {
                // text(tx2, font=font, size=tz);
            }
            translate([0,-2,0]) {
                scale([sc,sc,1]) {
                    import(file=fn, center=true);
                }
            }
        }
    }
}
