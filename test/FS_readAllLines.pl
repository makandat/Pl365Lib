#!/usr/bin/perl
use strict;
use warnings;
use utf8;

require "../FileSystem.pm";
require "../Common.pm";

if (Common::count_args() == 0) {
  Common::stop("ファイルを指定してください。");
}

my @a = Common::args();
my $filePath = $a[0];
print"$filePath\n";

my $text = FileSystem::readAllText($filePath);
print $text, "\n";

