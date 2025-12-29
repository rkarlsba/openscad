/*
 * vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker
 */
// lid_filename = "USB Micro Breakout lid-ascii.stl";
lid_filename = "USB Micro Breakout lid-centered.stl";
mount_filename = "USB Micro Breakout mount-ascii.stl";
size = [23.0, 18.0, 2.0];
stl_offset = [0, 0, -5.953647];

/*
difference() {
    translate(stl_offset) {
        import(lid_filename);
    }
    translate([-size[0]/2,0,0]) {
        echo(str("size is ", size, " and size/2 is ", size/2));
    }
}
*/
import(lid_filename);
