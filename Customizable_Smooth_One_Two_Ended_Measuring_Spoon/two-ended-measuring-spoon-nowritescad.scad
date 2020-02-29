// vim:ts=4:sw=4:sts=4:et:ai
//
// 'Customizable Smooth One/Two Ended Measuring Spoon' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.0 (c) February 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcoe

// Version 1.1 (c) February 2020 by Roy Sigurd Karlsbakk <roy@karlsbakk.net>
// Script rewritten to use text() instead of the Write library and all assign() calls
// rewritten to normal assignment except in two cases where let() is used. Also, code
// cleanup in general for better readability.

fn=$preview?32:80;

/* [Spoon] */
spoon_shape = 1; // [0: flat (classic), 1: conical, 2: cylindrical, 3: cylindrical (short), 4: cylindrical (long), 5: spherical (experimental)]  

volume_1=15;
unit_volume_1=1; // [1.0: ml, 16.387064: cubic inch (international inch), 28.4130625: imperial fluid ounce (Imp.fl.oz.), 29.5735295625: US fluid ounce (US fl.oz.), 17.758: tablespoon (UK), 14.7867647825: tablespoon (US), 4.439: teaspoon (UK), 4.928921595: teaspoon (US), 2.75: grams of coffee, 1.17: grams of sugar, 0.89: grams of salt ]

// set to zero to get a single ended spoon
volume_2=5;
unit_volume_2=1; // [1.0:ml, 16.387064:cubic inch (international inch), 28.4130625:imperial fluid ounce (Imp.fl.oz.), 29.5735295625: US fluid ounce (US fl.oz.), 17.758: tablespoon (UK), 14.7867647825: tablespoon (US), 4.439: teaspoon (UK), 4.928921595: teaspoon (US), 2.75: grams of coffee, 1.17: grams of sugar, 0.89: grams of salt ]

function get_volume_1() = volume_1 * unit_volume_1 * adjust_volume_1;
function get_volume_2() = volume_2 * unit_volume_2 * adjust_volume_2;

/* [Label] */
label           = "ss            ts";
label_thickness = 0.6;
label_height    = 8.5;
label_font      = "Liberation Sans";

/* [Metrics] */
wall_thickness=1.5;
handle_thickness=3.5;
surrounding_width=2.5;

// zero in no hanging hole
hanging_hole_size = 3; // [0:5]
function get_hanging_hole_size()=hanging_hole_sizes[hanging_hole_size]+(volume_2==0?(hanging_hole_size==0?handle_width:4):0);

// the distance of the two bowls center - 
handle_lenght=100;
handle_width=12; //[8:20]
function get_handle_width()=min(handle_width,ra1*2+surrounding_width*2,ra2*2+surrounding_width*2);
// the distance of the bowl center to the hanging hole center - only relevant for 2 ended spoon
hanging_hole_distance=30;
echo("get_handle_width()",get_handle_width());
/* [Special] */

// Use preview for faster rendering in Customizer
part = "delete_preview_do_not_print"; // [delete_preview_do_not_print,dual_extrusion_text,print_this]
preview=(part == "delete_preview_do_not_print");


// If the printed size does to much differ, you can adjust here. It is easy to calculate: [desired volume] / [printed volume] -> adjust.
adjust_volume_1=1.0;
adjust_volume_2=1.0;

cross_cut = 0; // [0:false, 1:true]

// render a volume mash for checking the theoretical volume
reference_volume = 0; // [0:false,1:true]

/* [Hidden] */

// only used for testing, same as above 
////////////////////////////////////////////////////////////////////////////////////////////
//spoon_shape = 0; // [0: flat (classic), 1: conical, 2: cylindrical, 3: cylindrical (short), 4: cylindrical (long), 5: spherical (experimental)]  
//label = "16g coffee";
//unit_volume_1 = 2.75;
//volume_1 = 10;
//adjust_volume_1 = 0.9;
//volume_2=0;
//hanging_hole_size = 0; // [0:5]
//handle_lenght = 85;
//wall_thickness = 1.2;
//part = "print_this"; // [delete_preview_do_not_print,dual_extrusion_text,print_this]
//cross_cut = 1;
//reference_volume = 1;

////////////////////////////////////////////////////////////////////////////////////////////



reference=[14.5977,23.9123,39.6676,33.4,52.2442,34.007];
function get_volume_factor(volume) = pow(volume/reference[spoon_shape],1/3);

hanging_hole_sizes=[0,5,6.3,8,10,15];
factor1=get_volume_factor(get_volume_1());
factor2=get_volume_factor(get_volume_2());

echo("factor: ",factor1,factor2);

radii = [
    [40,40,0.000000001],
    [40,28,20],
    [40,40,20],
    [40,40,15],
    [40,40,30],
    [28,40,20],
];

ra1=(radii[spoon_shape][0]*factor1+2*wall_thickness-handle_thickness/2)/2;
ra2=volume_2>0?(radii[spoon_shape][0]*factor2+2*wall_thickness-handle_thickness/2)/2:get_hanging_hole_size();

echo("ra: ",ra1,ra2);

// preview[view:south east, tilt:top diagonal]
echo("Preview", preview, "fn", fn);
echo("get_hanging_hole_size()",get_hanging_hole_size());

