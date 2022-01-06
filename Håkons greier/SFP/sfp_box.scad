// TODO:
// - Think about hinged lid with circular cut in front, but only inner side
// - lid tolerance
// - connect tolerance

// my sfp measurements:
// port width 14
// port height 9
//              gbic    sfp+        base T
// sfp width    13.4    13.7        13.7
// sfp height   8.6     8.6         8.6
// sfp len      47.5    47.5        47.5
// sfp head len 12      12          ~25
// sfp head h   12      12          14      y=2.5+w=0.65 up,
// sfp head w   14.2    14.2        ??
//   (to flare)

// Can be used to compensate for inaccurate printers :)

// Widen holes by this amount of mm.
printer_xy_slack = 0.3;
printer_z_slack = 0;

// Cols and rows of SFPs
sfp_col=5;
sfp_row=4;

//bottom("sfp");
top("sfp");

// margin between text and nearest corner/limit
// also controls text size on the top side.
top_text_margin = 1;
lid_text_margin = 2;
bottom_text_margin = 2;
// text size, in mm text height
lid_text_size = 7;
bottom_text_size = 3;
// text depth, how far it extrudes into the body
bottom_text_depth = 0.5;



// paper slot, for describing what's in the box
// how far the lip extends
paperslot_lip_size = 4;
// how wide the lip is
paperslot_lip_t = 1;
// how wide the space behind is
paperslot_space_t = 0.5;

// how many mm to spare for the
interlock_stop_buffer = 5;
// 2 layers z slack. 1 on each on 0.3
interlock_z_tolerance = 0.6;
interlock_xy_tolerance = printer_xy_slack;

// SFP MSA: http://www.schelto.com/SFP/SFP%20MSA.pdf, page 6.
sfp_latch_depth = 2.5; // V, page 6.
sfp_latch_height = 0.45; // Z, page 6
sfp_latch_width = 2.6; // AF, page 6
sfp_latch_length = 2.6; // AB, page 6
// S+V gives the real height, 45+2.5 = 47.5
// we'll make it so that we do not conflict with the latch.

// SFPs are 8.6 x 13.7. (A,B)
// Tolerances are ±0.1
// printer tolerance was ±0.1, but removing that because of loose fit.
// In the back, SFPs are supposed to get more narrow, to 8.5 x 13.4. (C,D). But that's not necessary to model here.
sfp_slot_height = 8.6 + 0.1 + printer_xy_slack;
sfp_slot_width = 13.7 + 0.1 + printer_xy_slack;
sfp_slot_len = 47.5 + 0.25 + printer_z_slack;
// S+V=47.5. S+V tolerances: .25.

qsfp_slot_height = 8.6 + 0.1 + printer_xy_slack;
qsfp_slot_width = 18.35 + 0.1 + printer_xy_slack;
qsfp_slot_len = 47.5 + 0.25 + printer_z_slack;


// 14 usual, got a comment that GLC-T needs some more space
sfp_head_height = 16;
// we need 1.5mm extra to make a solid wall
sfp_head_width = 15.2;
// Copper SFP+: tried it, it was 23 or something
sfp_head_len = 25;

// 14 usual, got a comment that GLC-T needs some more space
qsfp_head_height = 16;
// we need 1.5mm extra to make a solid wall
qsfp_head_width = 20.15;
qsfp_head_len = 25;

// height and thickness of the lid lip
lid_lip_h = 10;
// lid slack, millimeters it can move while on, theoretically
// removes this many millimeters from the inside of the lid.
lid_tolerance = printer_xy_slack;

// thickness of walls
wall_t = 3;



// how much space from one SFP to the next
sfp_x_space = sfp_head_width - sfp_slot_width;
sfp_y_space = sfp_head_height - sfp_slot_height;

qsfp_x_space = qsfp_head_width - qsfp_slot_width;
qsfp_y_space = qsfp_head_height - qsfp_slot_height;

GLITCH = .1;

