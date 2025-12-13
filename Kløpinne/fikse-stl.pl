#!/usr/bin/perl
# vim:ts=4:sw=4:sts=4:et:ai:fdm=marker

use strict;
use warnings;
use Fcntl qw(SEEK_SET);
use Getopt::Long qw(GetOptions);

my ($in_file, $out_file);
my ($min_x,$min_y,$min_z);

$min_x = $min_y = $min_z = 1000000;

GetOptions(
    'in-file|i=s'  => \$in_file,
    'out-file|o=s' => \$out_file,
) or die "Error in command line arguments\n";

# Input: file or STDIN (no special filename needed)
my $in_fh;
if (defined $in_file) {
    open $in_fh, '<', $in_file or die "Cannot open input '$in_file': $!\n";
} else {
    $in_fh = \*STDIN;  # Direct reference to STDIN
}

# Output: file or STDOUT
my $out_fh;
if (defined $out_file) {
    open $out_fh, '>', $out_file or die "Cannot open output '$out_file': $!\n";
} else {
    $out_fh = \*STDOUT;
}

select((select($out_fh), $| = 1)[0]);  # Autoflush output

# Fra STL-filtrukturen {{{
#
# facet normal -0.000000 -0.000000 -0.094241
#   outer loop
#     vertex 654.704834 47.534798 0.000000
#     vertex 654.567078 47.079353 0.000002
#     vertex 654.408203 47.238201 0.000002
#   endloop
# endfacet
#
# }}}

# Lese gjennom innfil for å finne maksverdier
while (my $s = <$in_fh>) {
    chomp($s);
    if ($s =~ /vertex\s+(\-?\d+\.\d+)\s+(\-?\d+\.\d+)\s+(\-?\d+\.\d+)/) {
        $min_x = $1 if ($1 < $min_x);
        $min_y = $2 if ($2 < $min_y);
        $min_z = $3 if ($3 < $min_z);
    }
}

# Spole tilbake til start i innfil
seek($in_fh, 0, SEEK_SET);

# open(my $out_fh, ">", $out_file) or
#     die "Can't open > \"$out_file\" $!";
while (my $s = <$in_fh>) {
    chomp($s);
    if ($s =~ /(.*?)vertex(\s+)(\-?\d+\.\d+)(\s+)(\-?\d+\.\d+)(\s+)(\-?\d+\.\d+)/) {
        #print("$1vertex$2$3-$min_x$4$5-$min_y$6$7-$min_z\n");
        printf("%svertex%s%f%s%f%s%f\n", $1, $2, $3-$min_x, $4, $5-$min_y, $6, $7-$min_z);

        # $2$3-$min_x$4$5-$min_y$6$7-$min_z\n");
    } else {
        print("$s\n");
    }
}

print("X minimum is $min_x\n");
print("Y minimum is $min_y\n");
print("Z minimum is $min_z\n");
