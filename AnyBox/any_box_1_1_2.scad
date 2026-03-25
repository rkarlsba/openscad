include <BOSL2/std.scad>
include <BOSL2/isosurface.scad>




//--->>>> Open the "Customizer" window to adjust parameters!




/* [⛭️ basic properties and dimensions] */
//ᑎ
lid=true;
//⊚
hinge_type="snap"; //[snap, pin:pin  ❨filament strand❩ ,print in place,no hinge]
//🔒
closure_type="snap rim"; //[snap rim, latch, magnets, none]
//[mm]️
X = 60;
//[mm]
Y = 50;
//[mm]
Z = 50;
//🞑

dimensions_for = "inside"; // [inside, outside]

internal_dimensions = dimensions_for=="inside"?true:false;
//[mm]⭾
wallthickness= 3;

hinge=hinge_type=="no hinge"?false:true;

/* [🖶 printer/slicer setup] */
//⌀ "line width" to be more specific
nozzle_diameter = 0.42;
//⭿
layer_height = 0.20;

/* [∞ Gridfinity] */
//overides parameters to fit the gridfinity platform and adds slots at the bottom
gridfinity_support=false;
//[42mm]️
units_X = 2;
//[42mm]
units_Y = 1;
//[7mm]
units_Z = 6;

fill_bottom=true;

//works best with the lid turned off
stacking_lip=false;
//adds holes for magnets
base_magnets = false;
//[layer height]
layers_below_magnet = 2;
//[mm]
base_magnet_tolerance = 0.2;
//[mm]
base_magnet_diameter = 6.0;
//[mm]
base_magnet_height = 2.0;
//useful if 'layers below magnet = 0';
add_prying_notch = false;




/* [⌗ divider settings] */

dividers = false;
//[mm]⭾

//amount of dividers ‖
regular_spaced_X_divider = 2;
//[0.0-1.0 of X]
//irregular_spaced_X_divider = [0.0,0.0,0.0,0.0];//[0.0:0.01:1.0]

//amount of dividers  ═
regular_spaced_Y_divider = 1;
//[0.0-1.0 of Y]
//irregular_spaced_Y_divider = [0.0,0.0,0.0,0.0];//[0.0:0.01:1.0]

divider_Z_height = 0.5;//[0:0.01:1]
divider_thickness = 1.3;
divider_rounding = 1.3;
divider_chamfer = 0.8;



/* [✦✨✦ aesthetic  settings] */
//higher values will increase generation time! might cause timout!
resolution=32; //[8:8:128]
$fn=resolution;

//🟊🌟🟊
exterior_type="textured";//["basic","textured","complex"]

//chamfer on the top and bottom ◇
outer_chamfer= 3;
inner_chamfer= max(outer_chamfer-wallthickness/2,0);
//rounding on the Z edges ⛶   (0 is bugged)
outer_rounding = 10;
overrider_automatic_inner_rounding = false;
inner_rounding = 6;

/* [↳ ░░ texture type settings] */

texture_pattern = "stripes"; //["trunc diamonds", "diamonds", "stripes", "ribs", "round ribs", "noise", "wave", "cubes", "hexagon"]
texture_scale = 12;
//negative=>invert; affects both "textured" and "complex"
tex_depth = 1.2;
//⭮
rotate_texture = false;
//how much of the tex depth should be added to the wallthickness?
tex_depth_wallthickness_factor= 0.75; //[0:.05:1.0]



/* [↳ ⌧ complex type settings] */

complex_pattern = "hex_scaffold";//[weave,hex_scaffold,gyroid]
complex_scale = 12;
//only works on some complex patterns
scaffold_thickness = 0.40; //[0.01:0.01:0.99]

add_texture_to_complex_shell = false;

//0 => perforated walls
extra_wall = 0.000 ; //[0:0.025:1]

//will increase generation time
complex_resolution = 5 ; //[1:1:20]



/* [ᑎ lid shape and options] */
//⭿ also affects hingless boxes
hinge_height_offset = 6;
//whether "lid angle" or "lid downset" is used
shape_method = "angle";//[angle,downset]
//⦝
lid_angle = 35;//[0:90]
//[mm]
lid_downset = 10.0;//
//factor
hinge_inset = 0.33;//[0:0.1:1]
hinge_inset_rounding = 0.5;//[0:0.1:1]
//factor
lip_inset = 0.33;//[0:0.1:1]
lip_inset_rounding = 0.5;//[0:0.1:1]
//[mm]
lid_tolerance = 0.1; 








/* [ᑕ lid helpers] */
// thanks @quinoje
lid_handle = false;

lid_handle_alignment = "top"; //[top, lip]

//[mm]
lid_handle_outset = 1.0;
//[mm]
lid_handle_thickness = 1.0;
//[mm] ⭿ negative possible 
lid_handle_offset = 1.0;
//⎹⟷⎸
lid_handle_width_factor = 0.5;//[0.05:0.05:1]

//[degrees] ⦝
lid_handle_angle = 45;//[0:5:65]

lid_handle_radian = tan(lid_handle_angle);

lid_handle_chamfer = 0.2;

// thanks @Best_Geezus
lid_groove = false;

lid_groove_alignment = "lip"; //[top, lip]

//[mm]
lid_groove_depth = 2.0;
//[mm]
lid_groove_height = 6.0;
//[mm] ⭿ negative possible 
lid_groove_offset = 1.0;
//⎹⟷⎸
lid_groove_width_factor = 0.5;//[0.05:0.05:1]

//[degrees] ⦝
lid_groove_angle = 45;//[0:5:90]

lid_groove_chamfer = 0.2;




/* [ ⃤ ▽ snap rim settings] */

invert_snap_rim = true;
//0.2=>good fit , 0.3=> tight fit
snap_rim_depth = 0.2;
//best kept default
snap_rim_height_factor = 6;
//best kept default
snap_rim_tolerance = 0.03;


/* [▣ latch settings] */

latch_clamp_strength = 0.12;

latch_amount = 1;
//for latch amount>1
latch_gap = 20;
//[mm]
latch_inset = 2.0;
//[mm] for latch inset >= wallthickness
minimum_back_wall_thickness = 1.6;
//[mm]
latch_thickness = 4.0;
latch_width = 20;
latch_length = 25;
latch_chamfer = 0.2;
latch_tolerance = 0.2;
latch_joint_tolerance = -0.2;
//[mm]
extra_finger_clearance = 4;

/* [🧲 magnet settings] */

Y_magnet_alignment="center";//["center","inside","outside"]
magnet_pause_helper=true;
//only visual
connect_magnets=true;
magnet_chamfer=0.4;
//see "🖶 printer/slicer setup" for layer height
layers_over_magnet=4;
//less=> more magnets
minimum_magnet_gap=3;
//⎹⟷⎸
magnet_array_width_factor=1;//[0.1:0.1:1]
magnet_type= "cylinder"; //["cylinder","box"]
//[mm]
magnet_tolerance=0.2;
//[mm]
cylinder_diameter=6.0;
//[mm]
cylinder_height=2.0;
//[mm]
box_height=10.0;
//[mm]
box_depth=2.0;
//[mm]
box_length=20.0;


/* [▢ rim settings] */

//does not work with "snap rim"
rim=true;
//[mm]⭿
rim_height=0.8;
//makes the rim angled
rim_offset=0.2;//[-.5:0.1:1]
rim_tolerance=0.1;

/* [🞅 general hinge barrel settings] */
//[mm]⌀
barrel_diameter= 4.6;
// will try to stay as close to this as possible
max_barrel_length=5.0;
barrel_chamfer=0.2;
//[mm]tolerance betweens the barrels
barrel_tolerance=0.15;
barrel_rotary_tolerance=0.2;
//[degrees] allows for more rotation, does not affect pip hinge
extra_clearance = 15;//[0:60]

//ͼϾ

/* [⨀ snap hinge settings] */

//[mm] extra tightness makes it not slip out
snap_hinge_tolerance = -0.1;
//[degrees] ∠
//slot_direction = 45; //[0:90]



/* [🞇 pin hinge settings] */

//diameter of the pin, 2.2 works well for 1.75mm filament
dpin = 2.2;
//higher => pin insert hole more angeled 
pin_floppiness = 0.60;//[0:0.05:1]
pin_insert_direction = 45;//[-180:90]



/* [🞉 print in place (pip) hinge settings] */

//0=as close as possible; 1=barrel tangent to outer wall
pip_barrel_outset=0.5;//[0:3]
//[mm] ⭾
pip_body_lid_tolerance=0.1;






/* [Hidden] */


{//for the gridfinity platform
grid_pitch=42;
height_unit=7;
stacking_fix=gridfinity_support&&stacking_lip?
    (4.4-nozzle_diameter*2)/2:0;
}


{//some basic consts
epsilon = 0.001;
root3=sqrt(3);
root2=sqrt(2);
}


{//magnet variables on a global level
magnet_wallthickness=nozzle_diameter*2;
magnet_top_buffer=layer_height*layers_over_magnet;
}


{// basic dimensions and co

/*
+textured walls needs to be thicker 
*/

t_wallthickness =exterior_type=="basic"?wallthickness:wallthickness+abs(tex_depth)*tex_depth_wallthickness_factor;


tmpX = internal_dimensions? X+t_wallthickness*2:X;
tmpY = internal_dimensions? Y+t_wallthickness*2:Y;
tmpZ = internal_dimensions? Z+wallthickness*2:Z;



lid_tolerance_offset=lid&&hinge_type=="print in place"?
    round_to(lid_tolerance):lid_tolerance;
    
min_tolerance = lid_tolerance_offset % layer_height;

    
    
outerX = gridfinity_support?units_X*grid_pitch-.5:tmpX;
outerY = gridfinity_support?units_Y*grid_pitch-.5:tmpY;

tmpZ_2 = gridfinity_support?units_Z*height_unit:tmpZ;
tmpZ_3 = round_to(tmpZ_2);
outerZ = tmpZ_3 + min_tolerance; //(tmpZ_2>=tmpZ_3?min_tolerance:layer_height-min_tolerance);

innerX=outerX-t_wallthickness*2;
innerY=outerY-t_wallthickness*2;
innerZ=outerZ-wallthickness*2;



max_rounding = (min(outerX,outerY)/2)-0;

outer_fillet = gridfinity_support?3.75*1:min(outer_rounding,max_rounding);
inner_fillet = overrider_automatic_inner_rounding?inner_rounding:max(outer_fillet-t_wallthickness,1.6);

//texutred sketch with an inset of .5 gives the most consisten results
Tsketch = offset(rect([outerX,outerY],rounding=outer_fillet),delta=-abs(tex_depth)/2);

}


{//calculating some stuff for the hinges

//due to corner fillet not the whole X length is usable for hinge
hinge_length = outerX-outer_fillet*2;
//same but for magnets
lip_length = innerX-inner_fillet*2;



//atleast 3 barrels and calculats barrel count
tmp_barrel_count=floor(hinge_length/max_barrel_length);
barrel_count= max(
tmp_barrel_count -(tmp_barrel_count % 2 == 0 ? 1 : 0),3);



//actual barrel length will be different from the input so they all can be of equal length
barrel_length=hinge_length/barrel_count;
dbarrel=barrel_diameter;




//both are a bit of a relic from when alignement was handelt differntly
pin_barrel_alignment_offset=(-dbarrel/2+t_wallthickness/2);

pip_barrel_alignment_offset=pip_barrel_outset*dbarrel/2;
}


