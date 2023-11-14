/* +--------------+
 * |              |
 * |    AHT20     |
 * |              |
 * |              |
 * |              |
 * |  1  2  3  4  |
 * |  *  *  *  *  |
 * |              |
 * +--------------+
 *
 * Example pin numbering above with headers pointed away from you
 */

aht20_dim = [10.5,15.0];
aht20_pins = ["Vcc","GND","SCL","SDA"];

scd40_dim = [13.4,23.6];
scd40_pins = ["SDA","SCL","Vcc","GND"];

ssd1306_dim = [27,28];
ssd1306_pins = ["GND","Vcc","SCL","SDA"];

pcb_thickness = 1.2;
inch = 25.4; // mm
header_pitch = inch/10;
header_dia = 0.6;
skip = inch / 2;

// 2D
module headers(x, y=1, pitch=header_pitch, dia=header_dia, border=0, borderw=0.2) {
    if (border > 0) {
        difference() {
            square([x*pitch+borderw*2,y*pitch+borderw*2]);
            translate([borderw,borderw]) {
                square([x*pitch,y*pitch]);
            }
        }
    }
    translate([borderw,borderw]) {
        for (xx = [0:x-1]) {
            for (yy = [0:y-1]) {
                echo(dia/2+(pitch-dia)/2);
                translate([dia/2+(pitch-dia)/2+xx*pitch,dia/2+(pitch-dia)/2+yy*pitch]) {
                    circle(d=dia, $fn=32);
                }
            }
        }
    }
}

// 3D
linear_extrude(pcb_thickness) {
    headers(4);
}
translate([0,3]) {
    linear_extrude(pcb_thickness) {
        headers(6,2);
    }
}