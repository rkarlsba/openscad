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
    perf_shape == "square",
    perf_size == 5,
    labels = labels
);

psuboks();
echo(psu[0]+psu_gap*2,psu[1]+psu_gap*2,psu[2]+psu_gap);
