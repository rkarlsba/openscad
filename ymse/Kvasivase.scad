SLABS = 80;
HEIGHT = 200;
TWIST = 90*sin(2*$t*360+90);
FREQ=180 + 360*$t;
START=200+4*360*$t;
SCALE=2.2;
IDX=2;

slab(HEIGHT/SLABS, 0, TWIST/SLABS, scale(0), scale(1/SLABS)) cross();
for (i = [0:SLABS-1]) {
  translate([0,0,i*HEIGHT/SLABS]) {
      slab(HEIGHT/SLABS, i*TWIST/SLABS, (i+1)*TWIST/SLABS,
           scale(i/SLABS), scale((i+1)/SLABS)) slice();
  }
}

module cross() {
  minkowski() {
    circle(r=3, $fn=16);
    union() {
      square([10,20], center=true);
      square([20,10], center=true);
    }
  }
}

module slab(h, rot_from, rot_to, scale_from, scale_to) {
  linear_extrude(height=h, twist=rot_to-rot_from, scale=scale_to/scale_from) {
    rotate(-rot_from)
      scale(scale_from)
        children();
  }
}

function scale(t) = 1+SCALE*(sin(t*FREQ + START)+1);

module slice() {
  difference() {
    cross();
    offset(-1) cross();
  }
}
