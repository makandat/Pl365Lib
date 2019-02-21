#!/usr/bin/perl
use strict;
use warnings;
use Common qw(stop esc_print);
use Regexp;

my $sre1 = '^\w+=\w+';
esc_print("blue", sprintf("Regex: %s\n", $sre1));
my $re1 = Regexp->new($sre1);

printf("ismatch 'x=0' %d\n", $re1->ismatch('x=0'));
printf("ismatch '#' %d\n", $re1->ismatch('#'));

my $sre2 = '^(.*)(at)(.*)$';
my $re2 = Regexp->new($sre2);
my $m = $re2->matches("the cat in the hat");
printf("matches : %s\n", $m) if (defined($m));

my $str2 = "1,23,4567";
printf("%s\n", Regexp::_replace($str2, ',', "\t"));

my @arr = Regexp::_split($str2, ',');
foreach (@arr) {
  print "$_\n";
}

printf("join = %s\n", Regexp::_join(\@arr, 'x'));

esc_print("blue", "Done.\n");

