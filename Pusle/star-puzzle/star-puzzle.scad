length = 60;
engraving_depth = 0.5;
tolerance = 0.15;
spacing = 5;
icon_symbols = "♚♛♜♝♞♟";
icon_font = "Apple Symbols";
index_symbols = "123456";
index_font = "Hiragino Mincho ProN:style=W3";

$fn = 32;

function reflect(shape, axis) = [
    concat(
        shape[0],
        [for(p = shape[0]) [p.x*axis.x, p.y*axis.y, p.z*axis.z]]
    ),
    concat(
        shape[1],
        [for(f = shape[1]) [for(i = [len(f)-1:-1:0]) f[i] + len(shape[0])]]
    )
];
        
function random_int(min=0, max) = floor(rands(min, max, 1)[0]);

function permutation(n) = (
  n == 0 ? (
    []
  ) : (
    let(x = random_int(max=n))
    let(rest = permutation(n-1))
    let(no_dupes = [for(i = rest) i + (i >= x ? 1 : 0) ])
    concat(x, no_dupes)
  )
);

function shuffle(items) = [for(i = permutation(len(items))) items[i]];

function gen() = shuffle([0, 1, 2, 3, 4, 5]);

S = [for(i = [1:8]) gen()];

function normalize(v) = v/norm(v);

function tri_rot(a, b, c) = (
    let(bd = normalize(b - a))
    let(bc = (b + a)/2)
    let(td = normalize(c - bc))
    let(n = cross(bd, td))
    let(phi = atan2(n.y, n.x))
    let(theta = acos(n.z))
    [[0, 0, n.z < 0 ? -90 : 90], [0, 180 + theta, phi]]
);

module piece(index, S, L=length, T=tolerance) {
    R = L/4;
    D = L/2;
    quarter = [
        [
            [0, 0, 0],
            [0, D, 0],
            [D, D, 0],
            [D, T, 0],
            [0, R, R],
            [R, R, R],
            [R + T, R, R],
            [R, R, 0],
            [R + T, R, 0],
        ],
        [
            [0, 4, 5],
            [0, 5, 7],
            [5, 6, 8, 7],
            [3, 8, 6],
            [2, 3, 6],
            [1, 2, 6, 5, 4],
        ]
    ];

    half = reflect(quarter, [-1, 1, 1]);
    shape = reflect(half, [1, 1, -1]);
    points = shape[0];
    faces = shape[1];

    icon_faces = [
        [1, 2, 6],
        [2, 3, 6],
        [11, 10, 15],
        [12, 11, 15],
        [18+2, 18+1, 18+6],
        [18+3, 18+2, 18+6],
        [18+10, 18+11, 18+15],
        [18+11, 18+12, 18+15],
    ];

    index_faces = [
        [6, 15, 1],
        [18+15, 18+6, 18+1],
    ];
    
    difference() {
        color("white")
        polyhedron(points, faces);
        
        color("red")
        for(i = [0:len(icon_faces)-1]) {
            face = icon_faces[i];
            rot = tri_rot(points[face[0]], points[face[1]], points[face[2]]);
            center = (points[face[0]] + points[face[1]] + points[face[2]])/3;
            translate(center)
            rotate(rot[1])
            rotate(rot[0])
            linear_extrude(2*engraving_depth, center=true)
            text(icon_symbols[S[i]], D/3, halign="center", valign="center", font=icon_font);
        }
        
        color("black")
        for(face = index_faces) {
            rot = tri_rot(points[face[0]], points[face[1]], points[face[2]]);
            center = (points[face[0]] + points[face[1]] + points[face[2]])/3;
            translate(center)
            rotate(rot[1])
            rotate(-rot[0])
            linear_extrude(2*engraving_depth, center=true)
            text(index_symbols[index], D/4, halign="center", valign="center", font=index_font);
        }
        
        color("black")
        for(face = index_faces) {
            rot = tri_rot(points[face[0]], points[face[1]], points[face[2]]);
            center = (points[face[0]] + points[face[1]] + points[face[2]])/3;
            translate(center)
            rotate(rot[1])
            rotate(-rot[0])
            linear_extrude(2*engraving_depth, center=true)
            text(index_symbols[index], D/4, halign="center", valign="center", font=index_font);
        }
    }
}

module piece0() {
    piece(0, [S[0][0], S[0][1], S[1][0], S[1][1], S[2][0], S[2][1], S[3][0], S[3][1]]);
}

module piece1() {
    piece(1, [S[4][0], S[4][1], S[5][0], S[5][1], S[6][0], S[6][1], S[7][0], S[7][1]]);
}

module piece2() {
    piece(2, [S[0][2], S[0][3], S[6][2], S[6][3], S[1][2], S[1][3], S[7][2], S[7][3]]);
}

module piece3() {
    piece(3, [S[3][2], S[3][3], S[5][2], S[5][3], S[2][2], S[2][3], S[4][2], S[4][3]]);
}

module piece4() {
    piece(4, [S[4][4], S[4][5], S[6][4], S[6][5], S[2][4], S[2][5], S[0][4], S[0][5]]);
}

module piece5() {
    piece(5, [S[3][4], S[3][5], S[1][4], S[1][5], S[5][4], S[5][5], S[7][4], S[7][5]]);
}

module star(assembled=false) {
    D = sqrt(2)*length/4 + spacing;
    W = length + spacing;
    
    rotate(assembled ? [90*(-1 + 1), 0, 0] : 0)
        translate(assembled ? 0 : [0, 0*D, 0])
            rotate(assembled ? 0 : [-45, 0, 0])
                piece0();
    
    rotate(assembled ? [90*(1 + 1), 0, 0] : 0)
        translate(assembled ? 0 : [0, 1*D, 0])
            rotate(assembled ? 0 : [-45, 0, 0])
                piece1();

    rotate(assembled ? [90, 0, 90] : 0)
        rotate(assembled ? [90*(-1 + 1), 0, 0] : 0)
            translate(assembled ? 0 : [0, 2*D, 0])
                rotate(assembled ? 0 : [-45, 0, 0])
                    piece2();
    
    rotate(assembled ? [90, 0, 90] : 0)
        rotate(assembled ? [90*(1 + 1), 0, 0] : 0)
            translate(assembled ? 0 : [W, 0*D, 0])
                rotate(assembled ? 0 : [-45, 0, 0])
                    piece3();

    rotate(assembled ? [90, 90, 0] : 0)
        rotate(assembled ? [90*(-1 + 1), 0, 0] : 0)
            translate(assembled ? 0 : [W, 1*D, 0])
                rotate(assembled ? 0 : [-45, 0, 0])
                    piece4();
    
    rotate(assembled ? [90, 90, 0] : 0)
        rotate(assembled ? [90*(1 + 1), 0, 0] : 0)
            translate(assembled ? 0 : [W, 2*D, 0])
                rotate(assembled ? 0 : [-45, 0, 0])
                    piece5();
}

star(false);
