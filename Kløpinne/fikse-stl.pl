#!/usr/bin/perl
# vim:ts=4:sw=4:sts=4:et:ai:fdm=marker

use strict;
use warnings;
use Fcntl qw(SEEK_SET);
use Getopt::Long qw(GetOptions);

my ($in_file, $out_file);
my ($min_x,$min_y,$min_z);
my ($fi,$fo);

$min_x = $min_y = $min_z = 1000000;

GetOptions(
    'in-file|i=s'  => \$in_file,
    'out-file|o=s' => \$out_file,
) or die "Error in command line arguments\n";

# Open input: file or stdin
my $input = $in_file // '-';
open my $in_fh, '<', $input
    or die "Cannot open input", (defined $in_file ? " '$in_file'" : ' (stdin)'), ": $!\n";

# Open output: file or stdout
my $output = $out_file // '-';
open my $out_fh, '>', $output
    or die "Cannot open output", (defined $out_file ? " '$out_file'" : ' (stdout)'), ": $!\n";

$out_fh->autoflush(1);  # Ensure immediate writes to stdout/pipe

# die "Usage: $0 --in-file FILE --out-file FILE\n"
#     unless defined $in_file && defined $out_file;

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

# Ikke overskriv noe
if ( -f $out_file) {
    print STDERR "Output file $out_file exists, giving up\n";
    exit(1);
}

# Åpne innfil
open($fi, "<", $in_file) or
    die "Can't open < \"$in_file\" $!";

# Lese gjennom innfil for å finne maksverdier
while (my $s = <$fi>) {
    if ($s =~ /\s+vertex\s+(\d+\.\d+)\s+(\d+\.\d+)\s+(\d+\.\d+)/) {
        $min_x = $1 if ($1 < $min_x);
        $min_y = $2 if ($2 < $min_y);
        $min_z = $3 if ($3 < $min_z);
    }
}

# Spole tilbake til start i innfil
seek($fi, 0, SEEK_SET);

# open(my $fo, ">", $out_file) or
#     die "Can't open > \"$out_file\" $!";
while (my $s = <$fi>) {
    if ($s =~ /\s+vertex\s+(\d+\.\d+)/) {
        $min_x = $1 if ($1 < $min_x);
    }
}


print("X minimum is $min_x\n");
print("Y minimum is $min_y\n");
print("Z minimum is $min_z\n");
