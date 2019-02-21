#!/usr/bin/perl
use strict;
use warnings;
use Common;
use Text qw(isdigit isalpha isdelim isprint tolower toupper);


print isdigit('0'), "\n";
print isdigit('a'), "\n\n";

print isalpha('0'), "\n";
print isalpha('a'), "\n\n";

print isdelim('?'), "\n";
print isdelim('a'), "\n\n";

print isprint("\t"), "\n";
print isprint('a'), "\n\n";

print tolower('AbCd'), "\n";
print toupper('AbCd'), "\n";
