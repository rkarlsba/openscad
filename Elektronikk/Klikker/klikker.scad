// vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=100
//
// Se ../../libraries/c3-6.scad

include <BOSL2/std.scad>;
include <BOSL2/rounding.scad>
include <c3-6.scad>

case(19, 34, 22, cable_thickness=3, cable_pos=3, usb_port=USB_NONE);
right(25) {
    lid(19, 34);
}
