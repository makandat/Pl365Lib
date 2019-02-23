#!/usr/bin/perl
use strict;
use warnings;
use Text qw(money);

our $str = Text::format("%04x : %5d", 0xabcd, 10000);
print "$str\n";

$str = money(1000000);
print "$str\n";

