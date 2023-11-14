// vim:ts=4:sw=4:sts=4:et:ai:fdm=marker
use <box.scad>

/* box() {{{
module box(
  width, height, depth, thickness,
  finger_width, // (default = 2 * thickness)
  finger_margin, // (default = 2 * thickness)
  inner = false,
  open = false,
  inset = 0,
  dividers = [ 0, 0 ],
  divpercent = 0,
  holes = [],
  hole_dia = 0,
  ears = 0,
  robust_ears = false,
  assemble = false,
  hole_width = false,
  kerf = 0.0,
  labels = false,
  explode = 0,
  spacing = 0,
  double_doors = false,
  door_knob = 0,
  perf_size = 0,
  perf_all = false,
  perf_walls = false,
  perf_top = false,
  perf_floor = false,
  roof = false)
}}} */

psu = [100, 165, 45];
psu_gap = 10;
boks = [psu[0]+psu_gap*2,psu[1]+psu_gap*2,psu[2]+psu_gap];
thickness = 3;
assemble = 0;
labels = assemble;
perf_all = 0;
perf_walls = 0;
perf_top = 0;
perf_floor = 0;
perf_shape = "square";
perf_size = 5;

module psuboks() {
    box(
        width = boks[0], 
        depth = boks[1],
        height = boks[2],
        thickness = thickness,
        inner = true,
        assemble = assemble,
        perf_all = perf_all,
        perf_walls = perf_walls,
        perf_top = perf_top,
        perf_floor = perf_floor,
        perf_shape = perf_shape,
        perf_size = perf_size,
        labels = labels
    );
}

psuboks();
echo(psu[0]+psu_gap*2,psu[1]+psu_gap*2,psu[2]+psu_gap);
