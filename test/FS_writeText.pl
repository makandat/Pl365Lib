#!/usr/bin/perl
use strict;
use warnings;
use utf8;

require "../FileSystem.pm";
require "../Common.pm";

my $text = <<EOS;
Abc =~| 009
漢字　ひらがな　カタカナ
EOS

if (Common::count_args() == 0) {
  Common::stop("ファイルを指定してください。");
}

my @a = Common::args();
my $filePath = $a[0];
print"$filePath\n";

FileSystem::writeAllText($filePath, $text);

print "Done.\n";