{//calculates stuff for the lid shape

//global so it can be used by different modules


//hinge_offset set to half outerZ
true_hinge_downset=hinge_type=="print in place"?outerZ/2-stacking_fix:
        //if pin than barrel tangent to top
        //if no hinge wallthickness
        round_to(hinge_height_offset+(hinge?dbarrel:wallthickness));

true_hinge_upset = outerZ - true_hinge_downset - min_tolerance;
        

hinge_kathete=innerY*(1-hinge_inset-lip_inset);

lid_radian=shape_method == "angle"?tan(lid_angle):lid_downset/hinge_kathete;

lip_kathete=round_to(
    min(lid_radian*hinge_kathete,
        max(outerZ-true_hinge_downset-wallthickness-(closure_type=="snap rim"?snap_rim_depth*snap_rim_height_factor:0),0)));

//from top to lip
lip_outer_downset=lip_kathete+true_hinge_downset;
lid_hypotenuse=opp_adj_to_hyp(hinge_kathete,lip_kathete);

//from bot to lip

lip_outer_upset = outerZ - lip_outer_downset - min_tolerance;



true_lip_inset_rounding=1.5*lip_inset_rounding*min(lip_inset*innerY,lid_hypotenuse);
true_hinge_inset_rounding=1.5*hinge_inset_rounding*min(hinge_inset*innerY,lid_hypotenuse);

//for finger groove; only calculates when actually needed


}


{//full 3d lid shape

sample_gap=min(24/resolution,2);

path_XY_profile = resample_path(spacing=sample_gap,keep_corners=90,closed=true,
                    zrot(90,rect([innerY,innerX],rounding=inner_fillet)));

raw_path_YZ_profile = [
            
            [0,-outerY/2,outerZ-lip_outer_downset],
            [0,-innerY/2+innerY*lip_inset,outerZ-lip_outer_downset],
            [0,innerY/2-innerY*hinge_inset,true_hinge_upset], 
            [0,outerY/2,true_hinge_upset]
            
            ];

radii_YZ_profile = [0,true_lip_inset_rounding,true_hinge_inset_rounding,0];

path_YZ_profile = 
    round_corners(raw_path_YZ_profile,radius=radii_YZ_profile)
    ;

yz_raw_table = [for (p = path_YZ_profile) [p.y, p.z]];
yz_lookup_table = sort(yz_raw_table);

final_path_raw = [
    for (pt = path_XY_profile) 
    let (
        new_z = lookup(pt.y, yz_lookup_table)
    )
    [pt.x, pt.y, new_z]
];

final_path= path_merge_collinear(final_path_raw, closed=true, eps=1e-3);
}


{//bunch of functions, some even unused might need them later tho

{function dividers() = 
!dividers?undef:let(
    
    frame_reg = make_region(
    difference([
    rect([outerX,outerY]),
    offset(rect([innerX,innerY],rounding=inner_fillet),delta=.1,quality=32)
    ])),
    
    
    X_dividers_reg = regular_spaced_X_divider==0?[]:[
    for (i = [1 : regular_spaced_X_divider]) 
        let(pos = i * innerX/(regular_spaced_X_divider+1) - innerX/2)
        move([pos, 0], rect([divider_thickness, outerY]))
    ],
        
    Y_dividers_reg = regular_spaced_Y_divider==0?[]:[
    for (i = [1 : regular_spaced_Y_divider]) 
        let(pos = i * innerY/(regular_spaced_Y_divider+1) - innerY/2)
        move([0, pos], rect([outerX, divider_thickness]))
    ],
    

all_regs = [for (r=[frame_reg, X_dividers_reg, Y_dividers_reg]) if (len(r) > 0) r],
combined_region = union(all_regs),

    // 5. Apply offset to the entire combined structure
    final_region = offset(offset(combined_region, delta=divider_rounding,quality=1),r=-divider_rounding,$fn=resolution/2),

)final_region;}


function round_to(value,multiple=layer_height)=round(value/multiple)*multiple;

function avrg(list) = sum(list) / len(list);

function vnf_clamp_to_unit(vnf) =
    let(
        // Cut X axis
        v1 = vnf_halfspace([1,0,0,0],vnf),
        v2 = vnf_halfspace([-1,0,0,-1],v1),
        
        // Cut Y axis
        v3 = vnf_halfspace([0,1,0,0],v2),
        v4 = vnf_halfspace([0,-1,0,-1],v3),
        
        // Cut Z axis
        v5 = vnf_halfspace([0,0,1,0],v4),
        v6 = vnf_halfspace([0,0,-1,-1],v5)
    )
    v6;


function remove_border_faces(vnf, eps=0.001) = 
    let(
        verts = vnf[0],
        faces = vnf[1],
        
        // Check if a specific value is on the Min (0) or Max (1) border
        is_min = function(x) abs(x) < eps,
        is_max = function(x) abs(x-1) < eps,
        
        // A face is a "border face" if ALL its vertices are on the same border plane
        keep_face = function(f) 
            let(
                // Get all x and y coordinates for the vertices in this face
                xs = [for(i=f) verts[i].x],
                ys = [for(i=f) verts[i].y],
                
                // Check X borders
                on_left_wall  = [for(x=xs) if(!is_min(x)) 1] == [], // True if list empty
                on_right_wall = [for(x=xs) if(!is_max(x)) 1] == [],
                
                // Check Y borders
                on_front_wall = [for(y=ys) if(!is_min(y)) 1] == [],
                on_back_wall  = [for(y=ys) if(!is_max(y)) 1] == []
            )
            // Keep the face only if it is NOT on any of these walls
            !(on_left_wall || on_right_wall || on_front_wall || on_back_wall)
    )
    [verts, [for(f=faces) if(keep_face(f)) f]];

    
function clean_vnf(vnf, e=0.0001) =
    let(
        verts = vnf[0],
        faces = vnf[1],
        clean_verts = [for (p=verts) [quant(p.x,e), quant(p.y,e), quant(p.z,e)]]
    ) [clean_verts, faces];

    
function clean_vnf2(vnf) =
let(
    verts = vnf[0],
    faces = vnf[1],
    clean_verts = 
    [for (p=verts) [constrain(p.x,0,1), constrain(p.y,0,1), constrain(p.z,0,1)]]
) [clean_verts, faces];

function boundary_to_3d(boundary_2d, z) = 
  [for (pt = boundary_2d)
        for(pt2=pt)
    [pt2[0], pt2[1], z]];
}


{//custom vnf textures

{function hex_wall(thickness=scaffold_thickness) =
let(
    //idk what theses do, sc is needed to correctly scale the hex so it fits into the 1x1 box for it to be tileable. note that when used you have to mulitply the Y size of texture times the root of 3
    hyp=adj_ang_to_hyp(0.5,30),
    sc = 1/3/hyp,
    
    //maxes a hexagon and squishes it
    hex_poly = move([0,sc-1],yscale(sc, regular_ngon(n=6,id=1-thickness,spin=90,anchor=CENTER),1)),
    
    centers = [  [-.5,-.5], [.5,-.5],[-.5,.5],[0,0], [.5,.5] ],
    
    //places hexagons on the centers
    raw_hexes = [for (c=centers) move(c+[0,0], hex_poly)],
    //booleans are possible in 2D but not as vnf so doing it now
    tile_bounds = square([1,1],center=true),
    //clips the hexes so it fits into 1x1
    //"inverts" the hexagons so that the negative of them remains
    scaffold_region = difference(tile_bounds, raw_hexes),
    
    raw_vnf = move([.5,.5,.5],linear_sweep(scaffold_region, h=1) ),
    
    clamped_vnf = vnf_triangulate(vnf_clamp_to_unit(raw_vnf)),
    
    cleaned_vnf = vnf_drop_unused_points(remove_border_faces(vnf_merge_points(clean_vnf(clamped_vnf))))
    

) cleaned_vnf;}

    
function diag_stripes_vnf() =[
    [[0,0,1],//1
    [.5,0,0],[0,.5,0],//1,2
    [0,1,1],[1,0,1],//3,4
    [1,.5,0],[.5,1,0],//5,6
    [1,1,1]],//7
    [[0,2,1],[1,2,3,4],[4,3,6,5],[5,6,7]] 
];


{function half_pillars() = vnf_vertex_array(
let(
    arc_numbers=2,
 
    single_arc = arc(d=1/arc_numbers, angle=[180,0],cp=[.5/arc_numbers,0],
        $fn=$fn*texture_scale/16),

    arc_list = [
        for(i = [0 : arc_numbers-1]) 
        move([i * 1/arc_numbers, 0], single_arc)
    ],

    final_arc = path_join(arc_list),
)
[
    for (y = [0 : 1]) [
        for (arc = final_arc) 
            [arc.x , y , arc.y*2*arc_numbers]
    ]
],reverse=true);}


function diag_weave_vnf() = [
   [[0.2, 0, 0], [0.8, 0, 0], [1, 0.2, 0.5], [1, 0.8, 0.5], [0.7, 0.5, 0.5],
    [0.5, 0.3, 0], [0.2, 0, 0.5], [0.8, 0, 0.5], [1, 0.2, 1], [1, 0.8, 1],
    [0.7, 0.5, 1], [0.5, 0.3, 0.5], [1, 0.2, 0], [1, 0.8, 0], [0.8, 1, 0.5],
     [0.2, 1, 0.5], [0.5, 0.7, 0.5], [0.7, 0.5, 0], [0.8, 1, 1], [0.2, 1, 1],
     [0.5, 0.7, 1], [0.8, 1, 0], [0.2, 1, 0], [0, 0.8, 0.5], [0, 0.2, 0.5],
     [0.3, 0.5, 0.5], [0.5, 0.7, 0], [0, 0.8, 1], [0, 0.2, 1], [0.3, 0.5, 1],
     [0, 0.8, 0], [0, 0.2, 0], [0.3, 0.5, 0], [0.2, 0, 1], [0.8, 0, 1], [0.5, 0.3, 1]],
    [[0, 1, 5], [1, 2, 4, 5], [7, 11, 10, 8], [8, 10, 9], [7, 8, 2, 1], [9, 10, 4, 3],
     [10, 11, 5, 4], [0, 5, 11, 6], [12, 13, 17], [13, 14, 16, 17], [3, 4, 20, 18],
     [18, 20, 19], [3, 18, 14, 13], [19, 20, 16, 15], [20, 4, 17, 16], [12, 17, 4, 2],
     [21, 22, 26], [22, 23, 25, 26], [15, 16, 29, 27], [27, 29, 28], [15, 27, 23, 22],
     [28, 29, 25, 24], [29, 16, 26, 25], [21, 26, 16, 14], [30, 31, 32], [31, 6, 11, 32],
     [24, 25, 35, 33], [33, 35, 34], [24, 33, 6, 31], [34, 35, 11, 7],
     [35, 25, 32, 11], [30, 32, 25, 23]]
];


{function gyroid(x,y,z, wavelength) = let(
    p = 360/wavelength * [x,y,z]
) sin(p.x)*cos(p.y)+sin(p.y)*cos(p.z)+sin(p.z)*cos(p.x);}

}







//back_half(s=1000)

hsv(h=170,s=.05,v=.8)
render()
printable_box();

//render()
//pin_body();
//
//render()
//pin_lid();

