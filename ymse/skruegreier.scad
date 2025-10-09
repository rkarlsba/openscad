use <threads.scad>;

exclude = true;

module royDemo() {

if (!exclude) {
  translate([0,-0,0]) MetricBoltSet(3, 8);
  translate([0,-20,0]) MetricBoltSet(4, 8);
  translate([0,-40,0]) MetricBoltSet(5, 8);
  translate([0,-60,0]) MetricBoltSet(6, 8);
  translate([0,-80,0]) MetricBoltSet(8, 8);
}

  translate([0,25,0]) MetricCountersunkBolt(5, 10);
  translate([23,18,5])
    scale([1,1,-1])
    CountersunkClearanceHole(5, 8, [7,7,0], [0,0,0])
    cube([14, 14, 5]);

  translate([70, -10, 0])
    RodStart(20, 30);
  translate([70, 20, 0])
    RodEnd(20, 30);

  translate([70, -45, 0])
    MetricWoodScrew(8, 20);

  translate([12, 50, 0])
    union() {
      translate([0, 0, 5.99])
        AugerThread(15, 3.5, 22, 7, tooth_angle=15, tip_height=7);
      translate([-4, -9, 0]) cube([8, 18, 6]);
    }
}

royDemo();