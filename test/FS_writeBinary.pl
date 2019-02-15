#!/usr/bin/perl

require "../FileSystem.pm";
require "../Common.pm";

if (Common::count_args() == 0) {
  Common::stop("ファイルを指定してください。");
}

my @buff = (0x11, 0x22, 0xc3, 0xff);

my @a = Common::args();
my $filePath = $a[0];
print "$filePath\n";

FileSystem::writeBinary($filePath, \@buff);

print "Done.\n";