//gridfinity_bottom(is_bool=true);


//back_half(s=1000,y=outerY/2-dbarrel/2){



//fwd(outerX/2)
//up(outerZ-lip_outer_downset)
//cube([50,30,200],anchor=LEFT);
//
//}
//%
//render()
//pin_lid();
//color("offwhite")
//pin_body();
////
////
//color("teal")
//fwd(outerY/2+latch_thickness)
//back(latch_inset)
//up(outerZ-lip_outer_downset)
//xrot(90)
//mirror([0,0,1])
//latch(just_latch=true);

//lid_handle(is_bool=true);


module lid_handle(is_bool=true){


   
    
    lid_handle_downset = lid_handle_alignment=="top"?
        outer_chamfer+lid_handle_offset+lid_handle_thickness/2:
        lip_outer_downset-lid_handle_offset-lid_handle_thickness/2;
    
    base_size = [lid_handle_width_factor*hinge_length,lid_handle_thickness];
    
    
    
    cut_knob();
    
    
    module knob(){
    
    up(outerZ-lid_handle_downset)
    fwd(outerY/2)
    fwd(lid_handle_outset)
    
        prismoid(
                size1=base_size+[outerY/2*lid_handle_radian,outerY*lid_handle_radian], 
                size2=base_size,
                h=outerY/2,orient=FWD,anchor=TOP,
                chamfer=latch_chamfer); 
    };
    
    module cut_knob(){
    
    difference(){
    
        knob();
        up(outerZ)
        cube([outerX*2,outerY*2,outerZ*2],anchor=BOT);
        
        shell_inside();
    }
    
    
    }
};


module lid_groove(is_bool=true){


    //caps it it doesn't dig into the inside
    true_lid_groove_depth = min(lid_groove_depth,t_wallthickness-nozzle_diameter*2);
    
    //so the groove doesn't get too large
    //it could still become too large and dig into the main body but I don't want it to be too restrictive
    true_lid_groove_height = lid_groove_height;
    
    //so I can use it to scale the chamfer in Z to get the right angle;
    lid_groove_radian = tan(lid_groove_angle);

    //if the angle would be so shallow that the depth would decrease it caps it
    true_lid_groove_radian = 
        min(
            lid_groove_radian*lid_groove_depth,
            lid_groove_height/lid_groove_depth*2);
    
    //when top then aligned just bellow the outer chamfer
    //when lip aligned just over the "lip"
    
    lid_groove_downset = lid_groove_alignment=="top"?
        outer_chamfer+lid_groove_offset:
        lip_outer_downset-true_lid_groove_height-lid_groove_offset;
    
    
    if(is_bool)
        slot();
    
    
    module slot(){
    
    up(outerZ-lid_groove_downset)
    fwd(outerY/2)
    
    diff()
        cuboid([lid_groove_width_factor*hinge_length,true_lid_groove_depth,true_lid_groove_height],anchor=FWD+TOP){
        
            if(true_lid_groove_radian!=0)
            edge_profile([BOT+BACK])
                yscale(true_lid_groove_radian/true_lid_groove_depth)
                mask2d_chamfer(x=true_lid_groove_depth,inset=0);
                    
            edge_profile(BACK)
                mask2d_chamfer(lid_groove_chamfer);
                   
            tag("keep")
            edge_profile_asym(FRONT,except=BOT, flip=true, corner_type="sharp")
            xflip() mask2d_chamfer(lid_groove_chamfer);
        }
    }
};


module latch(for_bool=false,just_latch=false){
 
 
////lalatch_amount = 1;
////for latch amount>1
//latch_gap = 20;
////[mm]
//latch_thickness = 4.0;
//latch_width = 20;
//latch_length = 20;
////[mm]
//latch_inset = 2;
//latch_tolerance = 0.2;rance = 0.2;



usable_latch = latch_length-latch_thickness*2;

latch_slot_depth = min(latch_width/3,usable_latch/2);

latch_cone_offset = .3+nozzle_diameter/4;

clamp_thickness = nozzle_diameter*2
;



//fwd(outerY/2+latch_thickness)
//back(latch_inset)
//up(outerZ-lip_outer_downset)
//xrot(90)
//mirror([0,0,1])
//

if(closure_type=="latch"&&lid){
    
    xcopies(spacing=latch_gap+latch_width,n=latch_amount)
    {
    if(just_latch)
    just_latch();

    if(!for_bool&&!just_latch)
    box_ankers();

    if(for_bool&&!just_latch)
    anker_carver();
    }
}

module negative_cone(){
        
        right(latch_width/2)
        back(latch_slot_depth)
        back(latch_thickness/2)
        up(latch_thickness/2)
        union(){
        
        xcyl(d2=latch_thickness-latch_chamfer*2-latch_cone_offset,d1=0,
        l=(latch_thickness-latch_chamfer*2-latch_cone_offset)/2,
        anchor=RIGHT+CENTER);
        
        xcyl(d=latch_thickness-latch_chamfer*2-latch_cone_offset*2,
        l=(latch_thickness),
        anchor=LEFT+CENTER);
        
        
        }
        
}

module positive_cone(){
        
        right(latch_width/2)
        right (latch_tolerance)
        back(latch_slot_depth)
        back(latch_thickness/2)
        up(latch_thickness/2)
        xcyl(d2=latch_thickness-latch_chamfer*2-latch_cone_offset,d1=latch_cone_offset*2,
        l=(latch_thickness-latch_chamfer*2-latch_cone_offset*3)/2,
        anchor=RIGHT+CENTER);
        
}

module just_latch(){

    
//    %
//    back(latch_thickness+latch_slot_depth)
//    cuboid([latch_width,latch_length, latch_thickness],anchor=BOT+BACK);
    
    
    latch_body();
    
    module latch_body(){
    
        basic_sketch=[
            
            [0,0],
            [0,latch_slot_depth],
            [latch_width/2,latch_slot_depth],
            [latch_width/2-latch_slot_depth,0],
        
        ];
        
        compliant_hole=offset([
            
            
            [latch_width/2-clamp_thickness*2,latch_slot_depth-clamp_thickness*1],
            [latch_width/2-latch_slot_depth+clamp_thickness*1,clamp_thickness*2],
        
        ],r=clamp_thickness,$fn=resolution/2);
        
        
        bezpath1= path_to_bezpath([
        
            [latch_width/2,latch_slot_depth],
            [latch_width/2-latch_slot_depth/2+latch_clamp_strength,latch_slot_depth/2-latch_clamp_strength],
            [latch_width/2-latch_slot_depth,0],
        
        
        ]);
        
        offset_bez = bezpath_offset(polar_to_xy(r=clamp_thickness,theta=135),bezpath1);
        
        path_bez = bezpath_curve(offset_bez,splinesteps=4);
        
        perforated_quadrant = union(path_bez,difference(basic_sketch,compliant_hole));
        
        top_slots = union(perforated_quadrant,xflip(perforated_quadrant));
        
        all_slots = union(top_slots,yflip(top_slots));
        
        extra_bot = latch_length-latch_slot_depth*2-latch_thickness;
        
        whole_latch = union(
            all_slots,
            
            fwd(latch_slot_depth,rect([latch_width,extra_bot],anchor=BACK)),
            
            back(latch_slot_depth,rect([latch_width,latch_thickness/2+latch_chamfer],anchor=BOT)),
            
            );
        
        
        
//        color("blue")
//        stroke(bezpath_curve(offset_bez,splinesteps=4),width=.1,closed=true);
//        
//        color("red")
//        stroke(compliant_hole,width=.1,closed=true);
        
        difference(){
        union(){
        
            offset_sweep(whole_latch,h=latch_thickness,ends=os_chamfer(width=latch_chamfer),$fn=resolution/6);
            
            back(latch_slot_depth+latch_thickness/2)
            xrot(180)
            teardrop(d=latch_thickness, h=latch_width,cap_h=latch_thickness/2,anchor=TOP,spin=90,chamfer=latch_chamfer,ang=53);
            
        }//union ends, difference starts
        
        up(latch_thickness+layer_height*2)
        fwd(extra_bot+latch_slot_depth)
        chamfer_edge_mask(l=latch_width,orient=LEFT,chamfer=latch_thickness-latch_chamfer);
        
        xflip_copy()
        union(){
            negative_cone();
            left(latch_joint_tolerance)
            chain_hull(){
                positive_cone();
                down(latch_thickness/2)
                //fwd(latch_thickness/2)
                positive_cone();
                down(latch_thickness)
                left(latch_thickness/2)
                positive_cone();
            
            }
        }
        
        }
    }

}

    module box_ankers(){
    
    need_wall = latch_inset>t_wallthickness-minimum_back_wall_thickness?true:false;
    
    distance_to_back = (need_wall?latch_tolerance:0) + latch_thickness+max(0,t_wallthickness-latch_inset);
    
    scale_factor = (1 + distance_to_back/latch_thickness)*1;
    
    distance_to_back_wall = distance_to_back + minimum_back_wall_thickness;
    
    //minimum_back_wall_thickness
    if(need_wall)let(){
    
    extra_distance = max(0,latch_inset-t_wallthickness);
    
    wall_width = latch_width+minimum_back_wall_thickness*4;
    wall_length = latch_length+minimum_back_wall_thickness*2 +extra_distance*2 + extra_finger_clearance;
    wall_thickness = minimum_back_wall_thickness + extra_distance;
    
    difference(){
        
        fwd(innerY/2)
        up(outerZ-lip_outer_downset)
        down(wall_length/2)
        up(latch_slot_depth+latch_thickness+extra_distance+minimum_back_wall_thickness)
        diff()
        cuboid([wall_width,wall_thickness,wall_length],anchor=FRONT){
        
        edge_profile([BACK],except=["Z"])
        mask2d_chamfer(x=wall_thickness, excess=2);
        
        edge_profile(["Z"],except=[FWD])
        yscale(wall_thickness/minimum_back_wall_thickness)
        mask2d_roundover(r=minimum_back_wall_thickness, excess=2);
        };
        
        latch_hole();
    }
    }
    
