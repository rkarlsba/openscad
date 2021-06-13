use <fontmetrics.scad>;

text = "Measure Text";
font = "Liberation Sans Narrow:style=Bold";
size = 10;
w = measureText(text, font=font, size=size);
h = ascender(font)-descender(font);

linear_extrude(height=2) union() {  
    difference() {
        square([w,h]);
        translate([0,-descender(font)]) drawText(text, font=font, size=size);
    }
    translate([0,-h-5]) drawText(str(w), font=font, size=size);
}

text2 = "Lorem ipsum dolor sit amet, audire admodum ne sed, wisi tractatos sea ne. Eu facer mucius debitis est.\nFalli ridens conceptam ad nec, altera insolens in quo. Eum error elitr graece ei. Facer option disputando an sed.";
size2 = 5;
width2 = 200;

b = measureWrappedTextBounds(text2,font=font,size=size2,halign="justify",width=150);
echo(b);
linear_extrude(height=2) translate([0,-h-15]) 
    difference() {
        translate(b[0]) square(b[1]);
        drawWrappedText(text2,font=font,size=size2,halign="justify",width=150);
    }

