#!/usr/bin/perl
use utf8;
use strict;
require "../Common.pm";

Common::log_output("Common1.pl test program.", "INFO");

if (Common::count_args() == 0) {
  die "No params."
}
else {
  my @args = Common::args();
  for (my $i = 0; $i < ($#args + 1); $i++) {
    print $args[$i], "\n";
  }
}
