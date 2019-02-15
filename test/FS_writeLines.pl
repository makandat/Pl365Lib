#!/usr/bin/perl
use strict;
use warnings;
use utf8;

require "../FileSystem.pm";
require "../Common.pm";

my @list = qw/Abc =~  %10d callback/;

if (Common::count_args() == 0) {
  Common::stop("ファイルを指定してください。");
}

my @a = Common::args();
my $filePath = $a[0];
print"$filePath\n";

FileSystem::writeAllLines($filePath, \@list);

print "Done.\n";
