#!/usr/bin/perl
use strict;
use warnings;
# chdir, cwd, mkdir, rmdir
require "../FileSystem.pm";

our $dir0 = "temp";
our $home = FileSystem::getHome();

printf("Home Directory = %s\n", $home);
printf("Current Directory = %s\n", FileSystem::getCurrentDirectory());
# ワークディレクトリ
$dir0 = $home . "/" . $dir0;
FileSystem::_chdir($dir0);
printf("Current Directory = %s\n", FileSystem::getCurrentDirectory());
# ディレクトリ作成と削除
FileSystem::_mkdir("./xxx");
if (FileSystem::isDirectory("./xxx")) {
  print "mkdir OK\n";
}
else {
  print "mkdir NG\n";
}
FileSystem::_rmdir("./xxx");
if (FileSystem::isDirectory("./xxx")) {
  print "rmdir NG\n";
}
else {
  print "rmdir OK\n";
}

print "Done.\n";
