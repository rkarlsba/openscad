utgangsdorvegg = 1880;
dodorvegg = 1700;
sengekortvegg = 1620;
sengelangvegg = 3150;
langvegg = dodorvegg + sengelangvegg;
kortvegg = utgangsdorvegg + sengekortvegg;
takhoyde = 2380;
ventilasjonshoyde = 270;

// rommet
difference() {
    echo ("bruttoareal er ", langvegg*kortvegg/1000000);
    echo ("dassareal er ", dodorvegg*sengekortvegg/1000000);
    cube([langvegg,kortvegg,takhoyde]);
    // Ventilasjon
    translate([0,0,(takhoyde-ventilasjonshoyde)]) {
        cube([dodorvegg,utgangsdorvegg,270]);
    }
    // Dass
    translate([0,utgangsdorvegg,0]) {
        cube([dodorvegg,sengekortvegg,takhoyde]);
    }
}