function get_tot_z(sfp_type) = (sfp_type=="sfp" ? sfp_slot_len : qsfp_slot_len) + wall_t;
function get_tot_x(sfp_type) = 2*wall_t + (sfp_type=="sfp" ?
    (sfp_col*sfp_head_width + sfp_x_space) :
    (sfp_col*qsfp_head_width + qsfp_x_space));
function get_tot_y(sfp_type) = 2*wall_t + (sfp_type=="sfp" ?
    (sfp_row*sfp_head_height + sfp_y_space) :
    (sfp_row*qsfp_head_height + qsfp_y_space));


// fake sfp module, use this for testing lids
module sfp_head_box(sfp_type) {
    color([.8,.2,.2])
    translate([wall_t+sfp_x_space/2,wall_t+sfp_y_space/2,get_tot_z(sfp_type)])
    cube([sfp_head_width, sfp_head_height, sfp_head_len-2]);
}


module sfp(x,y,sfp_type){
    latch_z = sfp_latch_depth + sfp_latch_length;
    color([.9,.9,1])
    translate([x,y,0]) {
        // main
        cube([sfp_slot_width,sfp_slot_height,sfp_slot_len+.1]);
        // remove latch area
        translate([
            (sfp_slot_width-sfp_latch_width)/2,
            (-sfp_latch_height),
            (sfp_slot_len-latch_z)])
        cube([sfp_latch_width, sfp_latch_height+0.1, latch_z+0.1]);
        // text
        sfp_text(x/sfp_head_width, y/sfp_head_height, sfp_type);
    }
}

module qsfp(x,y,sfp_type){
    latch_z = sfp_latch_depth + sfp_latch_length;
    color([.9,.9,1])
    translate([x,y,0]) {
        // main
        cube([qsfp_slot_width,qsfp_slot_height,sfp_slot_len+.1]);
        // remove latch area
        translate([
            (qsfp_slot_width-sfp_latch_width)/2,
            (-sfp_latch_height),
            (qsfp_slot_len-latch_z)])
        cube([sfp_latch_width, sfp_latch_height+0.1, latch_z+0.1]);
        // text
        sfp_text(x/qsfp_head_width, y/qsfp_head_height, sfp_type);
    }
}

module lid_text(sx, sz, sfp_type) {
    text_height = lid_text_size;
    text_extends = 1;
    txt = sfp_type == "sfp" ? "x SFP" : "x QSFP";

    _str = str(sfp_col*sfp_row, txt);

    translate([ sx-lid_text_margin,
                text_extends,
                sz-lid_text_margin])
        rotate([90,180,0])
        linear_extrude(text_extends+GLITCH)
        text(_str, size=text_height);
}

module sfp_text(c, r, sfp_type) {
    // inverse row and add 1
    r = sfp_row - r;
    // add 1 to col
    c = c + 1;
    text_extends = 1;
    text_height = sfp_y_space-2*top_text_margin;

    translate([0,sfp_slot_height+top_text_margin,get_tot_z(sfp_type)-text_extends-wall_t])
    rotate([0,0,0])
        linear_extrude(text_extends+.1)
        text(str(c, chr(64+r)), size=text_height);
}

module bottom_text(paper_dim_x, paper_dim_y){
    _txt = str("Use ", paper_dim_x, " x ",
               paper_dim_y, " mm papers");
    
    translate([ bottom_text_margin,
                bottom_text_margin+bottom_text_size,
                bottom_text_depth])
    rotate([180,0,0])
        linear_extrude(bottom_text_depth)
        text(_txt, size=bottom_text_size);
}

module gbics(sfp_col,sfp_row,sfp_type){
    for(x = [0 : sfp_head_width : sfp_col*sfp_head_width-0.1]){
        for(y = [0 : sfp_head_height : sfp_row*sfp_head_height-0.1]){
            sfp(x,y,sfp_type);
        }
    }
}

module qsfps(sfp_col,sfp_row,sfp_type){
    for(x = [0 : qsfp_head_width : sfp_col*qsfp_head_width-0.1]){
        for(y = [0 : qsfp_head_height : sfp_row*qsfp_head_height-0.1]){
            qsfp(x,y,sfp_type);
        }
    }
}

