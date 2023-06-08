$fn = $preview ? 16 : 128;

inner_d = 50;
outer_d = 60;
oi_diff = outer_d - inner_d;
pin_d = 13;
height = 12;
slack = 2;
handlelength = 100;
handlewidth = height;
kant = 5;

testprint = false;

useheight = testprint ? 2 : height+kant;
usehandlewidth = testprint ? 10 : handlewidth;
usehandlelength = testprint ? handlelength / 4 : handlelength;

difference() {
    union() {
        cylinder(d=outer_d+slack, h=useheight);
    }
    union() {
        cylinder(d=inner_d+slack, h=useheight);
        translate([-(pin_d+slack)/2,outer_d/2-oi_diff,kant]) {
            cube([pin_d+slack,oi_diff+slack,useheight+slack]);
        }
    }
}
translate([-usehandlewidth/2,-usehandlelength-inner_d/2-slack,0]) {
    cube([usehandlewidth,usehandlelength,useheight]);
}