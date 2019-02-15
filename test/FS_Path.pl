#!/usr/bin/perl
use strict;
use warnings;
require "../FileSystem.pm";

my $file1 = "/home/user/bin/ins_asset.rb";
my $dir1 = "/etc/acpi";

printf("getFileName = %s\n", FileSystem::getFileName($file1));
printf("getDirectoryName = %s\n", FileSystem::getDirectoryName($file1));
printf("getExtension = %s\n", FileSystem::getExtension($file1));

printf("getAbsolutePath = %s\n", FileSystem::getAbsolutePath("../"));
my $r = FileSystem::getTempFile();
printf("getTempFile = %s\n", $r);
printf("changeExt = %s\n", FileSystem::changeExt($file1, ".py"));

print "Done.\n";
