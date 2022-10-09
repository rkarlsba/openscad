strings = [
    [ "GIFT", 10 ],
    [ "KONE OG", 0 ],
    [ "MANN", 0 ],
    [ "DU OG JEG", 0 ],
    [ "TROSKAP", 0 ],
    [ "FOR EVIG", 0 ],
    [ "OG ALLTID", 0 ],
];

text_size = 10;
gap = 2;
count=0;

for (count = [0:1:len(strings)-1]) {
    translate([0,count*(text_size+gap)]) {
        translate([strings[len(strings)-count-1][1], 0]) {
            echo(count);
            text(strings[len(strings)-count-1][0]);
        }
    }
}