    fwd(outerY/2+latch_thickness)
    back(latch_inset)
    up(outerZ-lip_outer_downset)
    xflip_copy()
        difference(){
        union(){
            
        
        
            xrot(90)
            mirror([0,0,1])
            positive_cone();
            
            
           
            
            base_size=[latch_thickness*0.5,latch_thickness];
            
            right(latch_width/2+latch_thickness/4)
            right(latch_tolerance)
            up(latch_slot_depth+latch_thickness/2)
            back(latch_chamfer)
            
            union(){
            
            prismoid(
                size1=base_size*scale_factor*4/3, 
                size2=base_size, 
                shift=[(base_size[0]*-scale_factor)*4/6+base_size[0]*.5,0],
                h=distance_to_back-latch_chamfer,orient=FWD,anchor=TOP,
                chamfer=latch_chamfer);
            
            prismoid(
                size1=base_size-[latch_chamfer*2,latch_chamfer*2], 
                size2=base_size, 
                h=latch_chamfer,orient=BACK,anchor=TOP,
                chamfer=latch_chamfer);
            
            
            }
            
            right(latch_width/2)
            left(latch_slot_depth/2)
            difference(){
                
                union(){
                
                diff()
                prismoid(
                size1=latch_slot_depth*(root2/2)*scale_factor, 
                size2=latch_slot_depth*(root2/2), 
                shift=-latch_slot_depth*(root2/2)*scale_factor*1/2.8,
                h=distance_to_back,orient=FWD,anchor=TOP,spin=-45,
                chamfer=latch_chamfer)
                
                attach(RIGHT+BACK,"corner",inside=true)
      polygon_edge_mask(mask2d_chamfer(h=latch_thickness*scale_factor,inset=0,mask_angle=$edge_angle), $edge_length+latch_chamfer, scale=0.0001);
                
                
                
                ;
                
                prismoid(
                size1=latch_slot_depth*(root2/2)-latch_chamfer*2, 
                size2=latch_slot_depth*(root2/2), 
                h=latch_chamfer,orient=BACK,anchor=TOP,spin=-45,
                chamfer=latch_chamfer);
                
                }
                fwd(latch_chamfer)
                left(latch_slot_depth/4)
                back(latch_thickness/1)
                cuboid([latch_slot_depth,latch_slot_depth,latch_thickness*2],anchor=RIGHT,chamfer=-latch_chamfer,orient=FWD,edges=TOP);
            
            }
            
            
        }//diff starts
        
        
        if(need_wall)
        right(latch_width/2+latch_tolerance)
        back(latch_thickness)
        fwd(max(0,latch_inset-t_wallthickness))
        cube([latch_width*2,latch_inset,latch_length*2],anchor=LEFT+FWD);
        
        
        }//diff ends
        
    }
    
    
    module latch_hole(){
    
    max_thickness = t_wallthickness+latch_thickness+latch_inset;
        
        back_size = [latch_width,latch_length] + [latch_tolerance*2,latch_tolerance*2]+[0,extra_finger_clearance];
        
    front_size = back_size + [0,max_thickness*2];
    
    fwd(outerY/2)
            back(latch_inset+latch_tolerance)
            up(outerZ-lip_outer_downset)
            down(extra_finger_clearance/2)
            down(latch_length/2-latch_slot_depth-latch_thickness)
            
            prismoid(
                size2=back_size, 
                size1=front_size,
                h=max_thickness,orient=BACK,anchor=TOP,
                chamfer=latch_chamfer);
    
    
    }
    
    
    module anker_carver(){
        difference(){
        
            latch_hole();

            box_ankers();
        }
    }    
}


module gridfinity_stacking_lip(){

if(stacking_lip&&gridfinity_support)

up(outerZ)
    difference(){
    
    //up(4.4)
    
    rect_tube(size=[outerX,outerY], wall=t_wallthickness, h=4.4-nozzle_diameter*2,rounding=3.75,anchor=BOT,chamfer2=0);
    
    
        union(){
            up(.7+1.8)
            prismoid(size1=[outerX-1.9*2,outerY-1.9*2], size2=[outerX,outerY], h=1.9,rounding1=3.2/2, rounding2=7.5/2);
            
            up(0.7)
            prismoid(size1=[outerX-1.9*2,outerY-1.9*2], size2=[outerX-1.9*2,outerY-1.9*2], h=1.8,rounding1=3.2/2, rounding2=3.2/2);

            prismoid(size1=[outerX-(2.6)*2,outerY-(2.6)*2], size2=[outerX-1.9*2,outerY-1.9*2], h=0.7,rounding1=1.6/2, rounding2=3.2/2);
            
            
        }
    }
}


module gridfinity_bottom(is_bool=true){
    
//    grid_pitch=42;
//    height_unit=7;
//    2.95

    pos_offset=is_bool?0:wallthickness;


    if(gridfinity_support)
        grid_copies(n=[ceil(outerX/grid_pitch),ceil(outerY/grid_pitch)],spacing=grid_pitch)
        bottom_tile();
        
    module bottom_tile(){
        
        
        if(base_magnets)let(){
            
            
            final_base_magnet_diameter = base_magnet_diameter+base_magnet_tolerance*2 + (is_bool?0:nozzle_diameter*3);
            final_base_magnet_height = base_magnet_height+base_magnet_tolerance*2 +(is_bool?0:layer_height*5);
            magnet_spacing = grid_pitch-(2.15+0.8+4.8)*2;
            
            magnet_diagonal_spacing = magnet_spacing/(root2/2);
            
            up(layer_height*layers_below_magnet)
//            grid_copies(n=[2,2],spacing=magnet_spacing)
            zrot_copies(n=4,d=magnet_diagonal_spacing,sa=45)
            cyl(d=final_base_magnet_diameter,h=final_base_magnet_height,anchor=BOT,chamfer=is_bool?0:0.4)
            
            if(add_prying_notch)
            left(final_base_magnet_diameter/2)
            zrot(90)
            teardrop(h=final_base_magnet_height,d=4,anchor=CENTER,orient=FRONT,ang=1,cap_h=final_base_magnet_diameter/2)
            ;
        }
        
        if(!(!is_bool&&fill_bottom))
        difference(){
        cuboid([grid_pitch,grid_pitch,4.75+pos_offset],anchor=BOT);
        
        up(pos_offset)
        scale([grid_pitch/(grid_pitch+pos_offset*2),grid_pitch/(grid_pitch+pos_offset*2),1]){
        prismoid(size1=grid_pitch-(.8+2.15+.25)*2, size2=grid_pitch-(2.15+.25)*2, 
            h=.8,rounding1=1.6/2,rounding2=3.2/2);
        up(.8)
        prismoid(size1=grid_pitch-(2.15+.25)*2, size2=grid_pitch-(2.15+.25)*2, 
            h=1.8,rounding1=3.2/2,rounding2=3.2/2);
            
        up(.8+1.8)
        prismoid(size1=grid_pitch-(2.15+.25)*2, size2=grid_pitch-(.25)*2, 
            h=2.15,rounding1=3.2/2,rounding2=7.5/2);
            }
        }
        
    }
    

}


module pin_hole(){
    
    hole_length = outer_fillet+barrel_length/2+t_wallthickness;
    
    handleX = hole_length*((pin_floppiness*.33)+.666);
    handleZ = (-hole_length*pin_floppiness)/2;
    
    bez = [[0,0,0],[hole_length/3,0,0],[handleX,0,handleZ],[hole_length,0,-hole_length*pin_floppiness*2]];
    
    path = rot([-pin_insert_direction,0,0],p=bezpath_curve(bez));
    
    //the sketch that is being swept
    sketch = teardrop2d(d=dpin, ang=55,spin=180);
    
    //move aligns 0,0,0 to the middle of the back right barrel of the lid
    
    
    difference(){
        move([hinge_length/2-barrel_length,
        outerY/2-t_wallthickness/2+pin_barrel_alignment_offset,
        outerZ-hinge_height_offset-dbarrel/2])
        path_sweep(sketch,path);
        
        right(outerX/2)
        left(t_wallthickness)
        fwd(dbarrel)
        cuboid([outerX,outerY,outerZ],anchor=BOT+LEFT);
    }
    
}


module snap_rim(is_lid=false){
    
//    snap_rim_depth = 1;
//    snap_rim_tolerance
    
    
    local_rim_tolerance=is_lid?snap_rim_tolerance:-snap_rim_tolerance;
        
    snap_rim_height= snap_rim_depth*snap_rim_height_factor;
    
    center= wallthickness/2-snap_rim_depth/2;
    
    
    
    raw_sketch = 
    
    fwd(snap_rim_height,[ 
    [0, 0], 
    [0, snap_rim_height/1.2],
    [0, snap_rim_height], 
    [center, snap_rim_height],
    [center+snap_rim_depth-snap_rim_tolerance, snap_rim_height*3.5/5+lid_tolerance_offset/3],
    [center+snap_rim_depth-snap_rim_tolerance, snap_rim_height*3/5+lid_tolerance_offset/3],
    [center, snap_rim_height*2/5+lid_tolerance_offset/3],
    [center, snap_rim_height*1/5],
    [wallthickness/2, 0],
    [t_wallthickness+epsilon, 0],
    [t_wallthickness+epsilon, -snap_rim_height],
    [0,-snap_rim_height]
    ]);
    
   
    
    
    body_carve_sketch=
        invert_snap_rim?
        right(center*2+snap_rim_depth,
            mirror([1,0],union(
                difference(
                    union(
                        square([t_wallthickness+.5+lid_tolerance_offset,snap_rim_height*2],anchor=LEFT),
                        right(t_wallthickness+.5+lid_tolerance_offset,mirror([0,1],right_triangle(snap_rim_height*2,anchor=LEFT)))),
                    raw_sketch
                ),
                
                square([t_wallthickness-wallthickness+1,snap_rim_height],anchor=RIGHT+FWD),
                
                )
            )
        )
        :
        difference(
            union(
                square([2,snap_rim_height],anchor=BOT),
                square([t_wallthickness+1,snap_rim_height*2],anchor=LEFT),
            ),
            raw_sketch
        )
        ;
    
    
    lid_carve_sketch=
        invert_snap_rim?
        right(center*2+snap_rim_depth,
            mirror([1,0],
                union(
                    square([2,snap_rim_height],anchor=BOT),
                    right(wallthickness+.5,
                        union(
                            mirror([0,1],right_triangle(snap_rim_height*2,anchor=LEFT)),
                            rect([1,snap_rim_height*2],anchor=RIGHT))),
                    make_region(
                        zrot(180,raw_sketch,cp=[wallthickness/2,-snap_rim_height*2.5/5])
                    )
                )
            )
        )
        :
        union(
            right(wallthickness,square([t_wallthickness-wallthickness+1,(snap_rim_height)*2],anchor=LEFT)),
            square([2,snap_rim_height],anchor=BOT),
            zrot(180,raw_sketch,cp=[wallthickness/2,-snap_rim_height*2.5/5])
        )
        ;
    
    final_sketch=path_merge_collinear(is_lid?lid_carve_sketch:body_carve_sketch);
  
//    color("red") //stroke(raw_sketch, width=0.03, closed=true);
//    polygon(raw_sketch);
//    move_copies(raw_sketch)cube(.2,center=true);
       
    //stroke(inverted_raw_sketch, width=0.03, closed=true);
    
//    color("blue") stroke(body_carve_sketch, width=0.03, closed=true);
//    color("teal") stroke(lid_carve_sketch, width=0.03, closed=true);
    
    if(closure_type=="snap rim")
    difference(){
        
        
        path_sweep(
        final_sketch,method="manual",relaxed=false,
        final_path,//profiles=true,
        closed=true,uniform=false);
        
////        stroke(path_YZ_profile,width=1);
        
        if(hinge){
        
        extra_factor=3;
        
        cut_start=-(innerY/2-inner_fillet)+local_rim_tolerance;
        cut_end=cut_start+snap_rim_height*extra_factor;
        cut_extra=cut_end+snap_rim_height;
        
        
        point1 = [cut_start,lookup(-cut_start, yz_lookup_table)];
        point2 = [cut_end,lookup(-cut_end, yz_lookup_table)-snap_rim_height*extra_factor];
        point3 = [cut_extra,lookup(-cut_extra, yz_lookup_table)-snap_rim_height*extra_factor];
        
        total_path = [
            [point1[0],point1[1]],
            [point2[0],point2[1]],
            [point3[0],point3[1]],
            [cut_end,0],
            [-outerY,0],
            [-outerY,outerZ],
            [cut_start,outerZ],
        ];
        
        
        //stroke(path_YZ_profile,width=2);
        
        rot([0,-90,0])
        rot([0,0,-90])
        linear_extrude(outerX*2,center=true)
            polygon(round_corners(total_path,radius=0));
//        
//        up(outerZ-true_hinge_downset-snap_rim_height/2)
//        back(innerY/2-inner_fillet-local_rim_tolerance)
//        prismoid(
//            size1=[outerX*2,outerY],
//            size2=[outerX*2,outerY],
//            h=outerZ,
//            anchor=FWD);
            
            
        }
        }
    }


