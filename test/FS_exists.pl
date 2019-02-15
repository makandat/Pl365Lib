#!/usr/bin/perl
# copy, move, delete files
require "../FileSystem.pm";

our $file1 = "/bin/sh";
our $file2 = "/bin/ksh";
our $dir1 = "/home";
our $link1 = "/etc/localtime";

my $b = FileSystem::exists($file1);
printf("%d\n", $b);
my $b = FileSystem::exists($file2);
printf("%d\n", $b);
my $b = FileSystem::isFile($file1);
printf("%d\n", $b);
my $b = FileSystem::isFile($file2);
printf("%d\n", $b);
my $b = FileSystem::isDirectory($file2);
printf("%d\n", $b);
my $b = FileSystem::isDirectory($dir1);
printf("%d\n", $b);
my $b = FileSystem::isLink($dir1);
printf("%d\n", $b);
my $b = FileSystem::isLink($link1);
printf("%d\n", $b);

print "Done.\n";
