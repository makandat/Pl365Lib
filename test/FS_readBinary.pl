#!/usr/bin/perl

require "../FileSystem.pm";
require "../Common.pm";

if (Common::count_args() == 0) {
  Common::stop("ファイルを指定してください。");
}

my @a = Common::args();
my $filePath = $a[0];
print "$filePath\n";

my $buff = FileSystem::readBinary($filePath);

foreach (@$buff) {
  printf("%02x ", $_);
}

print "\nDone.\n";

