#!/usr/bin/perl
use strict;
use warnings;
use utf8;
require "../Common.pm";
require "../FileSystem.pm";
use constant VERSION => "1.0.0";
use constant ORGPATH => '/home/user/workspace/perl/Pl365Lib';
use constant True => 1;
use constant False => 0;

binmode(STDOUT, ":utf8");

our @modules = qw/Common.pm FileSystem.pm Text.pm DateTime.pm MySQL.pm Parameters.pm Regexp.pm WebPage.pm/;

Common::esc_print("yellow", "=== Create or unlink symbolic links ===\n");
my $a = Common::readline("Create or unlink (c/u) ? > ");
my $create = False;
if (lc($a) eq 'c') {
  $create = True;
}

my  $create_path = Common::readline("Enter the directory (FULL path) > ");
my $n = 4;
if ($create == True) {
  $a = Common::readline("Create basic symbolic links only (y/n) ? > ");
  if ($a ne 'y') {
    $n = $#modules + 1;
  }
}

# Confirming
if ($create) {
  print("\nCreate: ");
  for (my $i = 0; $i < $n; $i++) {
    print("$create_path/" . $modules[$i] . " ");
  }
  print "\n";
} else {
  print("\nUnlink: Common.pm FileSystem.pm Text.pm DateTime.pm MySQL.pm Parameters.pm Regexp.pm WebPage.pm\n");
}
print("Create Directory: $create_path\n");
$a = Common::readline("Confirm above ? (y/n) > ");
if (lc($a) ne 'y') {
  Common::stop(1, "Aborted");
}

  
if ($create) {
  for (my $i = 0; $i < $n; $i++) {
    my $orgfile = ORGPATH . "/" . $modules[$i];
    my $symfile = $create_path . "/" . $modules[$i];
      FileSystem::createSymbolicLink($orgfile, $symfile);
      printf("%d  createSymbolicLink %s, %s\n", $i, $orgfile, $symfile);
  }
}
else {
  $n = $#modules + 1;
  for (my $i = 0; $i < $n; $i++) {
    my $symfile = $create_path . "/" . $modules[$i];
    FileSystem::_unlink($symfile);
    printf("%d  unlink %s\n", $i, $symfile);
  }
}

Common::esc_print("green", "Done.\n");
exec 'ls', '-l', $create_path;  # not fork

