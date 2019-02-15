#!/usr/bin/perl
# getAttr, getMode, ..
require "../FileSystem.pm";

our $file1 = "/bin/sh";
our $file2 = "/bin/ksh";
our $dir1 = "/home";
our $link1 = "/etc/localtime";

print "** $file1 **\n";
my $a = FileSystem::getAttr($file1);
printf("size = %d\n", $a->size);
printf("ctime = %d\n", $a->ctime);
printf("mode = %o\n", $a->mode);

$a = FileSystem::getAttr($link1);
print "** (symbolic) $link1 **\n";
printf("mode = %o\n", $a->mode);
printf("mtime = %d\n", $a->mtime);


print "\n** $file1 **\n";
printf "getLength = %d\n", FileSystem::getLength($file1);
printf "getUpdated = %s\n", FileSystem::getUpdated($file1);
printf "getMode = %o\n", FileSystem::getMode($file1);
printf "getOwner = %s\n", FileSystem::getOwner($file1);
printf "getGroup = %s\n", FileSystem::getGroup($file1);

print "Done.\n";
