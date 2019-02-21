#!/usr/bin/perl
use strict;
use warnings;
use FileSystem qw(getFileName getDirectoryName getExtension getAbsolutePath changeExt getTempFile);

my $file1 = "/home/user/bin/ins_asset.rb";
my $dir1 = "/etc/acpi";

printf("getFileName = %s\n", getFileName($file1));
printf("getDirectoryName = %s\n", getDirectoryName($file1));
printf("getExtension = %s\n", getExtension($file1));

printf("getAbsolutePath = %s\n", getAbsolutePath("../"));
my $r = getTempFile();
printf("getTempFile = %s\n", $r);
printf("changeExt = %s\n", changeExt($file1, ".py"));

print "Done.\n";
