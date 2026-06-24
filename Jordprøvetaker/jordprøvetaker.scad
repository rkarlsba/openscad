
use <ymse.scad>
use <NoiseLib.scad>

$fn = 250;

corner_rounding = .3;
label_thickness = 1;
syringe_size = [.75, 1.4, 67];
tommelgreie_size = [35,25,2];

difference() {
    linear_extrude(syringe_size[2]) {
        roundedsquare([syringe_size[0]+2, syringe_size[1]+2], corner_rounding);
    }
    translate([1,1,0]) {
        linear_extrude(syringe_size[2]) {
            roundedsquare([syringe_size[0], syringe_size[1]], corner_rounding);
        }
    }
}
