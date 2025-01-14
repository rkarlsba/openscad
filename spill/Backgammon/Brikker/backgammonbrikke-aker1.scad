//  init
function arcradius2circledia(H, W) = H+(W*W/4*H);

fn = $preview ? 16 : 128;
$fn = fn;
idiot_padding = $preview ? .01 : 0;
ip = idiot_padding;

// vars
brikke_diameter = 36;
brikke_hoyde = 8.5;
dump_width = 16.3;
dump_hoyde = 3.7;
W = dump_width;
H = dump_hoyde;
dump_circle_d = arcradius2circledia(H, W);
dump_circle_r = dump_circle_d / 2;
echo(str("W = ", W, ", H = ", H, ", dump_circle_r = ", dump_circle_r, 
    ", dump_circle_d = ", dump_circle_d));

// Ref https://www.mathopenref.com/arcradiusderive.html
/*
W = dump_width = 16.3;
D = dump_hoyde = 3.7;
d = H+(W**2/4*H);
r = d/2;
*/

module brikke(
    brikke_d = brikke_diameter, 
    brikke_h = brikke_hoyde, 
    dump_d = dump_width,
    dump_h = dump_hoyde
) {
    //difference() 
    {
        cylinder(d=brikke_d, h=brikke_h);
        translate([0, 0, dump_circle_d+dump_hoyde*2]) {
            sphere(r = dump_circle_d);
        }
    }
}
brikke();