fn = $preview ? 16 : 128;
$fn = fn;
diameter = 36;
tykkelse = 8.5;
dump_diameter = 16.3;
dump_tykkelse = 3.7;

module brikke(
    brikke_d = brikke_diameter, 
    brikke_t = tykkelse, 
    dump_d = dump_diameter,
    dump_t = dump_tykkelse
) {
    circle(d=brikke_d, h=brikke_t);
}
brikke();