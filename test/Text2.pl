#!/usr/bin/perl
use strict;
use warnings;
use Text qw(len append substring left right times);

my $s1 = "012345";
print len($s1), "\n";
my $s2 = "ABCD";
my $s3 = append($s1, $s2);
print "$s3\n";
my $s4 = substring($s3, 4, 3);
print "$s4\n";
print left($s1, 3), "\n";
print right($s1, 3), "\n";
my $s5 = times('*', 6);
print "$s5\n";