module rim(is_lid){
    
    local_rim_tolerance=is_lid?rim_tolerance/2:-rim_tolerance/2;
    
    local_rim_height=round_to(rim_height);
    
    rim_width=wallthickness/2+local_rim_tolerance+rim_tolerance;
    
    sweep_sketch= [ [-local_rim_height*2-local_rim_tolerance+rim_tolerance/2, 0], 
    [-local_rim_tolerance+rim_tolerance/2, local_rim_height*2+local_rim_tolerance], 
    [rim_width-rim_offset, local_rim_height*2+local_rim_tolerance],
    [rim_width+rim_offset*2, 0],];
    
    
    
    
    if(rim&&closure_type!="snap rim")
    
    difference(){
        
        down(local_rim_height)
        path_sweep(
        left(rim_tolerance,sweep_sketch),method="manual",relaxed=false,
        final_path,closed=true);
        
        if(hinge)
        up(outerZ-true_hinge_downset+local_rim_tolerance)
        back(innerY/2-inner_fillet/3)
        prismoid(
            size1=[outerX,outerY-local_rim_height*10],
            size2=[outerX,outerY],
            h=local_rim_height*3,
            anchor=FWD);
        
        
        if(!hinge&&closure_type=="magnets")
        up(outerZ-true_hinge_downset+local_rim_tolerance-local_rim_height*2)
        back((innerY+t_wallthickness)/2)
        prismoid(
            size1=[lip_length-local_rim_height*4,t_wallthickness],
            size2=[lip_length+local_rim_height*4,t_wallthickness*2],
            h=local_rim_height*4,
            anchor=BOT);
        
        
        
        if(closure_type=="magnets")
        up(outerZ-lip_outer_downset+local_rim_tolerance-local_rim_height*2)
        fwd((innerY+t_wallthickness)/2)
        prismoid(
            size1=[lip_length-local_rim_height*2,t_wallthickness],
            size2=[lip_length+local_rim_height*6,t_wallthickness*2],
            h=local_rim_height*4,
            anchor=BOT);
        
    }

}


module printable_box(){
    
    
//    distribute(l=min(outerX,outerY)+8,dir=outerX>outerY?FWD:RIGHT){
    
    zrot(outerX>outerY?90:0)
    fwd(max(outerX,outerY)/2+ latch_length)
    latch(just_latch=true);
    
    
    if(lid)
    {   
        if(hinge){
            if(hinge_type=="print in place")
            pip_box_assembled();
            
            if(hinge_type=="pin")
            pin_box_assembled();
         
            if(hinge_type=="snap")
            snap_box_assembled(); 

   
        } else {
        
            unhinged_box_assembled();
        }
            
    } else {
    
        lidless_body();
    
    
    }
}


module rotary_tolerance_booltool(is_lid=false,is_pin=true){
    
    last_barrel_number=ceil(barrel_count/2)-1;
    
    extra_barrel_length = hinge_type!="print in place"?outer_fillet:0;
    
    local_barrel_count=!is_lid?ceil(barrel_count/2):floor(barrel_count/2);
    
    module neg_barrel(is_lid=false,barrel_number){
    
        true_barrel_length=!is_lid&&barrel_number==0||barrel_number==last_barrel_number?barrel_length+extra_barrel_length:barrel_length;
        
        barrel_placement_fix=!is_lid&&barrel_number==0?extra_barrel_length:
        barrel_number==last_barrel_number?-extra_barrel_length:
        0;
        
        boolsketch = union(
        make_region(circle(d=dbarrel+barrel_rotary_tolerance*2)),
        hinge_type!="print in place"?
        trapezoid(h=dbarrel,w2=dbarrel+barrel_rotary_tolerance*2,ang=90-extra_clearance,anchor=TOP,spin=180)
        : undef
        );
    
        left(barrel_placement_fix/2) 
            yrot(90)
            offset_sweep(boolsketch,
            l=true_barrel_length+(hinge_type!="print in place"?barrel_chamfer*2+barrel_tolerance*2:dbarrel),anchor=FWD,ends=os_chamfer(width=(hinge_type!="print in place"?barrel_chamfer:dbarrel/2)));
    }
    
    up((is_lid?outerZ-true_hinge_downset:true_hinge_upset)+(hinge_type!="print in place"?dbarrel/2:0))
    back(outerY/2-(hinge_type!="print in place"?dbarrel:(pip_barrel_outset*dbarrel/2)+barrel_rotary_tolerance))
    xcopies(n=floor(local_barrel_count), spacing=barrel_length*2)
    neg_barrel(is_lid=is_lid,barrel_number=$idx);
    
}


module pause_reminder(pause_height){
    
    magnet_depth=magnet_type=="cylinder"?cylinder_diameter:box_depth;
    
    true_magnet_depth=magnet_depth+magnet_wallthickness*2-t_wallthickness;
    
    outset_fix=
    Y_magnet_alignment=="center"?true_magnet_depth/2:
    Y_magnet_alignment=="outside"?true_magnet_depth:0;
    
    
    
    font_size=outerX/10;
    font_height=0.0005;
    
    
    if(magnet_pause_helper)
    if(closure_type=="magnets")
    translate([0,-outerY/2-outset_fix,pause_height+layer_height/PI]){
        text3d(text=str("pause here for magnet"),anchor=BACK,h=font_height,size=font_size/2);
        fwd(font_size)
        text3d(text=str(pause_height," mm"),anchor=BACK,h=font_height,size=font_size*2);
        
        back(font_size)
        cube([font_height,font_size*3.75,font_height],anchor=BACK);
        fwd(font_size*0.48)
        cube([outerX,0.0001,font_height],anchor=BACK);
        
        fwd(font_size*2.75)
        cube([outerX,0.0001,font_height],anchor=BACK);
    }
}


module magnet_array(is_lid=false,for_bool=false){
    
    
    
    lid_mirror=is_lid?1:0;
    
    center_halfer=Y_magnet_alignment=="center"?0.5:1;
    
    inner_c_d=cylinder_diameter+magnet_tolerance*2;
    outer_c_d=inner_c_d+magnet_wallthickness*2;
    inner_c_h=cylinder_height+magnet_tolerance*2;
    outer_c_h=inner_c_h+magnet_top_buffer*2;
    
    
    inner_b_h=box_height+magnet_tolerance*2;
    outer_b_h=inner_b_h+magnet_top_buffer*2;
    inner_b_d=box_depth+magnet_tolerance*2;
    outer_b_d=inner_b_d+magnet_wallthickness*2;
    inner_b_l=box_length+magnet_tolerance*2;
    outer_b_l=inner_b_l+magnet_wallthickness*2;
    
    final_magnet_depth=magnet_type=="cylinder"?outer_c_d:outer_b_d;
    final_magnet_width=magnet_type=="cylinder"?outer_c_d:outer_b_l;
    final_magnet_height=magnet_type=="cylinder"?outer_c_h:outer_b_h;
    
    
    magnet_array_width = magnet_array_width_factor*(lip_length-final_magnet_width);
    
    magnet_count=ceil((magnet_array_width)/(minimum_magnet_gap+final_magnet_width));
    
    texture_fix=Y_magnet_alignment=="inside"?exterior_type=="textured"?t_wallthickness-abs(tex_depth):0:0;
    
    Y_magnet_alignment_offset=
    Y_magnet_alignment=="center"?0:
    Y_magnet_alignment=="outside"?final_magnet_depth/2-t_wallthickness/2+epsilon:
    exterior_type=="textured"?-abs(tex_depth)-final_magnet_depth/2+t_wallthickness/2-epsilon:
    -final_magnet_depth/2+t_wallthickness/2-epsilon;
    
    module magnet_support_tool(){
        back(texture_fix)
        back(Y_magnet_alignment_offset)
        cuboid([final_magnet_width,0.1,
        center_halfer*final_magnet_depth+final_magnet_height],anchor=TOP,
        chamfer=magnet_chamfer,edges="Y"); 
    }
    
    module magnet_hole(){
        down(magnet_top_buffer*2)
        cube([.001,final_magnet_depth*1.1,.001],anchor=TOP);//so the hole doesn't fall out
        
        down(magnet_top_buffer)
        if(magnet_type=="cylinder")
        cylinder(d=inner_c_d,h=inner_c_h,anchor=TOP);
        else 
        cube([inner_b_l,inner_b_d,inner_b_h],anchor=TOP);    
    }
    
    module magnet_shell(){
    
        hull(){
        magnet_support_tool();
        if(magnet_type=="cylinder")
            cyl(d=outer_c_d,h=outer_c_h,anchor=TOP,chamfer=magnet_chamfer);
        else
            cuboid([outer_b_l+magnet_chamfer*2,outer_b_d,outer_b_h],
            anchor=TOP,chamfer=magnet_chamfer);
        }
    } 
    
    
    
    module assembled(){
        up(lid_tolerance_offset*lid_mirror){
            fwd(outerY/2-t_wallthickness/2)
            up(is_lid?lip_outer_upset:lip_outer_upset)
            
            fwd(Y_magnet_alignment_offset)
            
            if(closure_type=="magnets")
            mirror([0,0,lid_mirror]){
            if(for_bool)
            xcopies(n=magnet_count,l=magnet_array_width)
            magnet_hole();
            
            
            if(!for_bool)
            if(connect_magnets)hull()
            xcopies(n=magnet_count,l=magnet_array_width)
            magnet_shell();
            else
            xcopies(n=magnet_count,l=magnet_array_width)
            magnet_shell();
            }
        }
    }
    
    
    assembled();
    if(!hinge)
    mirror([0,1,0])
    up(lip_kathete)
    assembled();
    
}


module pip_box_assembled(){
    
    
    
    fwd(pip_barrel_alignment_offset)
    fwd(outerY/2)
    fwd(pip_body_lid_tolerance/2)
    union(){
        pip_body();
        pause_reminder(lip_outer_upset-magnet_top_buffer);
    }
    
    back(pip_barrel_alignment_offset)
    back(pip_body_lid_tolerance/2)
    back(outerY/2){
        up(stacking_fix*2)
        up(outerZ)
        xrot(180)
        pip_lid();
        
        zrot(180)
        pause_reminder(lip_outer_downset-magnet_top_buffer);
    }

}


module pip_body(){

    intersection(){
        difference(){
            union(){
                difference(){
                    final_shell();
                    lid_bool_tool(is_lid=false);
                    rotary_tolerance_booltool(is_pin=false);
                    pip_barrel_array(is_lid=false,is_bool=true);
                }
                pip_barrel_array();
                magnet_array(is_lid=false,for_bool=false);
            }
            magnet_array(is_lid=false,for_bool=true);        
        }
    cube([outerX*3,outerY*3,outerZ],anchor=BOT);
    }
}


module pip_lid(){
    