module interconnect() {
    h = handle_thickness;
    d = get_hanging_hole_size();
    b = (ra2+surrounding_width)-1;
    a = (ra1+surrounding_width)-1;
    c = get_handle_width()-surrounding_width*2;
    c2 = d-surrounding_width/2;
    l = handle_lenght;
    $fn = fn;
    // http://www.wolframalpha.com/input/?i=%28a%2Br%29^2%3Dm^2%2B%28c%2Br%29^2%2C%28b%2Br%29^2%3Dn^2%2B%28c%2Br%29^2%2Cl%3Dn%2Bm
    m = (-sqrt(-(a*b-a*c-b*c+c*c)*(a*a-2*a*b+b*b-l*l))+a*l-c*l)/(a-b);
    n = l-m;
    r = (-a*a+c*c+m*m)/2/(a-c);
    m2 = (-sqrt(-(d*a-d*c2-a*c2+c2*c2)*(d*d-2*d*a+a*a-hanging_hole_distance*hanging_hole_distance))+d*hanging_hole_distance-c2*hanging_hole_distance)/(d-a);
    n2 = hanging_hole_distance-m2;
    r2 = (-d*d+c2*c2+m2*m2)/2/(d-c2);

    minkowski() {
        translate([0,0,preview?0:h*.7/2.4])
            linear_extrude(preview?h:h/2.4,convexity=10)
                difference() {
                    echo("extra_hole",hanging_hole_distance,n,m,r);
            
                    union() {
                        circle(r=a);
                    
                        translate([l,0])
                            circle(r=b);
                
                        if (volume_2>0)
                            translate([-hanging_hole_distance,0])
                                circle(r=d);
                                    
                        let(x1=a/(a+r)*m)
                            let(x2=l-b/(b+r)*n)
                                translate([x1,-(c+r)])
                                    square([x2-x1,2*(c+r)]);

                        if (volume_2>0 && hanging_hole_size>0)
                            let(x1=d/(d+r2)*m2-hanging_hole_distance)
                                let(x2=-a/(a+r2)*n2)
                                    translate([x1,-(c2+r2)])
                                        square([x2-x1,2*(c2+r2)]);
                    }
            
                    for(y=[c+r,-c-r])
                        translate([m,y])
                            circle(r=r,$fn=2*$fn);

                    if (hanging_hole_size>0)
                        for(y=[c2+r2,-c2-r2])
                            translate([m2-hanging_hole_distance,y])
                                circle(r=r2,$fn=2*$fn);
                
                    if (hanging_hole_size>0)
                        translate([volume_2>0?-hanging_hole_distance:handle_lenght,0])
                            circle(r=(sqrt(d*8)-4)+h/2);
                }

                if (!preview)
                    for(m=[0,1])
                        mirror([0,0,m])
                            cylinder(r1=h/3,r2=0,h=h*0.7/2.4,$fn=6);
    }
}

rotate([preview?180:0,0,0]) {
    difference() {
        if (reference_volume) {
            if (volume_1 > 0)
                volume(get_volume_1(),0,60);

            if (volume_2 > 0)
                translate([ra1+ra2+5,0,0])
                    volume(get_volume_2(),0,60);
        } else {
            if (part == "dual_extrusion_text")
                build_text(0);
            else
                spoon();
        }

        if (cross_cut)
            translate([-500,-1000,-10])
                cube(1000);
    }
}

module spoon() {
    difference() {
        union() {
            interconnect();
            volume(get_volume_1(),wall_thickness);

            if (volume_2>0)
                translate([handle_lenght,0,0])
                    volume(get_volume_2(),wall_thickness);
        }   
        
        union() {
            translate([0,0,preview?-0.02:0])
                volume(get_volume_1(),0,60);

            if (volume_2>0)
                translate([handle_lenght,0,preview?-0.02:0])
                    volume(get_volume_2(),0,60);

            build_text(.1);
        }   
    }
}

module build_text(extra_thickness=.1) {
    translate([(volume_2>0?(handle_lenght-(ra2+surrounding_width)-(ra1+surrounding_width))/2:0)+(ra1+surrounding_width),volume_2>0?0:label_height/2,(label_thickness-extra_thickness)/(volume_2>0?2:1)])
        rotate([180,0,0])
            linear_extrude(height=label_thickness)
                text(text=label, font=label_font, size=label_height, halign="center",valign="center");
}


module volume(volume,offset,max=90) {
    factor=get_volume_factor(volume);
    d1=radii[spoon_shape][0]*factor+2*offset;
    d2=radii[spoon_shape][1]*factor+2*offset;
    h1=radii[spoon_shape][2]*factor;
    r3=d1/2;

    union() {
        intersection() {
            if (max<90 && !preview) {
                h2=h1+d2/2;
                r3=h2*tan(max);
                translate([0,0,-.1])
                    cylinder(r1=r3,r2=0,h=h2+.1,$fn=fn);
            }

            hull() {
                cylinder(r1=d1/2,r2=0,h=h1,$fn=fn);
                
                difference() {
                    translate([0,0,h1])
                        sphere(r=d2/2,$fn=fn);

                    translate([0,0,-d2/2+.1])
                        cube(d2,center=true);
                }
            }
        }

        if (max<90 && !reference_volume)
            translate([0,0,-10])
                cylinder(r=d1/2,h=10.1,$fn=fn);
    }
}

