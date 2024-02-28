
/*
radius = 25;
depth = 5;
height = 10;
angle = 30;
*/

module halfCylinder(h,r) {
  intersection() {
    cylinder(h=h,r=r);
    translate([0,-r,0]) cube([r,2*r,h]);
  }
}

module arcCylinder(h,r,angle) {
  if (angle > 180) {
    union() {
      halfCylinder(h,r);
      rotate([0,0,angle-180]) halfCylinder(h,r);
    }
  } else {
    intersection() {
      halfCylinder(h,r);
      rotate([0,0,angle-180]) halfCylinder(h,r);
    }
  }
}

$fn = $preview ? 0 : 128;

height = 5;
radius = 20;
angle = 30;

//for (rot = [0:36:324]) rotate([0,0,rot]) arcCylinder(height, radius, angle);
for (rot = [0:50:310]) rotate([0,0,rot])arcCylinder(height, radius, angle);

/*
rotate_extrude($fn = 100)
    translate([radius - height, 0, 0])
        square([height,depth]);
        
*/