// interlocking mechanism
module chaining_v(height, innerw, outerw, depth) {
    linear_extrude(height)
        polygon([
            [0,-innerw/2],
            [0,innerw/2],
            [depth, outerw/2],
            [depth, -outerw/2]]);

}
module paperslot(sfp_type) {
    inner_x = get_tot_x(sfp_type) - 2*wall_t;
    inner_z = get_tot_z(sfp_type) - lid_lip_h - wall_t;

    bottom_text(inner_x, inner_z);

    translate([wall_t, paperslot_lip_t, wall_t])
        cube([inner_x, paperslot_space_t, inner_z]);

    lip_x = inner_x - 2*paperslot_lip_size;
    lip_z = inner_z - paperslot_lip_size;

    translate([wall_t+paperslot_lip_size, 0, wall_t+paperslot_lip_size])
        cube([lip_x, paperslot_lip_t, lip_z]);
}

module box(sfp_col,sfp_row,sfp_type="sfp"){
    tot_z = get_tot_z(sfp_type);
    tot_y = get_tot_y(sfp_type);
    
    chaining_v_h = tot_z-lid_lip_h-5;
    difference(){
        union() {
            cube([get_tot_x(sfp_type),tot_y,tot_z]);
            translate([get_tot_x(sfp_type),tot_y/2,-.1])
                chaining_v(chaining_v_h+.1-interlock_z_tolerance/2,
                            5-interlock_xy_tolerance/2,
                            7-interlock_xy_tolerance/2,
                            wall_t-interlock_xy_tolerance/2);
        }
        translate([ wall_t+(sfp_x_space),
                    wall_t+(sfp_y_space),
                    wall_t])
            //gbics(sfp_col,sfp_row);
            if(sfp_type == "sfp") {
                gbics(sfp_col, sfp_row, sfp_type);
            } else {
                qsfps(sfp_col,sfp_row, sfp_type);
            }
        lid_cut(sfp_type);
        // allow for 5mm interlock stop
        translate([0,tot_y/2,-.1])
            chaining_v(chaining_v_h+.1+interlock_z_tolerance/2,
                        5+interlock_xy_tolerance/2,
                        7+interlock_xy_tolerance/2,
                        wall_t+interlock_xy_tolerance/2);
        // space for paper
        paperslot(sfp_type);
    }
}



module lid_cut(sfp_type){
    tot_z = get_tot_z(sfp_type);
    tot_x = get_tot_x(sfp_type);
    tot_y = get_tot_y(sfp_type);
    // lid spacings
    translate([0,0,tot_z - lid_lip_h]){
        // x wall, near
        translate([-1.,-.1,0])
            cube([tot_x+.2,wall_t+.1,lid_lip_h+.1]);
        // y wall, near
        translate([-.1,-.1,0])
        cube([wall_t+.1,tot_y+.2,lid_lip_h+.1]);
        // x wall, far
        translate([0,tot_y-wall_t,0])
            cube([tot_x,wall_t+.1,lid_lip_h+.1]);
        // y wall, far
        translate([tot_x-wall_t,0,0])
            cube([wall_t+.1,tot_y,lid_lip_h+.1]);
    }
}

module bottom(sfp_type="sfp") {
    box(sfp_col,sfp_row,sfp_type);
}
module top(sfp_type) {
    tot_x = get_tot_x(sfp_type);
    tot_y = get_tot_y(sfp_type);
    
    
    h=sfp_head_len + wall_t + lid_lip_h;
    t = wall_t - lid_tolerance/2;
    difference() {
        union() {
            cube([tot_x,t,h]);
            cube([t,tot_y,h]);
            translate([0,tot_y-t,0])
                cube([tot_x,t,h]);
            translate([tot_x-t,0,0])
                cube([t,tot_y,h]);

            cube([tot_x,tot_y,wall_t]);
        }
        lid_text(tot_x, h, sfp_type);
    }
}
