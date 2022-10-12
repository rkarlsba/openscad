

use <threadlib/threadlib.scad>

echo ("threadlib version: ", __THREADLIB_VERSION());

type = "M10";
turns = 5;
Douter = thread_specs(str(type, "-int"))[2] * 1.2;

echo(thread_specs(str(type, "-ext")));
intersection() {
    color("Green")
        translate([-1000, 0, -1000])
            cube(2000);
    union() {
        bolt(type, turns);
        nut(type, turns, Douter);
    };
};