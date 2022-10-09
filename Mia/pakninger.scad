// Pakning til Mia

$fn = $preview ? 32 : 128;

pakning_ytre_d_maks = 30;
pakning_ytre_d_min = 25;
pakning_tykkelse = 2;
pakning_bredde = 8;

hvit_innvendig = 25.3;
hvit_utvendig = 30;
hvit_tykkelse = 2.2;

difference() {
    cylinder(h=pakning_bredde, d1=pakning_ytre_d_maks, d2=pakning_ytre_d_min);
    cylinder(h=pakning_bredde, d1=pakning_ytre_d_maks-pakning_tykkelse*2, 
             d2=pakning_ytre_d_min-pakning_tykkelse*2);
}
