$fn = $preview ? 8 : 32;

tekst="roysrarerot.no";
fontface="Copperplate:style=Bold";
fontsize=8;

difference() {
    import("/Users/roy/Downloads/Splashing_Pen_holder/files/Splash_Pen_holderV03.stl");
    mirror([1,0,0]) {
        linear_extrude(height=1) {
            text(tekst,font=fontface,size=fontsize,valign="center",halign="center");
        }
    }
}