    intersection(){
        difference(){
            union(){
                difference(){
                    intersection(){
                        final_shell();
                        lid_bool_tool(is_lid=true);
                    }
                    rotary_tolerance_booltool(is_pin=false,is_lid=true);
                    pip_barrel_array(is_lid=true,is_bool=true);
                }
                magnet_array(is_lid=true,for_bool=false);
                pip_barrel_array(is_lid=true);
            }
            up(epsilon)
            magnet_array(is_lid=true,for_bool=true);        
        }
    cube([outerX*3,outerY*3,outerZ*2],anchor=BOT);
    }
    
    
}


module pip_barrel(is_lid=false,is_bool=false,barrel_number){
    
    pip_cone_offset=nozzle_diameter;
    
    local_lid_tolerance_offset=is_lid?lid_tolerance_offset:0;
    
    tangent_factor=sqrt(2)/2;
    
    bool_mirror=is_bool?1:0;
    
    lid_mirror=is_lid?1:0;
    
    back(dbarrel/2)
    back(pip_barrel_alignment_offset)
    union(){
    difference(){
        union(){ //creates the barrel without a hole
            
            yrot(90) //barrel
            cyl(l=barrel_length-barrel_tolerance*2,d=dbarrel,chamfer=barrel_chamfer,anchor=CENTER);
            
            
            shape = [
            [-local_lid_tolerance_offset,0],
            [-tangent_factor*dbarrel/2,-tangent_factor*dbarrel/2],
            [-2*tangent_factor*dbarrel/2-pip_barrel_alignment_offset-t_wallthickness,
            pip_barrel_alignment_offset+t_wallthickness],
            [-local_lid_tolerance_offset,t_wallthickness+pip_barrel_alignment_offset]
            
            ];
            
            mirror([0,bool_mirror,0])
            mirror([0,0,lid_mirror])
            left(barrel_length/2-barrel_tolerance)
            rot([0,-90,180])
            offset_sweep(shape, height=barrel_length-barrel_tolerance*2,
            ends=os_chamfer(width=barrel_chamfer));
            
        }
        //negative cone slot
        if(!(barrel_number==0&&is_lid))
        
        left(barrel_length/2-barrel_tolerance+epsilon)
        cyl(d1=0,d2=dbarrel-barrel_chamfer*2-pip_cone_offset,
        l=(dbarrel-barrel_chamfer*2-pip_cone_offset)/2,
        anchor=TOP,orient=LEFT);
    }
        
        //positve cone
        
        right(barrel_length/2-barrel_tolerance-epsilon)
        cyl(d1=pip_cone_offset,d2=dbarrel-barrel_chamfer*2-pip_cone_offset*2,
        l=(dbarrel-barrel_chamfer*2-pip_cone_offset*3)/2,
        anchor=TOP,orient=LEFT);
    
    
    
    }
}


module pip_barrel_array(is_lid=false,is_bool=false){
        
        fakeable_is_lid=is_bool?!is_lid:is_lid;
        
        local_barrel_count=fakeable_is_lid?ceil(barrel_count/2):floor(barrel_count/2);
        
        up(true_hinge_upset)
        //right(hinge_length/2)
        back(outerY/2-dbarrel/2)
        
        xflip_copy()
        left_half()
        xcopies(n=floor(local_barrel_count), spacing=barrel_length*2)
        pip_barrel(is_lid=is_lid,is_bool=is_bool,barrel_number=$idx);
}


module snap_box_assembled(){

distribute(l=min(outerX,outerY)+8,dir=outerX>outerY?FWD:RIGHT){

    union(){
        snap_body();
        pause_reminder(lip_outer_upset-magnet_top_buffer);
    };

    union(){
        up(stacking_fix*2)
        up(outerZ)
        rot([0,180,0])
        snap_lid();

        pause_reminder(lip_outer_downset-magnet_top_buffer);
    }
}
}


module snap_body(){
    intersection(){
        difference(){
            union(){
                difference(){
                
                    final_shell();
                    lid_bool_tool(is_lid=false);
                    rotary_tolerance_booltool(is_pin=true);
                }
                snap_barrel_array(is_lid=false);
                magnet_array(is_lid=false,for_bool=false);
            }
            
            
            magnet_array(is_lid=false,for_bool=true);    
        }
    cube([outerX*3,outerY*3,outerZ],anchor=BOT);
    }
}


module snap_lid(){
    
    intersection(){
        difference(){
            union(){
                difference(){
                    intersection(){
                        
                        final_shell();
                        lid_bool_tool(is_lid=true,is_pin=true);
                    }
                    rotary_tolerance_booltool(is_pin=true,is_lid=true);
                }
                magnet_array(is_lid=true,for_bool=false);
                snap_barrel_array(is_lid=true);
            }
            up(epsilon)
            magnet_array(is_lid=true,for_bool=true);        
        }
    cube([outerX*3,outerY*3,outerZ+stacking_fix*2],anchor=BOT);
    }
}


module snap_barrel(is_lid=false,barrel_number){
    
    snap_cone_offset=.3+nozzle_diameter/4;
    
    tangent_factor=sqrt(2)/2;
    
    lid_mirror=is_lid?1:0;
    
    last_barrel_number=ceil(barrel_count/2)-1;
    
    extra_barrel_length = outer_fillet;
    
    true_barrel_length=is_lid&&barrel_number==0||barrel_number==last_barrel_number?barrel_length+extra_barrel_length:barrel_length;
    
    barrel_placement_fix=is_lid&&barrel_number==0?extra_barrel_length:
    barrel_number==last_barrel_number?-extra_barrel_length:
    0;
    
    
    true_hole_length=is_lid&&barrel_number==0||barrel_number==last_barrel_number?barrel_length/2:barrel_length;
    
    hole_placement_fix=is_lid&&barrel_number==0?barrel_length/4:
    barrel_number==last_barrel_number?-barrel_length/4:
    0;
    
    function sign2(input) = sign(input)==0?1:sign(input); 
    
    module positive_cone(){
        
        cyl(d1=snap_cone_offset*3,d2=dbarrel-barrel_chamfer*2-snap_cone_offset*1,
        l=(dbarrel-barrel_chamfer*2-snap_cone_offset*4)/2,
        anchor=TOP,orient=LEFT,chamfer1=snap_cone_offset/2,chamfang1=35);
        
        cyl(d=dbarrel-barrel_chamfer*2-snap_cone_offset*1,
        l=barrel_length/3,anchor=TOP,orient=RIGHT);
    
    }
    
    back(pin_barrel_alignment_offset)

    difference(){
        union(){
            hull(){ //creates the barrel without a hole
                left(barrel_placement_fix/2)            
                xcyl(l=true_barrel_length-barrel_tolerance*2,d=dbarrel,chamfer=barrel_chamfer,anchor=CENTER);
                
                
                if(is_lid==false) //for the main body
                fwd(pin_barrel_alignment_offset) //thing so it connects nicely
                cuboid([
                barrel_length-barrel_tolerance*2,
                t_wallthickness,dbarrel/2+barrel_rotary_tolerance+barrel_chamfer],
                anchor=TOP,chamfer=barrel_chamfer)
                
                cuboid([
                barrel_length-barrel_tolerance*2,
                t_wallthickness/2,dbarrel],
                anchor=TOP+BACK);
                
                if(is_lid==true){ //needs some extro logic for offset<wallthickness
                if(hinge_height_offset>=outer_chamfer){
                    
                    local_tex_depth=exterior_type=="basic"?0:abs(tex_depth);
                    
                    shape = hull_region([
                    [0,dbarrel/2],
                    [0,0],
                    [0,-dbarrel/2],
                    [dbarrel/2+barrel_chamfer,-dbarrel/2],
                    [dbarrel/2+barrel_chamfer+local_tex_depth,-dbarrel/2+local_tex_depth],
                    [dbarrel/2+barrel_rotary_tolerance*3,-max(dbarrel-t_wallthickness,0)/2],
                    [dbarrel/2+max(dbarrel-t_wallthickness,0)/2+barrel_chamfer,-dbarrel/2+min(t_wallthickness,dbarrel)],
                ]);
                    
                    left(barrel_placement_fix/2)
                    rot([0,-90,180])
                    offset_sweep(shape, height=true_barrel_length-barrel_tolerance*2,
                    ends=os_chamfer(width=barrel_chamfer),anchor="zcenter");
                
                } else {
                    
                    shape = [
                        [tangent_factor*dbarrel/2,tangent_factor*dbarrel/2],
                        [0,0],
                        [tangent_factor*dbarrel/2,-tangent_factor*dbarrel/2],
                        [dbarrel/2,-dbarrel/2+outer_chamfer-hinge_height_offset],
                        [hinge_height_offset+dbarrel/2,hinge_height_offset],
                        [hinge_height_offset+dbarrel/2,barrel_chamfer+max(outer_chamfer,dbarrel+barrel_rotary_tolerance)-dbarrel/2],
                        [hinge_height_offset+dbarrel/2-wallthickness,barrel_chamfer+dbarrel/2+barrel_rotary_tolerance],
                        
                    ];
                    
                    left(barrel_placement_fix/2)
                    rot([0,-90,180])
                    offset_sweep(hull_region(shape), height=true_barrel_length-barrel_tolerance*2,
                    ends=os_chamfer(width=barrel_chamfer),anchor="zcenter");
                
                }
                }
            }//hull ends and union starts
            
        //if(!is_lid)
        xflip_copy(barrel_length/2-barrel_tolerance-epsilon)
        if(($idx==1&&!is_lid)||($idx==1&&is_lid))
        positive_cone();
            
        }//union ends and difference starts
        
        //if(is_lid)
        
        xflip_copy()
        //if(!((barrel_number==0&&$idx!=1)||(barrel_number==last_barrel_number&&$idx!=0)))
        if((is_lid&&$idx==1)||(!is_lid&&$idx==1))
        right(-barrel_length/2+barrel_tolerance-epsilon)
        union(){
            cyl(d1=0,d2=dbarrel-barrel_chamfer*2-snap_cone_offset,
                l=(dbarrel-barrel_chamfer*2-snap_cone_offset)/2,
                anchor=TOP,orient=LEFT);
            //hull carves for the kegs to slot in
            
            chain_hull(){
            
                right(snap_hinge_tolerance-barrel_tolerance*2)
                positive_cone();
                
                slot_offset = polar_to_xy([dbarrel/2,is_lid?0:-90]);
                
                move([0,slot_offset[0],-slot_offset[1]])
                right(snap_hinge_tolerance-(barrel_tolerance*2))
                positive_cone();
                
                move([dbarrel/2,slot_offset[0]*2,-slot_offset[1]*2])
                right(snap_hinge_tolerance-(barrel_tolerance*2))
                positive_cone();
            
            }
        
        }
        
        //for clean outer barrels on the lid
        down(outerZ/2-true_hinge_downset+dbarrel/2)
        fwd(pin_barrel_alignment_offset)
        back(t_wallthickness/2)
        if(is_lid){
            
            
            X_offset=barrel_length/2-(exterior_type!="basic"?
                min(abs(tex_depth)*2,outer_fillet):0);
            
            
            if(barrel_number==0)
            left(barrel_placement_fix)
            left(X_offset)
            rounding_edge_mask(l=outerZ,excess=dbarrel+abs(tex_depth)*2, r=outer_fillet,spin=-90,chamfer=outer_chamfer)
            cuboid([outerY,dbarrel,outerZ],chamfer=-outer_chamfer,anchor=BACK)
            ;
            
            if(barrel_number==last_barrel_number)
            left(barrel_placement_fix)
            right(X_offset)
            rounding_edge_mask(l=outerZ,excess=dbarrel+abs(tex_depth)*2, r=outer_fillet,spin=180,chamfer=outer_chamfer)
            cuboid([dbarrel,outerY,outerZ],chamfer=-outer_chamfer,anchor=RIGHT)
            ;
        
        
        
        }
    }
}


