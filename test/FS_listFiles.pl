#!/usr/bin/perl
use strict;
use warnings;
use FileSystem qw(getHome listFiles listDirectories);

my $home = getHome();
# ファイル一覧
my @files = listFiles($home . "/bin", "*.rb");
foreach (@files) {
  print "$_\n";
}

# サブディレクトリ一覧
my @dirs = listDirectories("/etc", "a*");
foreach (@dirs) {
  print "$_\n";
}

print "Done.\n";
