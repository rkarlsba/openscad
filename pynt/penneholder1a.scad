$fn = $preview ? 10 : 64;

tekst="roysrarerot.no";
fontface="Copperplate:style=Bold";
fontsize=8;

difference() {
    import("/Users/roy/Nextcloud/Dokumenter/Bitraf/3D-greier/Pen_Holder/penholder.stl");
    mirror([1,0,0]) {
        linear_extrude(height=1) {
            text(tekst,font=fontface,size=fontsize,valign="center",halign="center");
        }
    }
}