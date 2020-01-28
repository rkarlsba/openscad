$fn=64;

dice_size=10;
corner=dice_size/10;
jump=corner/2;

hull() {
    translate([jump,jump,jump]) sphere(r=corner);
    translate([dice_size-jump,jump,jump]) sphere(r=corner);
    translate([dice_size-jump,dice_size-jump,jump]) sphere(r=corner);
    translate([jump,dice_size-jump,jump]) sphere(r=corner);
    translate([jump,jump,dice_size-jump]) sphere(r=corner);
    translate([dice_size-jump,jump,dice_size-jump]) sphere(r=corner);
    translate([dice_size-jump,dice_size-jump,dice_size-jump]) sphere(r=corner);
    translate([jump,dice_size-jump,dice_size-jump]) sphere(r=corner);
}