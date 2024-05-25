$fn = $preview ? 32 : 64;

tykkelse = 2;
indre_dim = 12.5;
ytre_dim = 16;

difference() {
    cylinder(h=2, d=ytre_dim);
    cylinder(h=2, d=indre_dim);
}