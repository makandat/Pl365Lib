#!/usr/bin/perl
use strict;
use warnings;
require "../FileSystem.pm";

my $home = FileSystem::getHome();
# ファイル一覧
my @files = FileSystem::listFiles($home . "/bin", "*.rb");
foreach (@files) {
  print "$_\n";
}

# サブディレクトリ一覧
my @dirs = FileSystem::listDirectories("/etc", "a*");
foreach (@dirs) {
  print "$_\n";
}

print "Done.\n";
