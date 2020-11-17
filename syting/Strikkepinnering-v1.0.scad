/* Du kan eksperimentere med $fn, men for å si det sånn - hvis du setter
 * 
 * den til 3 og tegner en sirkel, så får du en trekant. Med 64, får du 64
 * fasetter, nok til at du ikke merker at den ikke er "ekte" rund. Prøv deg
 * gjerne litt fram og tilbake.
 *
 * Trykk F5 for "preview" og F6 for "render". Du må ha F6 for å kunne eksportere
 * ei STL-fil, som så kan åpnes i cura osv. Setter du $fn til 1000 eller noe, så
 * kommer render (F6) til å ta *tid* - sikkert en halvtime :)
 *
 * kommentarer på ei linje, angis gjerne //, mens skal du ha inn flere linjer,
 * er det mer vanlig med /* osv fram til denne
 */

$fn=128;

/* Width er hvor tjukk pølsa er. ring_radius er radius på pølsesnabben målt i
 * sentrum av pølsa, så med width = 2, så er indre radius ring_radius-width/2.
 * rotational_angle er hvor langt den skal gå rundt (opp mot 360). Se under for
 * mer om endestykkene jeg satte på der. 'scale' her, er hvor mye den skal
 * skaleres i høyden kontra bredden. Med height=1, blir den ei rund pølse, mens
 * med height=2, blir den dobbelt så brei som den er tjukk, mer som en ring til
 * en finger.
 */
 
module strikkepinnering(width, ring_radius, height=1, rotational_angle=360) {
    // scale() strekker modellen i [x,y,z] og her er jo x og y 1,  så bare strekk
    // på z-aksa, dvs høyden.
    scale([1,1,height]) {
        // Ring med hakk 
        rotate_extrude(angle=rotational_angle, convexity = 10)
            translate([ring_radius, 0, 0])
                circle(d = width);

        if (rotational_angle < 360) {
            // Legg på ei sfære på begynnelsen av "hakket", dvs at den halve sfæra som
            // er synlig, utgjør width/2mm
            translate([ring_radius, 0, 0])
                sphere(d = width);

            // Legg på tilsvarende på den andre enden. 
            rotate(a=[0,0,rotational_angle])
                translate([ring_radius, 0, 0])
                    sphere(d = width);
        }
    }
}


/* Merk at modulen må ha parameterne "width" og "ring_radius", mens "height"
 * og "rotational_angle" har standardverdier som blir brukt hvis det ikke angis
 * noe når den modulen kalles her
 */

strikkepinnering(width=2, ring_radius=7, height=1.75, rotational_angle=320);

