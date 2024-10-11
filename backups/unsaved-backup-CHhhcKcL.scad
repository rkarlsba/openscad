/*
 * vim:ts=4:sw=4:sts=4:et:a=:fdm=marker
 *
 * Sáhkku-brett
 * 15 x 3 felter fordelt som 15 vertikale streker, 60mm høye
 * med 10mm mellom hver strek.
 */
 
module sahkkubrett(
    linjelengde = 60, 
    linjebredde = 0.3,
    mellomrom_h = 18, 
    mellomrom_v = 9, 
    linjeantall = 15, 
    rader = 3) 
{
    for (y = [0:(linjelengde+mellomrom_v):(linjelengde+mellomrom_v)*rader-1]) {
        for (x = [0:mellomrom_h:(linjeantall-1)*mellomrom_h]) {
            translate([x-linjebredde/2,y]) {
                square([linjebredde,linjelengde],center = false);
            }
        }
    }
}

translate([20,0]) {
    sahkkubrett();
}