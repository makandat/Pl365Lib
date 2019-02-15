#!/usr/bin/perl
# copy, move, delete files
require "../FileSystem.pm";

my $dest = "/home/user/temp/Pl365.log";
my $dest2 = "/home/user/temp/Pl100.log";
my $src = "./Pl365.log";

FileSystem::_copy($src, $dest);
FileSystem::_move($dest, $dest2);
FileSystem::deleteFile $dest2;
print "Done.\n";