module snap_barrel_array(is_lid=false){
        
        local_barrel_count=is_lid?ceil(barrel_count/2):floor(barrel_count/2);
        
        //orient the first barrel to the back left
        up(true_hinge_upset+dbarrel/2)
        //right(-outerX/2+outer_fillet)
        back(outerY/2-t_wallthickness/2)
        xflip_copy()
        left_half()
        xcopies(n=floor(local_barrel_count), spacing=barrel_length*2)
        snap_barrel(is_lid=is_lid,barrel_number=$idx);
}


module pin_box_assembled(){

distribute(l=min(outerX,outerY)+8,dir=outerX>outerY?FWD:RIGHT){

    union(){
        pin_body();
        pause_reminder(lip_outer_upset-magnet_top_buffer);
    };

    union(){
        up(stacking_fix*2)
        up(outerZ)
        rot([0,180,0])
        pin_lid();

        pause_reminder(lip_outer_downset-magnet_top_buffer);
    }
}
}


module pin_body(){
    intersection(){
        difference(){
            union(){
                difference(){
                
                    final_shell();
                    lid_bool_tool(is_lid=false);
                    rotary_tolerance_booltool(is_pin=true);
                }
                pin_barrel_array(is_lid=false);
                magnet_array(is_lid=false,for_bool=false);
            }
            magnet_array(is_lid=false,for_bool=true);    
        }
    cube([outerX*3,outerY*3,outerZ],anchor=BOT);
    }
}


module pin_lid(){
    
    intersection(){
        difference(){
            union(){
                difference(){
                    intersection(){
                        
                        final_shell();
                        lid_bool_tool(is_lid=true,is_pin=true);
                    }
                    rotary_tolerance_booltool(is_pin=true,is_lid=true);
                }
                magnet_array(is_lid=true,for_bool=false);
                pin_barrel_array(is_lid=true);
            }
            pin_hole();
            up(epsilon)
            magnet_array(is_lid=true,for_bool=true);        
        }
    cube([outerX*3,outerY*3,outerZ+stacking_fix*2],anchor=BOT);
    }
}


module pin_barrel(is_lid=false,barrel_number){
    
    tangent_factor=sqrt(2)/2;
    
    lid_mirror=is_lid?1:0;
    
    last_barrel_number=ceil(barrel_count/2)-1;
    
    extra_barrel_length = outer_fillet;
    
    true_barrel_length=is_lid&&barrel_number==0||barrel_number==last_barrel_number?barrel_length+extra_barrel_length:barrel_length;
    
    barrel_placement_fix=is_lid&&barrel_number==0?extra_barrel_length:
    barrel_number==last_barrel_number?-extra_barrel_length:
    0;
    
    
    true_hole_length=is_lid&&barrel_number==0||barrel_number==last_barrel_number?barrel_length/2:barrel_length;
    
    hole_placement_fix=is_lid&&barrel_number==0?barrel_length/4:
    barrel_number==last_barrel_number?-barrel_length/4:
    0;
    
    function sign2(input) = sign(input)==0?1:sign(input); 
    
    
    back(pin_barrel_alignment_offset)

    difference(){
    
        hull(){ //creates the barrel without a hole
            left(barrel_placement_fix/2)            
            
            xcyl(l=true_barrel_length-barrel_tolerance*2,d=dbarrel,chamfer=barrel_chamfer,anchor=CENTER);
            
            
            if(is_lid==false) //for the main body
            fwd(pin_barrel_alignment_offset) //thing so it connects nicely
            cuboid([
            barrel_length-barrel_tolerance*2,
            t_wallthickness,dbarrel/2+barrel_rotary_tolerance+barrel_chamfer],
            anchor=TOP,chamfer=barrel_chamfer)
            
            cuboid([
            barrel_length-barrel_tolerance*2,
            t_wallthickness/2,dbarrel],
            anchor=TOP+BACK);
            
            if(is_lid==true){ //needs some extro logic for offset<wallthickness
            if(hinge_height_offset>outer_chamfer){
                
                local_tex_depth=exterior_type=="basic"?0:abs(tex_depth);
                
                shape = hull_region([
                    [0,dbarrel/2],
                    [0,0],
                    [0,-dbarrel/2],
                    [dbarrel/2+barrel_chamfer,-dbarrel/2],
                    [dbarrel/2+barrel_chamfer+local_tex_depth,-dbarrel/2+local_tex_depth],
                    [dbarrel/2+barrel_rotary_tolerance*3,-max(dbarrel-t_wallthickness,0)/2],
                    [dbarrel/2+max(dbarrel-t_wallthickness,0)/2+barrel_chamfer,-dbarrel/2+min(t_wallthickness,dbarrel)],
                ]);
                
                left(barrel_placement_fix/2)
                rot([0,-90,180])
                
                
                offset_sweep(shape, height=true_barrel_length-barrel_tolerance*2,
                ends=os_chamfer(width=barrel_chamfer),anchor="zcenter");
            
            } else {
                
                shape = [
                    [tangent_factor*dbarrel/2,tangent_factor*dbarrel/2],
                    [0,0],
                    [tangent_factor*dbarrel/2,-tangent_factor*dbarrel/2],
                    [dbarrel/2,-dbarrel/2+outer_chamfer-hinge_height_offset],
                    [hinge_height_offset+dbarrel/2,hinge_height_offset],
                    [hinge_height_offset+dbarrel/2,barrel_chamfer+max(outer_chamfer,dbarrel+barrel_rotary_tolerance)-dbarrel/2],
                    [hinge_height_offset+dbarrel/2-wallthickness,barrel_chamfer+dbarrel/2+barrel_rotary_tolerance],
                    
                ];
                
                left(barrel_placement_fix/2)
                rot([0,-90,180])
                offset_sweep(hull_region(shape), height=true_barrel_length-barrel_tolerance*2,
                ends=os_chamfer(width=barrel_chamfer),anchor="zcenter");
            
            }
            }
        }
        //chamfered teardrop hole
        
        right(hole_placement_fix)
        yrot(180*lid_mirror)
        zrot(-90)
        teardrop(d=dpin, l=true_hole_length-barrel_tolerance*2+epsilon,ang=55,
        chamfer1=-barrel_chamfer*sign2(barrel_placement_fix),
        chamfer2=-barrel_chamfer*sign2(-barrel_placement_fix));
        
        down(outerZ/2-true_hinge_downset+dbarrel/2)
        fwd(pin_barrel_alignment_offset)
        back(t_wallthickness/2)
        if(is_lid){
            
            
            X_offset=barrel_length/2-(exterior_type!="basic"?
                min(abs(tex_depth)*2,outer_fillet):0);
            
            
            if(barrel_number==0)
            left(barrel_placement_fix)
            left(X_offset)
            rounding_edge_mask(l=outerZ,excess=dbarrel+abs(tex_depth)*2, r=outer_fillet,spin=-90,chamfer=outer_chamfer)
            cuboid([outerY,dbarrel,outerZ],chamfer=-outer_chamfer,anchor=BACK)
            ;
            
            if(barrel_number==last_barrel_number)
            left(barrel_placement_fix)
            right(X_offset)
            rounding_edge_mask(l=outerZ,excess=dbarrel+abs(tex_depth)*2, r=outer_fillet,spin=180,chamfer=outer_chamfer)
            cuboid([dbarrel,outerY,outerZ],chamfer=-outer_chamfer,anchor=RIGHT)
            ;
        
        
        
        }
    }
}


module pin_barrel_array(is_lid=false){
        
        local_barrel_count=is_lid?ceil(barrel_count/2):floor(barrel_count/2);
        
        //orient the first barrel to the back left
        up(true_hinge_upset+dbarrel/2)
        //right(-outerX/2+outer_fillet)
        back(outerY/2-t_wallthickness/2)
        xcopies(n=floor(local_barrel_count), spacing=barrel_length*2)
        pin_barrel(is_lid=is_lid,barrel_number=$idx);
}
 
 
module lid_bool_tool(is_lid=false,is_pin=false){
    
    //alignment to the back of the
    local_lid_bool=is_lid?1:0;
    
    difference(){
        
        //up(lid_tolerance_offset*local_lid_bool)
        down(is_lid?0:min_tolerance)
        union(){
            shape = [
            [outerZ-lip_outer_downset,innerY/2-innerY*lip_inset],
            [outerZ-true_hinge_downset,-innerY/2+innerY*hinge_inset],
            [outerZ-true_hinge_downset,-outerY], 
            [outerZ*2,-outerY],
            [outerZ*2,outerY],
            [outerZ-lip_outer_downset,outerY+max(cylinder_diameter+box_depth,0)]];
        
        
        
        
        radii = [true_lip_inset_rounding,true_hinge_inset_rounding,0,0,0,0];

        //color("teal")
        
        rot([0,-90,180])
        linear_extrude(outerX*3,center=true)polygon(round_corners(shape, radius = radii));
        
            snap_rim(is_lid=is_lid);
        
        };
        
        rim(is_lid);
        
        
        //this carves out space for the barrel array
        if(is_lid&&is_pin){
            barrel_cutter_length=min(hinge_length-barrel_chamfer*2-barrel_tolerance*2-epsilon,innerX);
            
            //stops before carving into the top wall
            
            up(outerZ-max(true_hinge_downset-dbarrel+(dividers?divider_chamfer:0),wallthickness))
            back(outerY/2-dbarrel)
//            //back(outerY/2-dbarrel-inner_chamfer*2)
//            //fwd(inner_chamfer*2)
            cuboid([barrel_cutter_length,outerY,outerY],//rounding=dbarrel/2,
            anchor=TOP+FRONT);


            //this then overtakes and carves with a rounded edge
            
            up(outerZ-true_hinge_downset+dbarrel)
            back(outerY/2-t_wallthickness/2+pin_barrel_alignment_offset-dbarrel/2)
            fwd(barrel_rotary_tolerance)
            cuboid([barrel_cutter_length,outerY,outerY],
            rounding=hinge_height_offset==0?0:dbarrel/2,
            anchor=TOP+FRONT,edges=TOP+FRONT);
            
            //rounding for smooth rotation
            up(outerZ-true_hinge_downset)
            back(outerY/2-t_wallthickness/2+dbarrel/2)
            back(pin_barrel_alignment_offset)
            xrot(90)
            yrot(-90)
            rounding_edge_mask(l=outerX, r=dbarrel/2,excess=2);
        }
    }

}


module unhinged_box_assembled(){

distribute(l=min(outerX,outerY)+8,dir=outerX>outerY?FWD:RIGHT){

    union(){
        unhinged_body();
        pause_reminder(lip_outer_upset-magnet_top_buffer);
    }

    union(){
        up(stacking_fix*2)
        up(outerZ)
        rot([0,180,0])
        unhinged_lid();

        pause_reminder(lip_outer_downset-magnet_top_buffer);
    }
}
}


