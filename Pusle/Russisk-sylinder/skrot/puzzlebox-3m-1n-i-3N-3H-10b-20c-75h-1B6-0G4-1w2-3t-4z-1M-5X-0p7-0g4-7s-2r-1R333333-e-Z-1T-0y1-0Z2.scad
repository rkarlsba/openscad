// Puzzlebox by RevK, @TheRealRevK www.me.uk
// Thingiverse examples and instructions https://www.thingiverse.com/thing:2410748
// GitHub source https://github.com/revk/PuzzleBox
// Get new random custom maze gift boxes from https://www.me.uk/puzzlebox
// Created 2022-12-21T06:00:38Z 2001:700:710:aa:8000:0:4:2
// Total parts: m=3
// Part to make: n=1
// Maze on inside (hard): i
// Nubs: N=3
// Helix: H=3
// Base height: b=10
// Core diameter for content: c=20
// Core height for content: h=75
// Base thickness: B=1.6
// Base gap (Z clearance): G=0.4
// Wall thickness: w=1.2
// Maze thickness: t=3
// Maze spacing: z=4
// Maze top margin: M=1
// Maze complexity: X=5
// Thickness of park ridge to click closed: p=0.7
// General X/Y clearance: g=0.4
// Number of outer sides: s=7
// Outer rounding on ends: r=2
// Grip depth: R=1.333333
// Text has diagonal edges (very slow): Z
// Scale side text (i.e. if too long): T=1
// Extra clearance on radius for nub: y=0.1
// Extra clearance on height of nub: Z=0.2
module cuttext(){translate([0,0,-1000])minkowski(){rotate([0,0,22.5])cylinder(h=0,d1=0,d2=0,$fn=8);linear_extrude(height=1000,convexity=10)mirror([1,0,0])children();}}
module outer(h,r){e=2000;minkowski(){cylinder(r1=0,r2=e,h=e,$fn=24);cylinder(h=h-e,r=r,$fn=7);}}
scale(0.001){
// Part 1 (10.00mm to 11.20mm and 14.60mm/14.60mm base)
translate([14600,14600,0])
rotate([0,0,25.714286]){
difference(){union(){difference(){
translate([0,0,400])cylinder(r=11200,h=76200,$fn=60);translate([0,0,1600])cylinder(r=10000,h=76600,$fn=60);
}
difference(){
hull(){cylinder(r=11600,h=10000,$fn=60);translate([0,0,1000])cylinder(r=14600,h=9000,$fn=60);}
translate([0,0,1600])cylinder(r=10400,h=76600,$fn=60);
}
}
rotate([0,0,3.000000])translate([0,0,5500])rotate_extrude(convexity=10,$fn=60)translate([15933,0,0])circle(r=2667,$fn=9);
}
rotate([0,0,-124.000000])for(a=[0:120.000000:359])rotate([0,0,a])polyhedron(points=[[-1243,11030,72823],[-415,11092,72874],[415,11092,72926],[1243,11030,72977],[-1243,11030,74123],[-527,14090,74174],[527,14090,74226],[1243,11030,74277],[-1243,11030,74923],[-527,14090,74974],[527,14090,75026],[1243,11030,75077],[-1243,11030,75223],[-415,11092,75274],[415,11092,75326],[1243,11030,75377],[-1209,10732,72823],[-404,10792,72874],[404,10792,72926],[1209,10732,72977],[-1209,10732,74123],[-404,10792,74174],[404,10792,74226],[1209,10732,74277],[-1209,10732,74923],[-404,10792,74974],[404,10792,75026],[1209,10732,75077],[-1209,10732,75223],[-404,10792,75274],[404,10792,75326],[1209,10732,75377],],faces=[[20,21,17],[20,17,16],[21,22,18],[21,18,17],[22,23,19],[22,19,18],[24,25,21],[24,21,20],[25,26,22],[25,22,21],[26,27,23],[26,23,22],[28,29,25],[28,25,24],[29,30,26],[29,26,25],[30,31,27],[30,27,26],[4,20,16],[4,16,0],[23,7,3],[23,3,19],[8,24,20],[8,20,4],[27,11,7],[27,7,23],[12,28,24],[12,24,8],[31,15,11],[31,11,27],[28,12,13],[28,13,29],[0,16,17],[0,17,1],[29,13,14],[29,14,30],[1,17,18],[1,18,2],[30,14,15],[30,15,31],[2,18,19],[2,19,3],[0,1,5],[0,5,4],[4,5,9],[4,9,8],[8,9,12],[9,13,12],[1,2,6],[1,6,5],[5,6,10],[5,10,9],[9,10,14],[9,14,13],[2,3,6],[3,7,6],[6,7,11],[6,11,10],[10,11,15],[10,15,14],]);
}
}
