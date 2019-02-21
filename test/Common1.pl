#!/usr/bin/perl
use utf8;
use strict;
use Common qw(log_output count_args args);

log_output("Common1.pl test program.", "INFO");

if (count_args() == 0) {
  die "No params."
}
else {
  my @args = args();
  for (my $i = 0; $i < ($#args + 1); $i++) {
    print $args[$i], "\n";
  }
}