module unhinged_body(){
    intersection(){
        difference(){
            union(){
                difference(){
                    final_shell();
                    lid_bool_tool(is_lid=false);
                }
                magnet_array(is_lid=false,for_bool=false);
            }
            magnet_array(is_lid=false,for_bool=true); 
        }
    cube([outerX*3,outerY*3,outerZ],anchor=BOT);
    }
}


module unhinged_lid(){
    intersection(){
        difference(){
            union(){
                intersection(){
                    final_shell();
                    lid_bool_tool(is_lid=true);
                }
                magnet_array(is_lid=true,for_bool=false);
            }
            magnet_array(is_lid=true,for_bool=true);
        }
        cube([outerX*3,outerY*3,true_outerZ],anchor=BOT);
    }
}


module lidless_body(){

    final_shell();

}


module cached_shell() {
    // Convexity helps OpenSCAD preview not look "glitchy" with complex holes
    render(convexity=10) 
        final_shell();
}


module final_shell(){
    // convexity helps OpenSCAD preview (F5) render the inside of hollow objects correctly.
    // A value of 10-20 is usually safe for complex shells.
    difference(){
        union(){
            render(convexity=12) { 
                if(exterior_type=="basic")
                    basic_shell();
                if(exterior_type=="textured")
                    textured_shell();
                if(exterior_type=="complex")
                    complex_shell();
            }
        latch(for_bool=false);
        if(lid_handle)
        lid_handle();
        }
    latch(for_bool=true);
    }
}


module shell_inside(){
    
    bottom_fill_fix=fill_bottom&&gridfinity_support?
        -wallthickness+5+layer_height*3:0;
    
    stacking_lip_fix=stacking_lip&&gridfinity_support?
        .8:0;
    
    difference(){
        union(){
            up(wallthickness+bottom_fill_fix)
            offset_sweep(
                rect([innerX,innerY],rounding=inner_fillet),
                height=(lid?innerZ-stacking_lip_fix:innerZ+wallthickness+epsilon)-bottom_fill_fix,
                bot=os_chamfer(width=inner_chamfer),
                top=os_chamfer(width=lid?inner_chamfer:
                gridfinity_support&&stacking_lip?0:-t_wallthickness/3),
                anchor="base"
            );
            
            if(gridfinity_support&&stacking_lip){
            up(outerZ)
            prismoid(size1=[outerX-(3.4)*2,outerY-(3.4)*2], size2=[outerX-(2.6)*2,outerY-(2.6)*2], h=0.8, rounding2=1.6/2,anchor=TOP);
            
            if(!lid)
            up(outerZ-.8)
            prismoid(size2=[outerX-(3.4)*2,outerY-(3.4)*2], 
            size1=[outerX-(3.4+t_wallthickness)*2,outerY-(3.4+t_wallthickness)*2], h=t_wallthickness,anchor=TOP);
            }
        }
        
        

        if(dividers)
        up(wallthickness+bottom_fill_fix)
        offset_sweep(
            dividers(),h=innerZ*divider_Z_height-bottom_fill_fix,
            bot=os_chamfer(width=-divider_chamfer),
            top=os_chamfer(width=divider_Z_height==1?-divider_chamfer:divider_thickness/3)
        );
        
        if(gridfinity_support){gridfinity_bottom(is_bool=false);}
    }
}


module watermark(){
    
    smallest= 0.00001;
    
    text="made by lorenz's Any Box Generator";
    
    yflip_copy(smallest/2)
    text3d(text, h=smallest,size = smallest, anchor=CENTER,$fn=12);
    
    cube([len(text)*smallest*0.72,smallest*4,smallest/2],anchor=CENTER);
}


module basic_shell(){

    difference(){
        union(){
        offset_sweep(
            rect([outerX,outerY],rounding=outer_fillet),
            height=outerZ,
            bot=os_chamfer(width=gridfinity_support?0:outer_chamfer),
            top=os_chamfer(width=gridfinity_support&&stacking_lip?
                0:
                lid?outer_chamfer:t_wallthickness/3),
            anchor="base"
        );
        
        gridfinity_stacking_lip();
        }
        
        if(lid_groove)
        lid_groove();
        
        shell_inside();
        gridfinity_bottom(is_bool=true);
        
        
        up(outerZ/2)
        zflip_copy(outerZ/2)
        watermark();
    }

}


//self explanotaory
true_outerZ=gridfinity_support&&stacking_lip?outerZ+4.75:outerZ;


module textured_shell(){
    
    
    
    diff_scaled_textures=["hexagon","cubes","noise"];
    
    diff_scaled_tex_factor=in_list(texture_pattern,diff_scaled_textures)?(rotate_texture?1/root3:root3):1;
    
    shell_circumference=path_length(Tsketch,closed=true);
    
    //calculates how many tiles are wraped around the shell
    horizontal_tiles=round(shell_circumference/texture_scale);
    
    //how big the tiles actually are
    real_texture_scale=shell_circumference/horizontal_tiles;
    
    function ceil_to_tile(value,multiple=real_texture_scale*diff_scaled_tex_factor)=ceil(value/multiple)*multiple;
    
    //calculates the height so that the tiles are correctly scaled
    ideal_height=ceil_to_tile(true_outerZ);
    
    rot_var=rotate_texture?90:0;
    
    
    
    intersection(){
        
            
            basic_shell();
            
            
            
            //texture presets are configured here
            if(texture_pattern=="cubes")
            linear_sweep(
                Tsketch,
                tex_rot=rot_var,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=("cubes"), 
                h=ideal_height,
                tex_samples=round_to((texture_scale*$fn)/60,1),
                tex_size=[real_texture_scale,real_texture_scale*diff_scaled_tex_factor],
                style="quincunx"
            )
            ;
            
            if(texture_pattern=="hexagon")
            linear_sweep(
                Tsketch,
                tex_rot=rot_var,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=("hex_grid"), 
                h=ideal_height,
                tex_samples=round_to((texture_scale*$fn)/60,1),
                tex_size=[real_texture_scale,real_texture_scale*diff_scaled_tex_factor],
                style="concave"
            );
            
            
            
            if(texture_pattern=="trunc diamonds")
            linear_sweep(
                Tsketch,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=rotate_texture?texture("trunc_pyramids_vnf",border=0.15):("trunc_diamonds"), 
                h=ideal_height,
                tex_samples=round_to((texture_scale*$fn)/40,1),
                tex_size=[real_texture_scale,real_texture_scale],
                style="concave"
            );
            
            
            if(texture_pattern=="diamonds")
            linear_sweep(
                Tsketch,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=rotate_texture?"pyramids_vnf":texture("diamonds_vnf"), 
                h=ideal_height,
                tex_samples=2,
                tex_size=[real_texture_scale,real_texture_scale],
                style="concave"
            );
            
            if(texture_pattern=="stripes")
            linear_sweep(
                Tsketch,
                tex_rot=rot_var,
                tex_inset=.5,
                tex_depth=abs(tex_depth),
                texture=diag_stripes_vnf(), 
                tex_samples=round_to((texture_scale*$fn)/40,1),
                h=ideal_height,
                tex_size=[real_texture_scale,real_texture_scale],
                style="alt"
            );
            
            if(texture_pattern=="ribs")
            linear_sweep(
                Tsketch,
                tex_rot=rot_var,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=texture("trunc_ribs_vnf", gap=1/3, border=1/6), 
                tex_samples=round_to((texture_scale*$fn)/40,1),
                h=ideal_height,
                tex_size=[real_texture_scale,real_texture_scale],
                style="concave"
            );
            
            if(texture_pattern=="noise")
            linear_sweep(
                Tsketch,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=texture("rough"),
                h=ceil_to_tile(true_outerZ,multiple=real_texture_scale*8),
                tex_size=[real_texture_scale*8,real_texture_scale*8],
                style="convex"
            );
            
            
            if(texture_pattern=="wave")
            linear_sweep(
                Tsketch,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=texture("hills",round_to((texture_scale*$fn)/32,1)),
                h=ideal_height,
                tex_size=[real_texture_scale,real_texture_scale],
                style="default"
            );
            
            if(texture_pattern=="round ribs")
            linear_sweep(
                Tsketch,
                tex_rot=rot_var,
                tex_inset=.5,
                tex_depth=tex_depth,
                texture=half_pillars(), 
                h=ideal_height,
                tex_samples=rotate_texture?(max(round(texture_scale*$fn/32),2)):2,
                tex_size=[real_texture_scale,real_texture_scale],
            );
            
            
            
    }
    ; 
}


module complex_shell(){
    
    
    
    inset_fix = 1-((abs(tex_depth)/2)/t_wallthickness);
                
    diff_scaled_textures=["hex_scaffold"];
    
    diff_scaled_tex_factor=in_list(complex_pattern,diff_scaled_textures)?
    sqrt(3):1;//root3*1.07221
    
    shell_circumference=path_length(Tsketch,closed=true);
    
    //calculates how many tiles are wraped around the shell
    horizontal_tiles=round(shell_circumference/complex_scale);
    
    //how big the tiles actually are
    real_complex_scale=shell_circumference/horizontal_tiles;
    
    function ceil_to_tile(value,multiple=real_complex_scale*diff_scaled_tex_factor)
        =ceil(value/multiple)*multiple;
    
    //calculates the height so that the tiles are correctly scaled
    ideal_height=ceil_to_tile(true_outerZ);
    
    
    intersection(){
        if(!add_texture_to_complex_shell)
        basic_shell();
        else
        textured_shell();
        
        union(){
        
        offset_sweep(
    offset(rect([innerX,innerY],rounding=inner_fillet),r=-epsilon+t_wallthickness*extra_wall),
    height=outerZ,
    anchor="base"
);
        
        
        cuboid([outerX,outerY,wallthickness+inner_chamfer],anchor=BOT);
        if(lid)
        up(outerZ)
        cuboid([outerX,outerY,wallthickness+inner_chamfer],anchor=TOP);
        
        if(complex_pattern=="weave")
            linear_sweep(
                Tsketch,
                tex_inset=inset_fix,
                tex_depth=t_wallthickness,
                texture=diag_weave_vnf(), 
                h=ideal_height,
                tex_samples=round_to((complex_scale*$fn)/64,1),
                tex_size=[real_complex_scale,real_complex_scale]
                
            )
            ;
            
            if(complex_pattern=="hex_scaffold")
            linear_sweep(
                Tsketch,
                tex_inset=inset_fix,
                tex_depth=t_wallthickness,
                texture=hex_wall(), 
                h=ideal_height,
                tex_samples=round_to((complex_scale*$fn)/64,1),
                tex_size=[real_complex_scale,real_complex_scale*root3],
                spin=180
            )
            ;
            
            if(complex_pattern=="gyroid"){
            
            v_size=1/complex_resolution;
            
            
            vnf=
            isosurface(function(x,y,z)gyroid(x,y,z, wavelength=1),
                [-scaffold_thickness*1.2,scaffold_thickness*1.2], 1, voxel_size=v_size,closed=true);
            up(outerZ/2)
            zcopies(complex_scale*1,n=ceil(outerZ/complex_scale))
                grid_copies(complex_scale,n=[ceil(outerX/complex_scale),ceil(outerY/complex_scale)])        
                //rot([0,45,0])
                resize([complex_scale,complex_scale,complex_scale*1])
                
                vnf_polyhedron(vnf);
            }
            ;
            
            
            
            
        }
    }        
}; 

