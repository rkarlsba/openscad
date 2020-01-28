module flat_heart() {
  square(20);

  translate([10, 20, 0])
  circle(10);

  translate([20, 10, 0])
  circle(10);
}

module makeheart() {
    function heart(t) = [ 19 * pow(sin(t), 3), 14 * cos(t) - 6 * cos(2 * t) - 2.2 * cos(3 * t) - cos(4 * t) ];
    polygon([ for (t = [0 : 360 ]) heart(t) ]);
}

makeheart();

//linear_extrude(height = 13) 
//flat_heart();