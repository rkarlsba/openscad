// Udde-boks

include <box.scad>

bredde = 100;
hoyde = 350;
dybde = 100;
materialtykkelse = 3.6;

inner = true; // Alle verdier er indre verdier
open = true; // ikke lukka boks

assemble = true;
labels = true;

box(
    width = bredde,
    height = hoyde,
    depth = dybde,
    thickness = materialtykkelse, 
    inner = inner,
    open = open,
    
    assemble = assemble,
    labels = assemble ? labels : false,
);


