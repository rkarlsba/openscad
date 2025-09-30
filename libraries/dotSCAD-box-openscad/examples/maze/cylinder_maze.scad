use <bend.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>

radius = 30; 
height = 60;
cell_width = 8;

wall_thickness = 5;
wall_height = 5;
wall_top_scale = 0.25;

fn = 24;

module cylinder_maze() {
    module ramp_line(point1, point2, width = 1, height = 1, top_scale = 0.25) {
        angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
        offset_x = 0.5 * width * cos(angle);
        offset_y = 0.5 * width * sin(angle);

        offset1 = [-offset_x, offset_y];
        offset2 = [offset_x, -offset_y];

        hull() {
            translate(point1) 
            linear_extrude(height, scale = top_scale) 
                square(width, center = true);
                
            translate(point2) 
            linear_extrude(height, scale = top_scale) 
                square(width, center = true);
        }
    }

    maze_rows = round(height / cell_width);
    maze_columns = round(2 * 3.14159 * radius / cell_width);

    maze_cells = mz_square(
        maze_rows, maze_columns,
        x_wrapping = true
    );

    walls = mz_squarewalls(maze_cells, cell_width, left_border = false);

    leng_circumference = cell_width * maze_columns + wall_thickness;

    bend(size = [leng_circumference, cell_width * maze_rows + wall_thickness, wall_height], angle = 360 + 360 * wall_thickness / leng_circumference, frags = fn) 
    translate([0, wall_thickness / 2])
        for(wall = walls, i = [0:len(wall) - 2]) {
            ramp_line(wall[i], wall[i + 1], wall_thickness, wall_height, wall_top_scale);
        }
}

cylinder_maze();
